// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// class FlutterBlueApp extends StatelessWidget {
//   const FlutterBlueApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       color: Colors.lightBlue,
//       home: StreamBuilder<BluetoothAdapterState>(
//           stream: FlutterBluePlus.instance.adapterState,
//           initialData: BluetoothAdapterState.unknown,
//           builder: (c, snapshot) {
//             final adapterState = snapshot.data;
//             if (adapterState == BluetoothAdapterState.on) {
//               return const FindDevicesScreen();
//             }
//             return BluetoothOffScreen(adapterState: adapterState);
//           }),
//     );
//   }
// }

// class BluetoothOffScreen extends StatelessWidget {
//   const BluetoothOffScreen({Key? key, this.adapterState}) : super(key: key);

//   final BluetoothAdapterState? adapterState;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue,
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Icon(
//               Icons.bluetooth_disabled,
//               size: 200.0,
//               color: Colors.white54,
//             ),
//             Text(
//               'Bluetooth Adapter is ${adapterState != null ? adapterState.toString().split(".").last : 'not available'}.',
//               style: Theme.of(context)
//                   .primaryTextTheme
//                   .titleSmall
//                   ?.copyWith(color: Colors.white),
//             ),
//             ElevatedButton(
//               child: const Text('TURN ON'),
//               onPressed: () async {
//                 try {
//                   if (Platform.isAndroid) {
//                     FlutterBluePlus.instance.turnOn();
//                   }
//                 } catch (e) {
//                   final snackBar = SnackBar(
//                       content: Text('Error: [turnOn] ${e.toString()}'));
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FindDevicesScreen extends StatelessWidget {
//   const FindDevicesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Find Devices'),
//         actions: [
//           ElevatedButton(
//             child: const Text('TURN OFF'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               foregroundColor: Colors.white,
//             ),
//             onPressed: Platform.isAndroid
//                 ? () => FlutterBluePlus.instance.turnOff()
//                 : null,
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () => FlutterBluePlus.instance.startScan(
//             timeout: const Duration(seconds: 15),
//             androidUsesFineLocation: false),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               StreamBuilder<List<BluetoothDevice>>(
//                 stream: Stream.periodic(const Duration(seconds: 2))
//                     .asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
//                 initialData: const [],
//                 builder: (c, snapshot) => Column(
//                   children: snapshot.data!
//                       .map((d) => ListTile(
//                             title: Text(d.localName),
//                             subtitle: Text(d.remoteId.toString()),
//                             trailing: StreamBuilder<BluetoothConnectionState>(
//                               stream: d.connectionState,
//                               initialData:
//                                   BluetoothConnectionState.disconnected,
//                               builder: (c, snapshot) {
//                                 if (snapshot.data ==
//                                     BluetoothConnectionState.connected) {
//                                   return ElevatedButton(
//                                     child: const Text('OPEN'),
//                                     onPressed: () => Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 DeviceScreen(device: d))),
//                                   );
//                                 }
//                                 return Text(snapshot.data.toString());
//                               },
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               ),
//               StreamBuilder<List<ScanResult>>(
//                 stream: FlutterBluePlus.instance.scanResults,
//                 initialData: const [],
//                 builder: (c, snapshot) => Column(
//                   children: snapshot.data!
//                       .map(
//                         (r) => ScanResultTile(
//                           result: r,
//                           onTap: () => Navigator.of(context)
//                               .push(MaterialPageRoute(builder: (context) {
//                             r.device.connect().catchError((e) {
//                               final snackBar = SnackBar(
//                                   content:
//                                       Text('Error: [connect] ${e.toString()}'));
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(snackBar);
//                             });
//                             return DeviceScreen(device: r.device);
//                           })),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: StreamBuilder<bool>(
//         stream: FlutterBluePlus.instance.isScanning,
//         initialData: false,
//         builder: (c, snapshot) {
//           if (snapshot.data!) {
//             return FloatingActionButton(
//               child: const Icon(Icons.stop),
//               onPressed: () {
//                 FlutterBluePlus.instance.stopScan().catchError((e) {
//                   final snackBar = SnackBar(
//                       content: Text('Error: [stopScan] ${e.toString()}'));
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                 });
//               },
//               backgroundColor: Colors.red,
//             );
//           } else {
//             return FloatingActionButton(
//                 child: const Icon(Icons.search),
//                 onPressed: () {
//                   FlutterBluePlus.instance
//                       .startScan(
//                           timeout: const Duration(seconds: 15),
//                           androidUsesFineLocation: false)
//                       .catchError((e) {
//                     final snackBar = SnackBar(
//                         content: Text('Error: [startScan] ${e.toString()}'));
//                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                   });
//                 });
//           }
//         },
//       ),
//     );
//   }
// }

