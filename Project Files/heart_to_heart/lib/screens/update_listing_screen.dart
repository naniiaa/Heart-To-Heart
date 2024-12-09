import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/listing.dart';
import '../home/location_picker_screen.dart';
import '../entry/textfield_decoration.dart';

class UpdateListingScreen extends StatefulWidget {
  final Listing listing;
  final bool isDark;

  const UpdateListingScreen({Key? key, required this.listing, required this.isDark}) : super(key: key);

  @override
  State<UpdateListingScreen> createState() => _UpdateListingScreenState();
}

class _UpdateListingScreenState extends State<UpdateListingScreen> {

  final _formKey = GlobalKey<FormState>();

 // Form controllers to be manipulated later
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String category;
  late String type;

  GeoPoint? selectedLocation;
  File? selectedImage;
  String? currentImageUrl;
  final ImagePicker _imagePicker = ImagePicker();

  // All of our categories
  final Map<String, List<String>> categories = {
    'Items': ['Furniture', 'Clothing', 'Appliances'],
    'Food': ['Fresh Food', 'Preserved Food', 'Dairy'],
    'Services': ['Repair', 'Sanitation', 'Healthcare'],
  };

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.listing.title);
    descriptionController = TextEditingController(text: widget.listing.description);
    category = widget.listing.category;
    type = widget.listing.type;
    selectedLocation = widget.listing.location;
    currentImageUrl = widget.listing.imageUrl;
  }

  // Uses geolocator current position
  Future<void> useCurrentLocation() async {

    try {

      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        // Sets the location based on geopoint
        selectedLocation = GeoPoint(position.latitude, position.longitude);

      });

      ScaffoldMessenger.of(context).showSnackBar(
        // Let user know that location is updated
        const SnackBar(content: Text('Location updated to current location')),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        // Failed to get current location
        SnackBar(content: Text('Failed to get current location: $e')),
      );
    }
  }

  //
  Future<void> selectLocationOnMap() async {

    LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );

    if (pickedLocation != null) {
      setState(() {
        selectedLocation = GeoPoint(pickedLocation.latitude, pickedLocation.longitude);
      });
    }
  }

  Future<void> updateListing() async {

    if (!_formKey.currentState!.validate()) return;

    if (selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location.')),
      );
      return;
    }

    try {
      final docRef = FirebaseFirestore.instance.collection('listings').doc(widget.listing.id);

      // Retrieve the text to send to the DB
      Map<String, dynamic> updateData = {
        'title': titleController.text,
        'description': descriptionController.text,
        'type': type,
        'category': category,
        'location': selectedLocation,
      };

      // Update Firestore document
      await docRef.update(updateData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Listing updated successfully!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update listing: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Listing'),
        backgroundColor: isDark ? Colors.black : Colors.teal,
        centerTitle: true,
      ),

      body: Padding(

        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                controller: titleController,
                decoration: customInputDecoration('Title', isDark),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: descriptionController,
                decoration: customInputDecoration('Description', isDark),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a description' : null,
              ),

              const SizedBox(height: 16),

              // Type Dropdown
              DropdownButtonFormField<String>(

                value: type,
                items: categories.keys.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),

                onChanged: (value) {

                  setState(() {
                    type = value!;
                    category = categories[type]!.first;
                  });

                },

                decoration: customInputDecoration('Type', isDark),

                validator: (value) => value == null ? 'Please select a type' : null,
              ),

              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(

                value: category,

                items: categories[type]!.map((category) {

                  return DropdownMenuItem(value: category, child: Text(category));

                }).toList(),

                onChanged: (value) {

                  setState(() {
                    category = value!;
                  });

                },

                decoration: customInputDecoration('Category', isDark),

                validator: (value) => value == null ? 'Please select a category' : null,
              ),

              const SizedBox(height: 16),

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  ElevatedButton.icon(

                    onPressed: useCurrentLocation,
                    icon: const Icon(Icons.my_location),
                    label: const Text('Use Current Location'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2EC4B6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: selectLocationOnMap,
                    icon: const Icon(Icons.map),
                    label: const Text('Select on Map'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2EC4B6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: updateListing,
                child: const Text('Update Listing'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2EC4B6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
