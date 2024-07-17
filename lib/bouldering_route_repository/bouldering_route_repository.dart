import 'package:climbing_app/bouldering_route_repository/bouldering_route_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BoulderingRouteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BoulderingRoute>> getBoulderingRoutes() async {
    List<BoulderingRoute> fetchedBoulderingRoutes = <BoulderingRoute>[];

    final QuerySnapshot<Map<String, dynamic>> data =
        await _firestore.collection('bouldering_routes').get();

    for (var boulderingRouteData in data.docs) {
      final BoulderingRoute boulderingRoute = BoulderingRoute(
        officialDifficulty: boulderingRouteData['officialDifficulty'],
        boulderingRouteDifficulty: boulderingRouteData['difficulty'],
        avgDifficulty:
            (boulderingRouteData['difficulty'].reduce((a, b) => a + b)) /
                boulderingRouteData['difficulty'].length,
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
    await _firestore.collection('bouldering_routes').doc(routeID).set({
      'officialDifficulty': officialDifficulty,
      'difficulty': boulderingRouteDifficulty
    });
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
