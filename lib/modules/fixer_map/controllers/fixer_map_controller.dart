import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';
import 'package:systemrepair/modules/schedule_repair/models/fixer_model.dart';

abstract class FixerMapController extends BaseGetxController {
  late GoogleMapController mapController;

  List<Marker> allMarkers = [];

  RxDouble latitude = 20.998418726978528.obs;

  RxDouble longitude = 105.80076296420155.obs;

  List<FixerModel> listFixer = [];

  late StreamSubscription<Position> streamSubscription;

  void onMapCreated(GoogleMapController controller);

  void addMarker(String id, LatLng location, BitmapDescriptor icon);

  Future<void> loadDataFixer();
}