part of 'add_flight_cubit.dart';

@immutable
abstract class AddFlightState {}

class AddFlightInitial extends AddFlightState {}
class AddPathLocationToList extends AddFlightState {}
class SetUpLocationState extends AddFlightState {}
class InitAppState extends AddFlightState {}
class AddFlightSuccessState extends AddFlightState {}
class ChooseLocationSuccess extends AddFlightState {
  final String title;

  ChooseLocationSuccess(this.title);
}


class SetUpStartSuccessState extends AddFlightState {}
class SetUpEndSuccessState extends AddFlightState {}
