import 'package:airplane/core/utils/app_colors.dart';
import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/models/location2_model.dart';
import 'package:airplane/models/location_model.dart';
import 'package:airplane/screens/add_flight_screen/cubit/add_flight_cubit.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:airplane/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

/*
class PickLocationsScreen extends StatefulWidget {
  const PickLocationsScreen({super.key});

  @override
  State<PickLocationsScreen> createState() => _PickLocationsScreenState();
}

class _PickLocationsScreenState extends State<PickLocationsScreen> {
  late MapLatLng _markerPosition;
  late MapZoomPanBehavior _mapZoomPanBehavior;
  late MapTileLayerController _controller;

  @override
  void initState() {
    _controller = MapTileLayerController();
    _mapZoomPanBehavior = MapZoomPanBehavior(zoomLevel: 4);
    super.initState();
  }

  void updateMarkerChange(Offset position) {
    _markerPosition = _controller.pixelToLatLng(position);
    if (_controller.markersCount > 0) {
      _controller.clearMarkers();
    }
    _controller.insertMarker(0);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AddFlightCubit.get(context).setUpPermissions();
      return BlocConsumer<AddFlightCubit, AddFlightState>(
        listener: (context, state) {
          if(state is AddPathLocationToList){
            AppConstant.showToast(msg: "Location Added Successfully",color: Colors.green);
          }
        },
        builder: (context, state) {
          AddFlightCubit cubit = AddFlightCubit.get(context);
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: AppText(
                  text: "Add Flight Path",
                  color: AppColors.primary,
                  textSize: 25,
                  fontWeight: FontWeight.w700),
            ),
            body: state is InitAppState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        GestureDetector(
                          onTapUp: (TapUpDetails details) async {
                            updateMarkerChange(details.localPosition);
                            cubit.addFlightPath(locationModel: LocationModel(
                                    _markerPosition.latitude,
                                    _markerPosition.longitude));
                          },
                          child: SfMaps(
                            layers: [
                              MapTileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                zoomPanBehavior: _mapZoomPanBehavior,
                                initialFocalLatLng: const MapLatLng(29.984106, 31.229965),
                                controller: _controller,
                                markerBuilder: (BuildContext context, int index) {
                                  return MapMarker(
                                    latitude: _markerPosition.latitude,
                                    longitude: _markerPosition.longitude,
                                    child: Icon(Icons.location_on, color: AppColors.primary),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: cubit.flightLocationList.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: CustomButton(text: "Confirm", press: (){
                              if(cubit.flightLocationList.isEmpty  || cubit.flightLocationList.length <2){
                                AppConstant.showToast(msg: "Flight should have at least 2 location" ,color: Colors.red);
                              }else{
                                Navigator.pop(context);
                              }
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
          );
        },
      );
    });
  }
}
*/

class PickLocationsScreen extends StatefulWidget {
  const PickLocationsScreen({Key? key}) : super(key: key);

  @override
  State<PickLocationsScreen> createState() => _PickLocationsScreenState();
}