// class DeviceScreen extends StatelessWidget {
//   const DeviceScreen({Key? key, required this.device}) : super(key: key);

//   final BluetoothDevice device;

//   List<int> _getRandomBytes() {
//     final math = Random();
//     return [
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255)
//     ];
//   }

//   List<Widget> _buildServiceTiles(
//       BuildContext context, List<BluetoothService> services) {
//     return services
//         .map(
//           (s) => ServiceTile(
//             service: s,
//             characteristicTiles: s.characteristics
//                 .map(
//                   (c) => CharacteristicTile(
//                     characteristic: c,
//                     onReadPressed: () async {
//                       try {
//                         await c.read();
//                       } catch (e) {
//                         final snackBar = SnackBar(
//                             content: Text('Error: [read] ${e.toString()}'));
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                       }
//                     },
//                     onWritePressed: () async {
//                       try {
//                         await c.write(_getRandomBytes(), withoutResponse: true);
//                         if (c.properties.read) {
//                           await c.read();
//                         }
//                       } catch (e) {
//                         final snackBar = SnackBar(
//                             content: Text('Error: [write] ${e.toString()}'));
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                       }
//                     },
//                     onNotificationPressed: () async {
//                       try {
//                         await c.setNotifyValue(!c.isNotifying);
//                         if (c.properties.read) {
//                           await c.read();
//                         }
//                       } catch (e) {
//                         final snackBar = SnackBar(
//                             content: Text(
//                                 'Error: [setNotifyValue] ${e.toString()}'));
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                       }
//                     },
//                     descriptorTiles: c.descriptors
//                         .map(
//                           (d) => DescriptorTile(
//                             descriptor: d,
//                             onReadPressed: () => d.read(),
//                             onWritePressed: () => d.write(_getRandomBytes()),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 )
//                 .toList(),
//           ),
//         )
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(device.localName),
//         actions: <Widget>[
//           StreamBuilder<BluetoothConnectionState>(
//             stream: device.connectionState,
//             initialData: BluetoothConnectionState.connecting,
//             builder: (c, snapshot) {
//               VoidCallback? onPressed;
//               String text;
//               switch (snapshot.data) {
//                 case BluetoothConnectionState.connected:
//                   onPressed = () async {
//                     try {
//                       await device.disconnect();
//                     } catch (e) {
//                       final snackBar = SnackBar(
//                           content: Text('Error: [disconnect] ${e.toString()}'));
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     }
//                   };
//                   text = 'DISCONNECT';
//                   break;
//                 case BluetoothConnectionState.disconnected:
//                   onPressed = () async {
//                     try {
//                       await device.connect();
//                     } catch (e) {
//                       final snackBar = SnackBar(
//                           content: Text('Error: [connect] ${e.toString()}'));
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     }
//                   };
//                   text = 'CONNECT';
//                   break;
//                 default:
//                   onPressed = null;
//                   text = snapshot.data.toString().split(".").last.toUpperCase();
//                   break;
//               }
//               return TextButton(
//                   onPressed: onPressed,
//                   child: Text(
//                     text,
//                     style: Theme.of(context)
//                         .primaryTextTheme
//                         .labelLarge
//                         ?.copyWith(color: Colors.white),
//                   ));
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             StreamBuilder<BluetoothConnectionState>(
//               stream: device.connectionState,
//               initialData: BluetoothConnectionState.connecting,
//               builder: (c, snapshot) => ListTile(
//                 leading: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     snapshot.data == BluetoothConnectionState.connected
//                         ? const Icon(Icons.bluetooth_connected)
//                         : const Icon(Icons.bluetooth_disabled),
//                     snapshot.data == BluetoothConnectionState.connected
//                         ? StreamBuilder<int>(
//                             stream: rssiStream(),
//                             builder: (context, snapshot) {
//                               return Text(
//                                   snapshot.hasData ? '${snapshot.data}dBm' : '',
//                                   style: Theme.of(context).textTheme.bodySmall);
//                             })
//                         : Text('',
//                             style: Theme.of(context).textTheme.bodySmall),
//                   ],
//                 ),
//                 title: Text(
//                     'Device is ${snapshot.data.toString().split('.')[1]}.'),
//                 subtitle: Text('${device.remoteId}'),
//                 trailing: StreamBuilder<bool>(
//                   stream: device.isDiscoveringServices,
//                   initialData: false,
//                   builder: (c, snapshot) => IndexedStack(
//                     index: snapshot.data! ? 1 : 0,
//                     children: <Widget>[
//                       TextButton(
//                         child: const Text("Discover Services"),
//                         onPressed: () async {
//                           try {
//                             await device.discoverServices();
//                           } catch (e) {
//                             final snackBar = SnackBar(
//                                 content: Text(
//                                     'Error: [discoverServices] ${e.toString()}'));
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackBar);
//                           }
//                         },
//                       ),
//                       const IconButton(
//                         icon: SizedBox(
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation(Colors.grey),
//                           ),
//                           width: 18.0,
//                           height: 18.0,
//                         ),
//                         onPressed: null,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             StreamBuilder<int>(
//               stream: device.mtu,
//               initialData: 0,
//               builder: (c, snapshot) => ListTile(
//                 title: const Text('MTU Size'),
//                 subtitle: Text('${snapshot.data} bytes'),
//                 trailing: IconButton(
//                     icon: const Icon(Icons.edit),
//                     onPressed: () async {
//                       try {
//                         await device.requestMtu(223);
//                       } catch (e) {
//                         final snackBar = SnackBar(
//                             content:
//                                 Text('Error: [requestMtu] ${e.toString()}'));
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                       }
//                     }),
//               ),
//             ),
//             StreamBuilder<List<BluetoothService>>(
//               stream: device.services,
//               initialData: const [],
//               builder: (c, snapshot) {
//                 return Column(
//                   children: _buildServiceTiles(context, snapshot.data!),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Stream<int> rssiStream() async* {
//     var isConnected = true;
//     final subscription = device.connectionState.listen((v) {
//       isConnected = v == BluetoothConnectionState.connected;
//     });
//     while (isConnected) {
//       yield await device.readRssi();
//       await Future.delayed(const Duration(seconds: 1));
//     }
//     subscription.cancel();
//     // Device disconnected, stopping RSSI stream
//   }
// }

