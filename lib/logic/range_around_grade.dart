import 'dart:collection';

import 'package:climbing_app/logic/enum.dart';

class RangeAroundGrade {
  Map<dynamic, dynamic> getRangeAroundGrade(String routeName, Map<dynamic, dynamic> gradedDifficultiesMap) {
    Map<dynamic, dynamic> limitedRangeGradedDifficultiesMap = {};
    List<String> temp = [];
    int routeNameIndex = boulderingGradesEnum.indexOf(routeName);
    int routeNameIndexMin = routeNameIndex < 3 ? 0 : routeNameIndex - 3;
    int routeNameIndexMax = routeNameIndex > 14 ? 17 : routeNameIndex + 4;

    for (var i = routeNameIndexMin; i < routeNameIndexMax; i++) {
      temp.add(boulderingGradesEnum[i]);
    }
    gradedDifficultiesMap.forEach((key, value) {
      if (temp.contains(key)) {
        limitedRangeGradedDifficultiesMap[key] = value;
      }
    });

    return SplayTreeMap<String, dynamic>.from(limitedRangeGradedDifficultiesMap, (a, b) => a.compareTo(b));
  }
}
