part of 'bouldering_route_bloc.dart';

class BoulderingRouteEvent extends Equatable {
  const BoulderingRouteEvent();

  @override
  List<Object?> get props => [];
}

final class BoulderingRouteLoadEvent extends BoulderingRouteEvent {
  const BoulderingRouteLoadEvent({required this.routeID, required this.routeName});

  final String routeID;
  final String routeName;
}
