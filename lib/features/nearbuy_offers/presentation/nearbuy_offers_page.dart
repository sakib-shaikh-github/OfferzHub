import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mappls_gl/mappls_gl.dart';
import 'package:offers_hub/utilis/snackbar.dart';
import 'package:offers_hub/utilis/toast.dart';

class NearbuyOPage extends StatefulWidget {
  const NearbuyOPage({super.key});

  @override
  State<NearbuyOPage> createState() => _NearbuyOPageState();
}

List<List> showImgs = [
  [
    'assets/general/hotel_broadway.jpeg',
    LatLng(19.052920, 72.899400)
  ], // Hotel Broadway
  [
    'assets/general/kstar.png',
    LatLng(19.053134107203, 72.898175218857)
  ], //Kstar mall
  [
    'assets/general/dultimate.png',
    LatLng(19.226625585427, 73.11699472413)
  ], //DUltimateBurger
  [
    'assets/general/pizza_tablespoon.png',
    LatLng(19.097686, 72.889355)
  ], //Pizza kitchen by 1 tablespoon
  ['assets/general/food_arcade.png', LatLng(19.0333, 72.85)] //Food Arcade
];

class _NearbuyOPageState extends State<NearbuyOPage> {
  late final MapplsMapController mapController;
  LatLng currentLatLng = LatLng(19.076090, 72.877426);

  @override
  void initState() {
    super.initState();
    nDetermineP();
  }

  nDetermineP() async {
    try {
      await determinePosition();
      currentLatLng = LatLng(userPosition!.latitude, userPosition!.longitude);
    } catch (e) {
      AppSnackBar.showSnackBar('Error fetching current location',
          colorGreen: false);
    }
  }

  Future<void> addImageFromAsset() async {
    for (var i = 0; i < 5; i++) {
      final ByteData bytes = await rootBundle.load(showImgs[i][0]);
      final Uint8List list = bytes.buffer.asUint8List();
      await mapController.addImage("assetImage$i", list);
      mapController.addSymbol(
        SymbolOptions(geometry: showImgs[i][1], iconImage: "assetImage$i"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapplsMap(
        initialCameraPosition: CameraPosition(
          target: currentLatLng,
          zoom: 14.0,
        ),
        onMapCreated: (map) => {
          mapController = map,
          showToast('just idea representation, under development😐'),
          addImageFromAsset()
        },
        myLocationEnabled: true,
        myLocationTrackingMode: MyLocationTrackingMode.NoneCompass,
        onUserLocationUpdated: (location) => {},
      ),
      //
    );
  }
}

Position? userPosition;

Future<void> determinePosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  final locationPermission = await Geolocator.checkPermission();

  if (!serviceEnabled ||
      locationPermission == LocationPermission.denied ||
      locationPermission == LocationPermission.deniedForever) {
    await Geolocator.requestPermission();
  }
  if (locationPermission == LocationPermission.denied ||
      locationPermission == LocationPermission.deniedForever) {
    showToast('Location permission is denied');
  }

  if (locationPermission == LocationPermission.always ||
      locationPermission == LocationPermission.whileInUse) {
    userPosition = await Geolocator.getCurrentPosition();
  }
}
