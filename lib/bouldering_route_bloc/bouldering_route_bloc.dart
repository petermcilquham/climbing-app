import 'package:bloc/bloc.dart';
import 'package:climbing_app/bouldering_route_repository/bouldering_route_repository.dart';
import 'package:climbing_app/logic/range_around_grade.dart';
import 'package:equatable/equatable.dart';

part 'bouldering_route_event.dart';
part 'bouldering_route_state.dart';

class BoulderingRouteBloc extends Bloc<BoulderingRouteEvent, BoulderingRouteState> {
  BoulderingRouteBloc(this._boulderingRouteRepository) : super(const BoulderingRouteState()) {
    on<BoulderingRouteLoadEvent>((event, emit) async {
      Map<dynamic, dynamic> boulderingRouteGradedDifficultiesMap =
          await _boulderingRouteRepository.getBoulderingRouteGradedDifficultiesMapByRouteID(event.routeID);
      List<ChartData> chartData = [];
      Map<dynamic, dynamic> sortedMap = _rangeAroundGrade.getRangeAroundGrade(event.routeName, boulderingRouteGradedDifficultiesMap);

      sortedMap.forEach((key, value) {
        chartData.add(ChartData(key, value));
      });

      emit(BoulderingRouteState(boulderingRoute: chartData));
    });
  }

  final BoulderingRouteRepository _boulderingRouteRepository;
  final RangeAroundGrade _rangeAroundGrade = RangeAroundGrade();
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
