import 'package:climbing_app/bouldering_route_repository/bouldering_route_model.dart';
import 'package:climbing_app/logic/average_number.dart';
import 'package:climbing_app/logic/map_grading_count.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BoulderingRouteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AverageNumber _averageNumber = AverageNumber();
  final MapGradingCount _mapGradingCount = MapGradingCount();

  Future<List<BoulderingRoute>> getBoulderingRoutes() async {
    List<BoulderingRoute> fetchedBoulderingRoutes = <BoulderingRoute>[];

    final QuerySnapshot<Map<String, dynamic>> data = await _firestore.collection('bouldering_routes').get();

    for (var boulderingRouteData in data.docs) {
      final BoulderingRoute boulderingRoute = BoulderingRoute(
        officialDifficulty: boulderingRouteData['officialDifficulty'],
        boulderingRouteDifficulty: boulderingRouteData['difficulty'],
        avgDifficulty: _averageNumber.getAverageNumberFromList(boulderingRouteData['difficulty']),
        gradingCount: _mapGradingCount.returnMap(boulderingRouteData['difficulty']),
      );
      fetchedBoulderingRoutes.add(boulderingRoute);
    }
    return fetchedBoulderingRoutes;
  }

  Future<void> saveBoulderingRoute({
    required String officialDifficulty,
    required List<dynamic> boulderingRouteDifficulty,
    required String routeID,
  }) async {
    // await _firestore.collection('bouldering_routes').add(<String, dynamic>{
    //   'routeName': boulderingRouteName,
    //   'difficulty': boulderingRouteDifficulty,
    // });
    await _firestore.collection('bouldering_routes').doc(routeID).set({'officialDifficulty': officialDifficulty, 'difficulty': boulderingRouteDifficulty});
  }

  Future<void> editBoulderingRoute({
    required dynamic boulderingRouteDifficulty,
    required String routeID,
  }) async {
    await _firestore.collection("bouldering_routes").doc(routeID).update({
      'difficulty': FieldValue.arrayUnion([boulderingRouteDifficulty]),
    });
  }

  Future<void> deleteBoulderingRoute() async {}
}
