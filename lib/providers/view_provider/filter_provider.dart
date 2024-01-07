import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  Map<Type, Filter> filterMap = {};

  void changeFilter<T extends Filter>(Filter newFilter) {
    filterMap[T] = newFilter;
    notifyListeners();
  }

  T getFilter<T extends Filter>() {
    if (!filterMap.containsKey(T)) filterMap[T] = createFilter(T);
    return filterMap[T]! as T;
  }

  clear() {
    filterMap.clear();
  }

  createFilter(Type newFilter) {
    if (newFilter == AttendanceAllSearchFilter)
      return AttendanceAllSearchFilter();
    if (newFilter == AttendanceCompleteSearchFilter)
      return AttendanceCompleteSearchFilter();
    if (newFilter == AttendanceLateSearchFilter)
      return AttendanceLateSearchFilter();
    if (newFilter == AttendanceAbsentSearchFilter)
      return AttendanceAbsentSearchFilter();
    return null;
  }
}

abstract class Filter {}

class UserSearchFilter extends Filter {
  bool isOnlyActiveUser = false;
  bool isOnlyExecutive = false;

  bool isVisibleProgramer = false;
  bool isVisibleArt = false;
  bool isVisibleDesign = false;

  UserSearchSortType sortType = UserSearchSortType.Name;

  void copy(UserSearchFilter source) {
    isOnlyActiveUser = source.isOnlyActiveUser;
    isOnlyExecutive = source.isOnlyExecutive;
    isVisibleProgramer = source.isVisibleProgramer;
    isVisibleArt = source.isVisibleArt;
    isVisibleDesign = source.isVisibleDesign;
    sortType = source.sortType;
  }
}

enum UserSearchSortType {
  Name,
  Group,
}

class AttendanceAllSearchFilter extends UserSearchFilter {}

class AttendanceCompleteSearchFilter extends UserSearchFilter {}

class AttendanceLateSearchFilter extends UserSearchFilter {}

class AttendanceAbsentSearchFilter extends UserSearchFilter {}
