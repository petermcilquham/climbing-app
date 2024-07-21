part of 'bouldering_route_bloc.dart';

class BoulderingRouteState extends Equatable {
  const BoulderingRouteState({
    this.boulderingRoute,
  });

  final List<dynamic>? boulderingRoute;

  @override
  List<Object?> get props => [boulderingRoute];
}

final class BoulderingRouteInitial extends BoulderingRouteState {}
