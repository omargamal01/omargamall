part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class ChangeCurrentIndexState extends MainState {}
class GetAllFlightsLoading extends MainState {}
class GetAllFlightsSuccess extends MainState {}


class GetAllNotificationsLoading extends MainState {}
class GetAllNotificationsSuccess extends MainState {}

class GetUserInfoLoading extends MainState {}
class GetUserInfoSuccess extends MainState {}

class UpdateUserInfoSuccess extends MainState {}