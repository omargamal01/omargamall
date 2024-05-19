part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class DeleteFlightState extends HomeState {}
class GetAllFlightsAdminLoading extends HomeState {}
class GetAllFlightsAdminSuccess extends HomeState {}
