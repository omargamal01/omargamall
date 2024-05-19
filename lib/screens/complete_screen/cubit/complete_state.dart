part of 'complete_cubit.dart';

@immutable
abstract class CompleteState {}

class CompleteInitial extends CompleteState {}
class ChangeGenderIndexState extends CompleteState {}
class ChangeUserImageSuccess extends CompleteState {}
class UploadUserInfoData extends CompleteState {}
