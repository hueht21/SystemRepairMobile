import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../cores/const/const.dart';
import '../../schedule_repair/models/fixer_model.dart';
import 'fixer_map_controller.dart';

class FixerMapControllerImp extends FixerMapController {
  @override
  Future<void> onInit() async {
    showLoading();
    await loadDataFixer();
    await getLocation();
    await addListLocationFixer().whenComplete(() => hideLoading());
    super.onInit();
  }

  Future<void> getLocation() async {
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) async {
      Marker marker =
          allMarkers.firstWhere((marker) => marker.markerId.value == "Test3");
      allMarkers.remove(marker);
      addMarker('Test3', LatLng(position.latitude, position.longitude),
          await loadIconUser());
      latitude.value = position.latitude;
      longitude.value = position.longitude;
    });
  }

  @override
  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  Future<void> addListLocationFixer() async {

    for(var item in listFixer){

    }
    addMarker("1", const LatLng(20.98927217500758, 105.81164038126636),
        await loadIconFixer());
    addMarker("2", const LatLng(20.973398887754904, 105.80126721532376),
        await loadIconFixer());
    addMarker("3", const LatLng(20.996804670288185, 105.78585153815906),
        await loadIconFixer());
    addMarker(
        "Test3", LatLng(latitude.value, longitude.value), await loadIconUser());
  }

  @override
  void addMarker(String id, LatLng location, BitmapDescriptor icon) async {
    var maker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: const InfoWindow(
            title: "Vị trí của bạn",
            snippet: "Bạn có tìm kiếm các thợ xung quanh"),
        icon: icon);
    allMarkers.add(maker);
  }

  Future<BitmapDescriptor> loadIconFixer() async {
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(49, 49)), AppConst.iconFixer);
    return icon;
  }

  Future<BitmapDescriptor> loadIconUser() async {
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(49, 49)), AppConst.iconMapUser);
    return icon;
  }

  @override
  Future<void> loadDataFixer() async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('Fixer').get();
    if (documentSnapshot.docs.isNotEmpty) {
      listFixer.addAll(documentSnapshot.docs
          .map((user) => FixerModel.fromJson(user.data()))
          .toList());
    }
  }
}
