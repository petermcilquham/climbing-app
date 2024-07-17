import 'package:climbing_app/bouldering_route_repository/bouldering_route_repository.dart';
import 'package:climbing_app/widgets/number_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/widgets/custom_app_bar.dart';
import 'package:climbing_app/widgets/drawer_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BoulderRoutesPage extends StatelessWidget {
  BoulderRoutesPage(
      {super.key,
      required this.routeName,
      required this.routeDifficulties,
      required this.routeAvgDifficulty,
      required this.routeColor,
      required this.gradingCount});

  final String routeName;
  final List<dynamic> routeDifficulties;
  final double routeAvgDifficulty;
  final Color routeColor;
  final Map<dynamic, dynamic> gradingCount;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  final BoulderingRouteRepository _boulderingRouteRepository = BoulderingRouteRepository();

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
                _boulderingRouteRepository.editBoulderingRoute(boulderingRouteDifficulty: 3.2, routeID: 'route1');
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
    gradingCount.forEach((key, value) {
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
            child: Text('Route average difficulty: $routeAvgDifficulty'),
          ),
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
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    primaryXAxis: const NumericAxis(
                      interval: 0.1,
                      decimalPlaces: 1,
                      majorGridLines: MajorGridLines(width: 0.0),
                      tickPosition: TickPosition.inside,
                    ),
                    primaryYAxis: const NumericAxis(
                      isVisible: false,
                      interval: 1,
                      //majorGridLines: MajorGridLines(width: 0.0),
                    ),
                    series: <CartesianSeries<ChartData, num>>[
                      ColumnSeries<ChartData, num>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        width: 0.4,
                        // spacing: 0.5,
                      )
                    ],
                  ),
                ),
                // Center(
                //   child: SizedBox(
                //     width: 400,
                //     height: 100,
                //     child: ListView.builder(
                //       shrinkWrap: true,
                //       scrollDirection: Axis.horizontal,
                //       prototypeItem: SizedBox(
                //         width: 80,
                //         child: ListTile(
                //           title: Text(routeDifficulties.first.toString()),
                //         ),
                //       ),
                //       itemCount: routeDifficulties.length,
                //       itemBuilder: (context, index) {
                //         return ListTile(
                //           title: Text(routeDifficulties[index].toString()),
                //         );
                //       },
                //     ),
                //   ),
                // )
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
  final double x;
  final int y;
}
