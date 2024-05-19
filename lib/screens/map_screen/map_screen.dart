/*
import 'dart:async';
import 'dart:ui';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:airplane/core/utils/app_colors.dart';
import 'package:airplane/core/utils/app_size.dart';
import 'package:airplane/screens/map_screen/cubit/map_cubit.dart';
import 'package:airplane/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {


  late Completer<GoogleMapController> _controllerCompleter;
  int _currentLocationIndex = 0;
  late AnimationController _animationController;
  final int _waitTime = 2;
  final List<int> _duration = [
    2,
    2,
    2,
    2,
    2,
    2,
  ];

  @override
  void initState() {
    _controllerCompleter = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => MapCubit()..getPolyLine(),
      child: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {},
        builder: (context, state) {
          MapCubit cubit = MapCubit.get(context);
          return Scaffold(
            body: Stack(children: [
              _buildMap(cubit),
              CustomButton(
                  text: "DIaa", press: () => _moveMarker(cubit: cubit)),
            ]),
          );
        },
      ),
    );
  }

  Widget _buildMap(MapCubit cubit) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: cubit.latLngList.first, zoom: 10, bearing: 30, tilt: 80),
      polylines: {
        Polyline(
          polylineId: const PolylineId("DIaa"),
          points: cubit.polyLineCoordinates,
          color: AppColors.primary,
          width: 6,
        ),
      },
      onMapCreated: (controller) {
        cubit.initMapCreated(mController: controller);
      },
      markers: cubit.markers,
    );
  }
  void _moveMarker({required MapCubit cubit})async {
    final currentLocation = cubit.latLngList[_currentLocationIndex];
    final nextLocation = cubit.latLngList[_currentLocationIndex + 1];

    final duration = _duration[_currentLocationIndex];

    // Calculate the distance between the current and next location in meters
    final distance = Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      nextLocation.latitude,
      nextLocation.longitude,
    );

    final speed = distance / (duration * 1000);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    );

    _animationController.addListener(() async {
      final percent = _animationController.value;
      final lat =
      lerpDouble(currentLocation.latitude, nextLocation.latitude, percent);
      final lng = lerpDouble(
          currentLocation.longitude, nextLocation.longitude, percent);

      final newPosition = LatLng(lat!, lng!);

      final icon = await getBitmapDescriptorFromAssetBytes("assets/icons/flight.png", 90);


      setState(() {
        cubit.markers.removeWhere((marker) => marker.markerId.value == "monorailMarker");
        cubit.markers.add(
          Marker(
            markerId: const MarkerId("monorailMarker"),
            position: newPosition,
            icon: icon,
            rotation: getMarkerRotation(
                cubit.latLngList[_currentLocationIndex], nextLocation),
            infoWindow: const InfoWindow(
              title: 'Monorail A',
            ),
          ),
        );
      });

      final controller = await _controllerCompleter.future;
      controller.animateCamera(CameraUpdate.newLatLng(newPosition));
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Move to the next location
        _currentLocationIndex++;

        // If we're at the last location, reset the index to 0
        if (_currentLocationIndex == cubit.latLngList.length - 1) {
          _currentLocationIndex = 0;
        }

        // Wait for the specified time
        Future.delayed(Duration(seconds: _waitTime), () {
          // Start moving to the next location
          _moveMarker(cubit: cubit);
        });
      }
    });

    _animationController.forward();
      }

  double getMarkerRotation(LatLng start, LatLng end) {
    final rotation = Geolocator.bearingBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
    return rotation;
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

}
*/

import 'dart:math';

import 'package:airplane/core/utils/app_colors.dart';
import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/models/flight_model.dart';
import 'package:airplane/screens/map_screen/widget/custom_timer.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_animator/line_animator.dart';

class MapScreen extends StatefulWidget {
  final FlightModel flightModel;
  final String speed;

