import 'package:climbing_app/bouldering_route_bloc/bouldering_route_bloc.dart';
import 'package:climbing_app/bouldering_route_repository/bouldering_route_repository.dart';
import 'package:climbing_app/logic/enum.dart';
import 'package:climbing_app/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/widgets/custom_app_bar.dart';
import 'package:climbing_app/widgets/drawer_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BoulderRoutesPage extends StatelessWidget {
  final String routeID;
  final String routeName;
  final Color routeColor;

  BoulderRoutesPage({
    super.key,
    required this.routeID,
    required this.routeName,
    required this.routeColor,
  });

  final BoulderingRouteRepository _boulderingRouteRepository = BoulderingRouteRepository();
  final GlobalKey<SliderWidgetState> _childKey = GlobalKey<SliderWidgetState>();

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  Future<void> _dialogBuilder(BuildContext contextBoulderRoutesPage) {
    int routeNameIndex = boulderingGradesEnum.indexOf(routeName);
    int min = routeNameIndex < 3 ? 0 : routeNameIndex - 3;
    int max = routeNameIndex > 14 ? 17 : routeNameIndex + 3;

    return showDialog<Dialog>(
      context: contextBoulderRoutesPage,
      builder: (BuildContext contextDialog) {
        return Center(
          child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
            ),
            width: deviceWidth(contextBoulderRoutesPage) * 0.9,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Grade the route:',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none,
                  ),
                ),
                SliderWidget(
                  key: _childKey,
                  min: min,
                  max: max,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        _boulderingRouteRepository.editBoulderingRoute(routeID: routeID, gradedDifficulty: _childKey.currentState!.returnState());
                        Future.delayed(const Duration(milliseconds: 100), () async {
                          contextBoulderRoutesPage.read<BoulderingRouteBloc>().add(BoulderingRouteLoadEvent(routeID: routeID, routeName: routeName));
                        });
                        Navigator.of(contextDialog).pop();
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(contextDialog).textTheme.labelLarge,
                      ),
                      child: const Text('No Thanks'),
                      onPressed: () {
                        Navigator.of(contextDialog).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<BoulderingRouteBloc>().add(BoulderingRouteLoadEvent(routeID: routeID, routeName: routeName));

    return Scaffold(
      appBar: CustomAppBar(
        title: routeName,
        color: routeColor,
        showProfile: false,
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    onPressed: () => _dialogBuilder(context),
                    child: const Text("Flashed"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _dialogBuilder(context),
                  child: const Text("Done"),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Other climbers' difficulty grading:")],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: deviceWidth(context) * 0.8,
                  child: BlocBuilder<BoulderingRouteBloc, BoulderingRouteState>(
                    builder: (context, state) {
                      return SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        primaryXAxis: const CategoryAxis(
                          interval: 1,
                          majorTickLines: MajorTickLines(width: 0.0),
                          majorGridLines: MajorGridLines(width: 0.0),
                        ),
                        primaryYAxis: const NumericAxis(
                          interval: 1,
                          isVisible: false,
                        ),
                        series: <CartesianSeries>[
                          ColumnSeries<dynamic, String>(
                            dataSource: state.boulderingRoute,
                            xValueMapper: (dynamic data, _) => data.x,
                            yValueMapper: (dynamic data, _) => data.y,
                            width: 0.6,
                            dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                margin: EdgeInsets.all(0),
                                borderRadius: 0,
                                showZeroValue: false,
                                labelPosition: ChartDataLabelPosition.inside),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Container(
            width: deviceWidth(context) * 1,
            height: 40,
            color: const Color.fromRGBO(0, 0, 0, 1),
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
