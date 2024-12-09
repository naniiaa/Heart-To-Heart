import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerScreen extends StatefulWidget {
  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {

  LatLng selectedLocation = const LatLng(45.5017, -73.5673); // THIS IS MONTREAL'S LAT LANG

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Select Location'),
        backgroundColor: Colors.teal,
      ),

      body:

      Stack(

        children: [

          // Use google maps API
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedLocation,
              zoom: 12,
            ),

             // Choose a location based on the marker
            onTap: (LatLng location) {
              setState(() {
                selectedLocation = location;
              });
            },

            markers: {
              Marker(
                markerId: const MarkerId('selected-location'),
                position: selectedLocation,
              ),
            },

          ),

          Positioned(
            bottom: 30,
            left: 20,
            right: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  backgroundColor: Color(0xFF40916C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, selectedLocation); // Choose current location
                },
                child: const Text('Confirm Location', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
