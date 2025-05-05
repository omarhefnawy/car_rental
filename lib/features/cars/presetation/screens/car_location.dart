import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';
import 'package:flutter/material.dart';
class CarLocation extends StatefulWidget {
  const CarLocation({super.key});

  @override
  State<CarLocation> createState() => _CarLocationState();
}

class _CarLocationState extends State<CarLocation> {
  @override
  Widget build(BuildContext context) {
     return PlacePicker(
        apiKey:"AIzaSyABKSTf-9-q9e4bOiyYHl4m3pEnoet6ofk",
        onPlacePicked: (LocationResult result) {
          debugPrint("Place picked: ${result.formattedAddress}");
          Navigator.of(context).pop(result.latLng);
        },
        initialLocation: const LatLng(
            30.56055306670425, 31.017858735296507
        ),
        searchInputConfig: const SearchInputConfig(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          autofocus: false,
          textDirection: TextDirection.ltr,
        ),
        searchInputDecorationConfig: const SearchInputDecorationConfig(
            hintText: "Search for a building, street or ...",
           ),
     );
  }
}
