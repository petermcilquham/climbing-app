import 'package:climbing_app/bouldering_route_repository/bouldering_route_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BoulderingRouteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BoulderingRoute>> getAll() async {
    List<BoulderingRoute> fetchedBoulderingRoutes = <BoulderingRoute>[];

    final QuerySnapshot<Map<String, dynamic>> data = await _firestore.collection('bouldering_routes').get();

    for (var boulderingRouteData in data.docs) {
      final BoulderingRoute boulderingRoute = BoulderingRoute(
        routeID: boulderingRouteData.id,
        routeName: boulderingRouteData['routeName'],
        gradedDifficultiesMap: boulderingRouteData['gradedDifficultiesMap'],
      );
      fetchedBoulderingRoutes.add(boulderingRoute);
    }

    return fetchedBoulderingRoutes;
  }

  Future<Map<dynamic, dynamic>> getBoulderingRouteGradedDifficultiesMapByRouteID(String routeID) async {
    Map<dynamic, dynamic> fetchedBoulderingRouteGradedDifficultiesMap = {};

    final DocumentSnapshot data = await _firestore.collection('bouldering_routes').doc(routeID).get();

    fetchedBoulderingRouteGradedDifficultiesMap = data['gradedDifficultiesMap'];
    return fetchedBoulderingRouteGradedDifficultiesMap;
  }

  Future<void> saveBoulderingRoute({
    required String routeID,
    required String routeName,
    required List<dynamic> gradedDifficulties,
  }) async {
    await _firestore.collection('bouldering_routes').doc(routeID).set({'routeName': routeName});
    for (var element in gradedDifficulties) {
      await _firestore.collection('bouldering_routes').doc(routeID).update({'gradedDifficultiesMap.$element': 0});
    }
  }

  Future<void> editBoulderingRoute({
    required String routeID,
    required String gradedDifficulty,
  }) async {
    final DocumentSnapshot data = await _firestore.collection('bouldering_routes').doc(routeID).get();
    final int gradeCount = data['gradedDifficultiesMap.$gradedDifficulty'];
    await _firestore.collection("bouldering_routes").doc(routeID).update({
      'gradedDifficultiesMap.$gradedDifficulty': gradeCount + 1,
    });
  }

  Future<void> deleteBoulderingRoute() async {}
}
