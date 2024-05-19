import 'package:airplane/core/utils/app_strings.dart';
import 'package:airplane/models/flight_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<FlightModel> flightList = [];

  Future<void> getAllFlights() async {
    emit(GetAllFlightsAdminLoading());
    FirebaseFirestore.instance
        .collection(AppStrings.flights)
        .snapshots()
        .listen((event) {
      flightList.clear();
      for (var element in event.docs) {
        FlightModel flightModel = FlightModel.fromJson(element.data());
        flightList.add(flightModel);
      }
      emit(GetAllFlightsAdminSuccess());
    });
  }

  Future<void> deleteFlight({required String id })async{
    FirebaseFirestore.instance.runTransaction((transaction) async{
      DocumentReference documentReference = FirebaseFirestore.instance.collection(AppStrings.flights).doc(id);
      transaction.delete(documentReference);
    });
    emit(DeleteFlightState());
  }
}
