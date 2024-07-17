import 'dart:collection';

class MapGradingCount {
  Map<dynamic, dynamic> returnMap(List<dynamic> numbers) {
    var map = {};

    for (var element in numbers) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    }

    final sortedMap = SplayTreeMap<dynamic, dynamic>.from(map, (a, b) => a.compareTo(b));
    return sortedMap;
  }
}