// class ScanResultTile extends StatelessWidget {
//   const ScanResultTile({Key? key, required this.result, this.onTap})
//       : super(key: key);

//   final ScanResult result;
//   final VoidCallback? onTap;

//   Widget _buildTitle(BuildContext context) {
//     if (result.device.localName.isNotEmpty) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             result.device.localName,
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             result.device.remoteId.toString(),
//             style: Theme.of(context).textTheme.bodySmall,
//           )
//         ],
//       );
//     } else {
//       return Text(result.device.remoteId.toString());
//     }
//   }

//   Widget _buildAdvRow(BuildContext context, String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(title, style: Theme.of(context).textTheme.bodySmall),
//           const SizedBox(
//             width: 12.0,
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodySmall
//                   ?.apply(color: Colors.black),
//               softWrap: true,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String getNiceHexArray(List<int> bytes) {
//     return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
//         .toUpperCase();
//   }

//   String getNiceManufacturerData(Map<int, List<int>> data) {
//     if (data.isEmpty) {
//       return 'N/A';
//     }
//     List<String> res = [];
//     data.forEach((id, bytes) {
//       res.add(
//           '${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
//     });
//     return res.join(', ');
//   }

//   String getNiceServiceData(Map<String, List<int>> data) {
//     if (data.isEmpty) {
//       return 'N/A';
//     }
//     List<String> res = [];
//     data.forEach((id, bytes) {
//       res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
//     });
//     return res.join(', ');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       title: _buildTitle(context),
//       leading: Text(result.rssi.toString()),
//       trailing: ElevatedButton(
//         child: const Text('CONNECT'),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.black,
//           foregroundColor: Colors.white,
//         ),
//         onPressed: (result.advertisementData.connectable) ? onTap : null,
//       ),
//       children: <Widget>[
//         _buildAdvRow(
//             context, 'Complete Local Name', result.advertisementData.localName),
//         _buildAdvRow(context, 'Tx Power Level',
//             '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
//         _buildAdvRow(context, 'Manufacturer Data',
//             getNiceManufacturerData(result.advertisementData.manufacturerData)),
//         _buildAdvRow(
//             context,
//             'Service UUIDs',
//             (result.advertisementData.serviceUuids.isNotEmpty)
//                 ? result.advertisementData.serviceUuids.join(', ').toUpperCase()
//                 : 'N/A'),
//         _buildAdvRow(context, 'Service Data',
//             getNiceServiceData(result.advertisementData.serviceData)),
//       ],
//     );
//   }
// }

// class ServiceTile extends StatelessWidget {
//   final BluetoothService service;
//   final List<CharacteristicTile> characteristicTiles;

