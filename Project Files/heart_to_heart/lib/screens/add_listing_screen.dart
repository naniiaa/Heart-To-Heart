import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home/location_picker_screen.dart';
import 'package:heart_to_heart/screens/entry/textfield_decoration.dart';

// TimeOfDayRange Class -> it uses the start and end time
class TimeOfDayRange {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  TimeOfDayRange({required this.startTime, required this.endTime});

  TimeOfDayRange copyWith({TimeOfDay? startTime, TimeOfDay? endTime}) {
    return TimeOfDayRange(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

class NewListingPage extends StatefulWidget {
  final bool isDark;

  const NewListingPage({Key? key, this.isDark = false}) : super(key: key);

  @override
  State<NewListingPage> createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Controllers for the form
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Variables for dropdowns and location
  String? selectedType;
  String? selectedCategory;
  GeoPoint? selectedLocation;
  File? selectedImage;

  final List<Map<String, String>> timeSlots = []; // Store time slots

  final Map<String, List<String>> categories = {
    'Items': ['Furniture', 'Clothing', 'Appliances'],
    'Food': ['Fresh Food', 'Preserved Food', 'Dairy'],
    'Services': ['Repair', 'Sanitation', 'Healthcare'],
  };

  final ImagePicker _imagePicker = ImagePicker();

  // Add a new time slot
  Future<void> addTimeSlot() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          timeSlots.add({
            'date': date.toIso8601String().split('T')[0],
            'time': time.format(context),
          });
        });
      }
    }
  }

  Future<void> editTimeSlot(int index, Map<String, String> currentSlot) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(currentSlot['date']!),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(currentSlot['time']!.split(':')[0]),
          minute: int.parse(currentSlot['time']!.split(':')[1]),
        ),
      );

      if (time != null) {
        setState(() {
          timeSlots[index] = {
            'date': date.toIso8601String().split('T')[0],
            'time': time.format(context),
          };
        });
      }
    }
  }


  // Remove a time slot
  void removeTimeSlot(int index) {
    setState(() {
      timeSlots.removeAt(index);
    });
  }

  // Fetch current location
  Future<void> useCurrentLocation() async {
    try {

      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission is denied. Using default location.')),
        );

        setState(() {
          selectedLocation = const GeoPoint(45.5017, -73.5673);
        });

        return;
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      setState(() {
        selectedLocation = GeoPoint(position.latitude, position.longitude);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Current location retrieved successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get current location. Using default location.')),
      );

      setState(() {
        selectedLocation = const GeoPoint(45.5017, -73.5673);
      });
    }
  }

  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> takePicture() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }


  // Submit form to Firestore
  Future<void> submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (selectedLocation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a location.')),
        );
        return;
      }

      if (selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image.')),
        );
        return;
      }

      try {

        // Get the current user
        User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser == null) throw Exception('User not logged in.');

        // Prepare time slots for Firestore
        final formattedTimeSlots = timeSlots.map((timeSlot) {
          return {
            'date': timeSlot['date']!,
            'time': timeSlot['time']!,
          };
        }).toList();

        if (formattedTimeSlots.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please add a time slot')),
          );
        } else if (formattedTimeSlots.isNotEmpty) {

          await FirebaseFirestore.instance.collection('listings').add({
            'title': titleController.text.trim(),
            'description': descriptionController.text.trim(),
            'type': selectedType!,
            'category': selectedCategory!,
            'imagePath': selectedImage!.path,
            'location': selectedLocation,
            'postedBy': currentUser.uid,
            'createdAt': Timestamp.now(),
            'timeSlots': formattedTimeSlots,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Listing Added Successfully!')),
          );

          Navigator.pop(context);

        }

      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add listing: $e')),
        );

      }
    }
  }


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

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post New Listing'),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.teal,
      ),

      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [

              TextFormField(
                controller: titleController,
                decoration: customInputDecoration('Title', isDark),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),

              SizedBox(height: 16),

              TextFormField(
                controller: descriptionController,
                decoration: customInputDecoration('Description', isDark),
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              ),

              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: selectedType,
                items: categories.keys.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                    selectedCategory = null;
                  });
                },
                decoration: customInputDecoration('Type', isDark),
                validator: (value) => value == null ? 'Please select a type' : null,
              ),

              SizedBox(height: 16),

              if (selectedType != null)
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: categories[selectedType]!.map((category) {
                    return DropdownMenuItem(value: category, child: Text(category));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  decoration: customInputDecoration('Category', isDark),
                  validator: (value) => value == null ? 'Please select a category' : null,
                ),

              SizedBox(height: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

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
                        label: const Text('Choose From Map'),
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

                   SizedBox(height: 16),
                ],
              ),

               SizedBox(height: 16),

              Column(

                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [

                  ElevatedButton.icon(
                    onPressed: pickImageFromGallery,
                    icon: Icon(Icons.photo),
                    label: Text('Gallery'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2EC4B6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: takePicture,
                    icon: const Icon(Icons.camera),
                    label: const Text('Camera'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2EC4B6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  if (selectedImage != null)
                    Image.file(selectedImage!, height: 200, width: 200, fit: BoxFit.contain),
                ],

              ),

              SizedBox(height: 16),

              Column(

                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      ElevatedButton(
                        onPressed: addTimeSlot,
                        child: Text('Add Time Slot'),
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

                  SizedBox(height: 16),

                  if (timeSlots.isNotEmpty)

                    Column(
                      children: timeSlots.asMap().entries.map((entry) => ListTile(
                        title: Text('${entry.value['date']} - ${entry.value['time']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => removeTimeSlot(entry.key),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2EC4B6),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onTap: () {
                          // Allows the user to edit the time slot
                          editTimeSlot(entry.key, entry.value);
                        },
                      ))
                          .toList(),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: submitForm,
                child: Text('Submit'),
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
