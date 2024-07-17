import 'package:climbing_app/bouldering_route_repository/bouldering_route_model.dart';
import 'package:climbing_app/bouldering_route_repository/bouldering_route_repository.dart';
import 'package:climbing_app/logic/route_colors.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/screens/boulder_routes_page.dart';
import 'package:climbing_app/widgets/custom_app_bar.dart';
import 'package:climbing_app/widgets/drawer_widget.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  final BoulderingRouteRepository _boulderingRouteRepository =
      BoulderingRouteRepository();

  List<BoulderingRoute> boulderingRoutesList = <BoulderingRoute>[];

  @override
  void initState() {
    getBoulderingRoutes();
    super.initState();
  }

  Future<void> getBoulderingRoutes() async {
    try {
      boulderingRoutesList =
          await _boulderingRouteRepository.getBoulderingRoutes();
      setState(() {});
    } catch (e) {
      print('Error fetching routes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Page Two',
        color: Color.fromRGBO(255, 0, 0, 1),
        showProfile: true,
      ),
      drawer: const DrawerWidget(),
      body: boulderingRoutesList.isNotEmpty
          ? ListView.builder(
              itemCount: boulderingRoutesList.length,
              prototypeItem: ListTile(
                title: Text(boulderingRoutesList.first.officialDifficulty),
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Center(
                    child: Text(boulderingRoutesList[index].officialDifficulty),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BoulderRoutesPage(
                          routeName:
                              boulderingRoutesList[index].officialDifficulty,
                          routeDifficulties: boulderingRoutesList[index]
                              .boulderingRouteDifficulty,
                          routeAvgDifficulty:
                              boulderingRoutesList[index].avgDifficulty,
                          routeColor: RouteColors().getColorsBasedOnDifficulty(
                              boulderingRoutesList[index].avgDifficulty),
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(child: Text("No routes found")),
    );
  }
}

// class PageTwo extends StatelessWidget {
//   const PageTwo({super.key});
// }
