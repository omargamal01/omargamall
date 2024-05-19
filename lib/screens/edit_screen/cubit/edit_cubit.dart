import 'package:airplane/core/utils/app_strings.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditInitial());

  static EditCubit get(context) => BlocProvider.of(context);

  void updateFlightToFirestore({
    required String id,
    required String flightDate,
    required String startTime,
    required String arriveTime,
    required int capacity,
    required String plane,
  }) {
    FirebaseFirestore.instance.collection(AppStrings.flights).doc(id).update(
        {
          "flightDate": flightDate,
          "startTime": startTime,
          "arriveTime": arriveTime,
          "capacity": capacity,
          "planeCode": plane,
        }
    ).then((value) {
      emit(UpdateSuccess());
    });
  }
}
