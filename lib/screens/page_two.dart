import 'package:climbing_app/bouldering_route_bloc/bouldering_route_bloc.dart';
import 'package:climbing_app/bouldering_route_repository/bouldering_route_model.dart';
import 'package:climbing_app/bouldering_route_repository/bouldering_route_repository.dart';
import 'package:climbing_app/logic/route_colors.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/screens/boulder_routes_page.dart';
import 'package:climbing_app/widgets/custom_app_bar.dart';
import 'package:climbing_app/widgets/drawer_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  final BoulderingRouteRepository _boulderingRouteRepository = BoulderingRouteRepository();

  List<BoulderingRoute> _boulderingRoutesList = <BoulderingRoute>[];

  @override
  void initState() {
    getBoulderingRoutes();
    super.initState();
  }

  Future<void> getBoulderingRoutes() async {
    try {
      _boulderingRoutesList = await _boulderingRouteRepository.getAll();
      _boulderingRoutesList.sort((a, b) => a.routeName.compareTo(b.routeName));
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
      body: _boulderingRoutesList.isNotEmpty
          ? ListView.builder(
              itemCount: _boulderingRoutesList.length,
              prototypeItem: ListTile(
                title: Text(_boulderingRoutesList.first.routeName),
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Center(
                    child: Text(_boulderingRoutesList[index].routeName),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => BoulderingRouteBloc(context.read<BoulderingRouteRepository>()),
                          child: BoulderRoutesPage(
                            routeID: _boulderingRoutesList[index].routeID!,
                            routeName: _boulderingRoutesList[index].routeName,
                            routeColor: RouteColors().getColorsBasedOnDifficulty(_boulderingRoutesList[index].routeName),
                          ),
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
