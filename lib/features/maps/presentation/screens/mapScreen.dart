import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:car_rental/features/cars/data/models/car_model.dart';
import 'package:car_rental/features/maps/service/locationService.dart';

class MapScreen extends StatefulWidget {
  final Cars car;

  const MapScreen({super.key, required this.car});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng? userLocation;
  final List<Marker> _markers = [];
  Set<Polygon> polygons ={};

  // هذه الدالة تجيب موقع المستخدم من GPS
  Future<void> getUserLocation() async {
    try {
      final Position position = await LocationService.determinePosition();
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
      });

      await addMarkers(); // بعد ما نجيب الموقع نضيف الماركرات
      addPolygons();//add polygons
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ما قدرنا نجيب موقعك")),
      );
    }
  }
  // add polygons
  Future<void> addPolygons()async{
    if(userLocation==null) return;
    polygons.add(Polygon(polygonId: PolygonId("base"),points: [
      userLocation!,
      LatLng(widget.car.owner.lat, widget.car.owner.lng),
    ]));
    setState(() {});
}
  // هذه الدالة تضيف الماركرات على الخريطة
  Future<void> addMarkers() async {
    _markers.clear();

    // صورة مخصصة لماركر السيارة
    final Uint8List carIcon = await LocationService.getImageFromAsset('assets/cars.png', 100);

    // ماركر السيارة
    _markers.add(
      Marker(
        markerId: MarkerId("car"),
        icon: BitmapDescriptor.bytes(carIcon),
        position: LatLng(widget.car.owner.lat, widget.car.owner.lng),
        infoWindow: InfoWindow(title: "سيارة"),
      ),
    );

    // ماركر المستخدم
    if (userLocation != null) {
      _markers.add(
        Marker(
          markerId: MarkerId("user"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          position: userLocation!,
          infoWindow: InfoWindow(title: "أنت هنا"),
        ),
      );
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserLocation(); // أول ما الصفحة تفتح نبدأ بجلب الموقع
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.car.owner.lat, widget.car.owner.lng),
          zoom: 14,
        ),
        markers: Set<Marker>.of(_markers),
        polygons:polygons ,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