class _PickLocationsScreenState extends State<PickLocationsScreen> {
  List<Marker> markers = <Marker>[];

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AddFlightCubit.get(context).setUpPermissions();
      return BlocConsumer<AddFlightCubit, AddFlightState>(
        listener: (context, state) {
          if (state is AddPathLocationToList) {
            AppConstant.showCustomSnakeBar(
                context, "Airport Added Successfully", true);
          }
        },
        builder: (context, state) {
          AddFlightCubit cubit = AddFlightCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading:  InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: const Icon(Icons.arrow_back,color: Colors.black)),
            ),
            body:GoogleMap(
                mapType: MapType.terrain,
                markers: Set<Marker>.of(markers),
                onMapCreated: (v) {
                  for (var element in list) {
                    final marker = Marker(
                      markerId: MarkerId(element.title.toString()),
                      position: LatLng(element.lat ?? 0.0, element.lon ?? 0.0),
                      onTap: () {
                        cubit.addFlightPath(locationModel: element);
                      },
                      // icon: BitmapDescriptor.,
                      infoWindow: InfoWindow(
                        title: element.title,
                        snippet: element.title,
                      ),
                    );
                    markers.add(marker);
                  }
                  setState(() {});
                },
                initialCameraPosition: const CameraPosition(
                    target: LatLng(
                      29.984106,
                      31.229965,
                    ),
                    zoom: 5)),
          );
        },
      );
    });
  }

  List<LocationModel2> list = [
    LocationModel2(33.2636461, 44.2236202, "Baghdad International Airport"),
    LocationModel2(30.5450472, 47.6699113, "Basrah International Airport"),
    LocationModel2(36.2404122, 43.9465692, "Erbil International Airport"),
    LocationModel2(
        35.5614111, 45.3170114, "Sulaimaniyah International Airport"),
    LocationModel2(31.9892564, 44.403733, "Al Najaf International Airport"),
    LocationModel2(27.1799951, 33.7884013, "Hurghada International Airport"),
    LocationModel2(30.1140504, 31.4245461, "Cairo International Airport"),
    LocationModel2(25.6706441, 32.7065365, "Luxor International Airport"),
    LocationModel2(
        30.9157515, 29.6961977, "Borg El Arab International Airport"),
    LocationModel2(
        27.9794911, 34.3946305, "Sharm El Sheikh International Airport"),
    LocationModel2(25.5567175, 34.586232, "Marsa Alam International Airport"),
    LocationModel2(36.1810251, 37.2242883, "Aleppo International Airport"),
    LocationModel2(33.4101971, 36.5240588, "Damascus International Airport"),
    LocationModel2(
        35.4018343, 35.9504029, "Bassel Al Assad International Airport"),
    LocationModel2(37.0176663, 41.19800, "Kamishly  International Airport"),
    LocationModel2(
        21.6840563, 39.163484, "King Abdul Aziz  International Airport"),
    LocationModel2(24.9586204, 46.7110284, "King Khalid International Airport"),
    LocationModel2(
        26.4673966, 49.7988784, "Dammam King Fahd International Airport"),
    LocationModel2(25.287937, 49.487067, "Al-Ahsa International Airport"),
    LocationModel2(
        30.9047779, 41.1377192, "Arar Domestic International Airport"),
    LocationModel2(31.9727, 35.99157, "Amman Civil Airport Airport"),
    LocationModel2(29.6099965, 35.018937, "King Hussein Airport Airport"),
    LocationModel2(31.7238023, 36.007237, "Queen Alia Airport Airport"),
    LocationModel2(31.8205079, 36.7794154, "Muwaffaq Salti Airport Airport"),

    LocationModel2(36.699535609838335, 3.2021590000321742, "Houari Boumedienne Airport"),
    LocationModel2(35.6205473, -0.6225103852824914, "Ahmed Ben Bella International Airport"),
    LocationModel2(36.712929450000004, 5.073722154534753, "Soummam Abane Ramdane Airport"),
    LocationModel2(36.1805412, 5.325319069503637, "Setif 8 May 1945 Airport"),
    LocationModel2( 36.2750469, 6.622427769599055, "Annaba Rabah Bitat Airport"),
    LocationModel2(36.830595349999996, 7.8128447443148215, "Constantine Mohamed Boudifa Airport"),
    LocationModel2(36.1805412, 5.325319069503637, "Setif 8 May 1945 Airport"),
    LocationModel2(36.2750469, 6.622427769599055, "Constantine Mohamed Boudifa Airport"),
    LocationModel2(41.013000, 28.974800, "Istanbul Airport"),
    LocationModel2(36.886391, 30.710489, "Antalya Airport"),
    LocationModel2(36.979807, 35.289152, "Adana Airport"),
    LocationModel2(
        35.17895179725687, 3.8426377858109215, "Cherif Al Idrissi Airport"),
    LocationModel2(30.33011398262271, -9.410318081338504, "Al Massira Airport"),
    LocationModel2(33.370149814003646, -9.410318081338504,
        "Mohammed V International Airport"),
    LocationModel2(12.8252404, 45.0637593, "Aden International Airport"),
    LocationModel2(15.4807423, 15.4807423, "Sanaa international airport "),
    LocationModel2(14.6671981, 49.3743154, "Riyan airport"),
    LocationModel2(13.685833, 44.138889, "Ta izz international airport "),
    LocationModel2(
        14.7551315, 42.971052799999995, "Hodeida International Airport  "),
    LocationModel2(
        25.328435199999998, 55.5122577, "Sharjah international airport"),
    LocationModel2(
        24.258515199999998, 55.6194388, "Al ain international airport "),
    LocationModel2(25.10972199999998, 56.330555599999994,
        "Fujairah international airport"),
    LocationModel2(24.441938, 54.6500736, "Abu dhabi international airport"),
    LocationModel2(25.2531745, 55.3656738, "Dubai international airport"),
    LocationModel2(15.592942262569409, 32.552342794072175,
        "Khartoum International Airport (KRT)"),
    LocationModel2(19.43449433968574, 37.238348590258454,
        "Port Sudan New International Airport)"),
    LocationModel2(13.622182819347342, 25.329462348079243, "EL Fasher Airport"),
    LocationModel2(19.153636870891166, 30.430451276776008, "Dongola Airport"),
    LocationModel2(15.38709083622148, 36.330667551749855, "Kassala Airport"),
    LocationModel2(13.158319177386916,30.23623140576116, "El Obeid Airport"),
    LocationModel2(6.622427769599055,30.23623140576116, "6.622427769599055"),
    LocationModel2(36.8475562,10.2175601, "Carthage international airport"),
    LocationModel2(36.9760586,8.8766789, "Tabarka ain draham international airport"),
    LocationModel2(34.723604,10.68998229999, "Sfax thyna international airport"),
    LocationModel2(35.760732,10.7533046, "Monastir habib bourguiba international airport"),
    LocationModel2(33.935337700000005,8.1114654, "Tozeur nefta international airport"),
    LocationModel2(32.885353,13.180161, "Tozeur nefta international airport"),
    LocationModel2(29.044320, 15.686478, " international airport"),
    LocationModel2(24.234605, 22.915482, " international airport"),
    LocationModel2(31.003661, 13.950638, " international airport"),
    LocationModel2(25.935977, 13.599076, " international airport"),
  ];
}
