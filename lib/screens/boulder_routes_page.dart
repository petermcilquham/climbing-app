import 'package:climbing_app/bouldering_route_repository/bouldering_route_repository.dart';
import 'package:climbing_app/widgets/number_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/widgets/custom_app_bar.dart';
import 'package:climbing_app/widgets/drawer_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BoulderRoutesPage extends StatelessWidget {
  BoulderRoutesPage({
    super.key,
    required this.routeName,
    required this.gradedDifficultiesMap,
    required this.routeColor,
  });

  final String routeName;
  final Map<dynamic, dynamic> gradedDifficultiesMap;
  final Color routeColor;

  final BoulderingRouteRepository _boulderingRouteRepository = BoulderingRouteRepository();

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Grade the route:'),
          content: const NumberPickerWidget(),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                // _boulderingRouteRepository.editBoulderingRoute(
                //     boulderingRouteDifficulty: 3.2, routeID: 'route1');
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No Thanks'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [];
    gradedDifficultiesMap.forEach((key, value) {
      chartData.add(ChartData(key, value));
    });

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _dialogBuilder(context),
                  child: const Text("Flashed"),
                ),
                ElevatedButton(
                  onPressed: () => _dialogBuilder(context),
                  child: const Text("Done"),
                )
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
                  child: SfCartesianChart(
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
                      ColumnSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        width: 0.6,
                        dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            //offset: Offset(0, -15),
                            margin: EdgeInsets.all(0),
                            borderRadius: 0,
                            showZeroValue: false,
                            labelPosition: ChartDataLabelPosition.inside),
                      )
                    ],
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

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