  const MapScreen({
    Key? key,
    required this.flightModel,
    required this.speed,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  List<LatLng> builtPoints = [];
  double markerAngle = 0.0;
  LatLng markerPoint = LatLng(0.0, 0.0);
  late List<LatLng> points;
  ValueNotifier<LatLng> latLng = ValueNotifier<LatLng>(LatLng(0.0, 0.0));
  late Duration duration;
  bool isVisible = false;

  @override
  void initState() {
    points = setUpPoints();
    duration = setUpDuration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LineAnimator(
            originalPoints: points,
            builtPoints: builtPoints,
            duration: setUpDuration(),
            isReversed: false,
            interpolateBetweenPoints: true,
            stateChangeCallback: (status, pointList) {
              if (status == AnimationStatus.completed) {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => setState(() {}));
              }
            },
            duringCallback: (newPoints, point, angle, tweenVal) {
              builtPoints = newPoints;
              markerPoint = point;
              markerAngle = angle;
              latLng.value = point;
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => setState(() {}));
            },
            child: _buildMap()),
      ),
    );
  }

  Widget _buildMap() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const AppText(text: "Show Path"),
              Switch(
                value: isVisible,
                onChanged: (value) => setState(() {
                  isVisible = !isVisible;
                }),
              ),
              const Spacer(),
              const AppText(
                  text: "Duration ", textSize: 22, fontWeight: FontWeight.w800),
              CustomTimer(duration: duration),
            ],
          ),
        ),
        Expanded(
          child: FlutterMap(
            options: MapOptions(
                center: LatLng(widget.flightModel.flightPath.first['lat'],
                    widget.flightModel.flightPath.first['lon']),
                zoom: 4),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              Visibility(
                visible: isVisible,
                child: PolylineLayer(
                  polylineCulling: false,
                  polylines: [
                    Polyline(
                        points: builtPoints,
                        strokeWidth: 2.0,
                        color: Colors.purple),
                  ],
                ),
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 180,
                    height: 180,
                    point: markerPoint,
                    builder: (ctx) => Transform.rotate(
                        angle: markerAngle,
                        child: IconButton(
                            onPressed: () {
                              Random rnd;
                              int min = 200;
                              int max = 300;
                              rnd = Random();
                              int r = min + rnd.nextInt(max - min);
                              AppConstant.showToast(msg: "Hie$r.toString()");

                              showModalBottomSheet(
                                  context: context,
                                  shape: const OutlineInputBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (context) {
                                    int finalSpeed = int.parse(widget.speed);
                                    int finalSpeed2= finalSpeed == 0 ? 1*30 : finalSpeed * 30;

                                    return Container(
                                      height: 400,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(20)),
                                          border: Border.all(
                                              color: AppColors.primary,
                                              width: 3)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20),
                                          Center(
                                            child: AppText(
                                                text: "Plane Details",
                                                textDecoration:
                                                    TextDecoration.underline,
                                                textSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary),
                                          ),
                                          const SizedBox(height: 50),
                                          AppText(
                                            text:
                                                "Plane Name: ${widget.flightModel.planeCode}",
                                            fontWeight: FontWeight.bold,
                                            textSize: 24,
                                          ),
                                          const SizedBox(height: 20),
                                          AppText(
                                            text:
                                                "Speed : $finalSpeed2 KM/H",
                                            fontWeight: FontWeight.bold,
                                            textSize: 24,
                                          ),
                                          const SizedBox(height: 20),
                                          AppText(
                                            text: "Height : ${r.toString()} KM",
                                            textSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(height: 20),
                                          AppText(
                                            text:
                                                "From : ${widget.flightModel.flightPath[0]['title']}",
                                            textSize: 18,
                                            maxLines: 2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(height: 20),
                                          AppText(
                                            text:
                                                "To : ${widget.flightModel.flightPath.last['title']}",
                                            textSize: 18,
                                            maxLines: 2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(Icons.airplanemode_active_sharp))),
                  ),
                  ...List.generate(
                    setUpPoints().length,
                    (index) => Marker(
                      width: 30,
                      height: 30,
                      point: LatLng(setUpPoints()[index].latitude,
                          setUpPoints()[index].longitude),
                      builder: (ctx) => Image.asset("assets/icons/airport.png",
                          color: AppColors.primary),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  List<LatLng> setUpPoints() {
    List<LatLng> listLatLon = [];
    for (var element in widget.flightModel.flightPath) {
      LatLng latLng = LatLng(element['lat'], element['lon']);
      listLatLon.add(latLng);
    }
    return listLatLon;
  }

  Duration setUpDuration() {
    String date = widget.flightModel.flightDate.toString();
    String startTime = widget.flightModel.startTime.toString();
    String arriveTime = widget.flightModel.arriveTime.toString();
    List<String> list = date.split("/");
    List<String> startTimeList = startTime.split(":");
    List<String> arriveTimeList = arriveTime.split(":");

    DateTime dateTimeStart = DateTime(
        int.parse(list[2]),
        int.parse(list[0]),
        int.parse(list[1]),
        int.parse(startTimeList.first),
        int.parse(startTimeList[1]));
    DateTime dateTimeEnd = DateTime(
        int.parse(list[2]),
        int.parse(list[0]),
        int.parse(list[1]),
        int.parse(arriveTimeList.first),
        int.parse(arriveTimeList[1]));

    final difference = dateTimeEnd.difference(dateTimeStart).inHours;
    int speed = int.parse(widget.speed);
    if (speed == 0) {
      Duration duration = Duration(seconds: difference);

      if(duration.inSeconds <0){
        return const Duration(seconds: 10);
      }
      return duration;
    } else {
      Duration duration = Duration(seconds: difference * speed);
      if(duration.inSeconds <0){
        return const Duration(seconds: 10);
      }
      return duration;
    }
  }
}
