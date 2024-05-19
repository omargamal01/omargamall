import 'package:flutter_bloc/flutter_bloc.dart';
part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  static MapCubit get(context) => BlocProvider.of(context);

/*  var markers = HashSet<Marker>();

  List<LatLng> latLngList = const [
    LatLng(31.087201, 30.583278),
    LatLng(31.093333, 30.680541),
    LatLng(31.109513, 30.755528),
    LatLng(31.132671, 30.846625),
    LatLng(31.148162, 30.943491),
    LatLng(31.167566, 31.052689),
    LatLng(31.183393, 31.181180),
  ];

  List<LatLng> polyLineCoordinates = [];
  final georouter = GeoRouter(mode: TravelMode.driving);

  late List<LatLng> points;

  void getPolyLine() async {
    final coordinates = latLngList
        .map((e) => PolylinePoint(latitude: e.latitude, longitude: e.longitude))
        .toList();
    points = latLngList.map((e) => LatLng(e.latitude, e.longitude)).toList();

    try {
      final directions =
          await georouter.getDirectionsBetweenPoints(coordinates);
      if (directions.isNotEmpty) {
        for (var element in directions) {
          polyLineCoordinates.add(LatLng(element.latitude, element.longitude));
        }
      }
      emit(InitMapState());
    } on GeoRouterException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Completer<GoogleMapController>? controllerCompleter;

  void initMapCreated({required GoogleMapController mController}) {
    controllerCompleter = Completer();
    controllerCompleter!.complete(mController);
    for (int i = 0; i < latLngList.length; i++) {
      LatLng latLng = LatLng(latLngList[i].latitude, latLngList[i].longitude);
      markers.add(Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          position: LatLng(latLng.latitude, latLng.longitude),
          markerId: MarkerId(latLng.latitude.toString())));
    }
    emit(InitMapState());
  }*/


}