//   const ServiceTile(
//       {Key? key, required this.service, required this.characteristicTiles})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (characteristicTiles.isNotEmpty) {
//       return ExpansionTile(
//         title: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Text('Service'),
//             Text('0x${service.serviceUuid.toString().toUpperCase()}',
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     color: Theme.of(context).textTheme.bodySmall?.color))
//           ],
//         ),
//         children: characteristicTiles,
//       );
//     } else {
//       return ListTile(
//         title: const Text('Service'),
//         subtitle: Text('0x${service.serviceUuid.toString().toUpperCase()}'),
//       );
//     }
//   }
// }

// class CharacteristicTile extends StatefulWidget {
//   final BluetoothCharacteristic characteristic;
//   final List<DescriptorTile> descriptorTiles;
//   final VoidCallback? onReadPressed;
//   final VoidCallback? onWritePressed;
//   final VoidCallback? onNotificationPressed;

//   const CharacteristicTile(
//       {Key? key,
//       required this.characteristic,
//       required this.descriptorTiles,
//       this.onReadPressed,
//       this.onWritePressed,
//       this.onNotificationPressed})
//       : super(key: key);

//   @override
//   State<CharacteristicTile> createState() => _CharacteristicTileState();
// }

// class _CharacteristicTileState extends State<CharacteristicTile> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<int>>(
//       stream: widget.characteristic.lastValueStream,
//       initialData: widget.characteristic.lastValue,
//       builder: (c, snapshot) {
//         final value = snapshot.data;
//         return ExpansionTile(
//           title: ListTile(
//             title: Row(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     const Text('Characteristic'),
//                     Text(
//                         '0x${widget.characteristic.characteristicUuid.toString().toUpperCase()}',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                             color:
//                                 Theme.of(context).textTheme.bodySmall?.color))
//                   ],
//                 ),
//                 Spacer(),
//                 if (widget.characteristic.properties.read)
//                   IconButton(
//                       icon: Icon(
//                         Icons.file_download,
//                         color:
//                             Theme.of(context).iconTheme.color?.withOpacity(0.5),
//                       ),
//                       onPressed: () {
//                         widget.onReadPressed!();
//                         setState(() {});
//                       }),
//                 if (widget.characteristic.properties.write)
//                   IconButton(
//                       icon: Icon(Icons.file_upload,
//                           color: Theme.of(context)
//                               .iconTheme
//                               .color
//                               ?.withOpacity(0.5)),
//                       onPressed: () {
//                         widget.onWritePressed!();
//                         setState(() {});
//                       }),
//                 if (widget.characteristic.properties.notify ||
//                     widget.characteristic.properties.indicate)
//                   TextButton(
//                       child: Text(widget.characteristic.isNotifying
//                           ? "Unsubscribe"
//                           : "Subscribe"),
//                       onPressed: () {
//                         widget.onNotificationPressed!();
//                         setState(() {});
//                       })
//               ],
//             ),
//             subtitle: Text(value.toString()),
//             contentPadding: const EdgeInsets.all(0.0),
//           ),
//           children: widget.descriptorTiles,
//         );
//       },
//     );
//   }
// }

// class DescriptorTile extends StatelessWidget {
//   final BluetoothDescriptor descriptor;
//   final VoidCallback? onReadPressed;
//   final VoidCallback? onWritePressed;

//   const DescriptorTile(
//       {Key? key,
//       required this.descriptor,
//       this.onReadPressed,
//       this.onWritePressed})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const Text('Descriptor'),
//           Text('0x${descriptor.descriptorUuid.toString().toUpperCase()}',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   color: Theme.of(context).textTheme.bodySmall?.color))
//         ],
//       ),
//       subtitle: StreamBuilder<List<int>>(
//         stream: descriptor.lastValueStream,
//         initialData: descriptor.lastValue,
//         builder: (c, snapshot) => Text(snapshot.data.toString()),
//       ),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.file_download,
//               color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
//             ),
//             onPressed: onReadPressed,
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.file_upload,
//               color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
//             ),
//             onPressed: onWritePressed,
//           )
//         ],
//       ),
//     );
//   }
// }

// class AdapterStateTile extends StatelessWidget {
//   const AdapterStateTile({Key? key, required this.adapterState})
//       : super(key: key);

//   final BluetoothAdapterState adapterState;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.redAccent,
//       child: ListTile(
//         title: Text(
//           'Bluetooth adapter is ${adapterState.toString().split(".").last}',
//           style: Theme.of(context).primaryTextTheme.titleSmall,
//         ),
//         trailing: Icon(
//           Icons.error,
//           color: Theme.of(context).primaryTextTheme.titleSmall?.color,
//         ),
//       ),
//     );
//   }
// }
