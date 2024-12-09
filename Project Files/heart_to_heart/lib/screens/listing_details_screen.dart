import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../notification/notification.dart';

class ListingDetailsScreen extends StatefulWidget {
  final String listingId;
  final String title;
  final String description;
  final String postedBy;
  final DateTime datePosted;
  final GeoPoint location;
  final String imagePath;
  final List<Map<String, dynamic>> timeSlots;

  const ListingDetailsScreen({
    Key? key,
    required this.listingId,
    required this.title,
    required this.description,
    required this.postedBy,
    required this.datePosted,
    required this.location,
    required this.imagePath,
    required this.timeSlots,
  }) : super(key: key);

  @override
  State<ListingDetailsScreen> createState() => _ListingDetailsScreenState();
}

class _ListingDetailsScreenState extends State<ListingDetailsScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth authorize = FirebaseAuth.instance;

  bool isRequesting = false;
  String? currentUserId;
  String? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    final user = authorize.currentUser;
    setState(() {
      currentUserId = user?.uid;
    });
  }

  Future<bool> hasExistingRequest(String listingId) async {
    final querySnapshot = await firestore
        .collection('listings')
        .doc(listingId)
        .collection('requests')
        .where('requestedBy', isEqualTo: currentUserId)
        .where('requestedTimeSlot', isEqualTo: selectedTimeSlot)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }


  Future<void> requestCollection() async {
    if (selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a time slot")),
      );
      return;
    }

    // Check if the user has already requested this time slot.
    final hasRequest = await hasExistingRequest(widget.listingId);
    if (hasRequest) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have already requested this slot.")),
      );
      return;
    }

    try {
      setState(() {
        isRequesting = true;
      });

      // Add the request inside the listings since listings can have requests
      await firestore.collection('listings').doc(widget.listingId).collection('requests').add({
        'requestedBy': currentUserId,
        'requestedTimeSlot': selectedTimeSlot,
        'status': 'requested',
        'createdAt': FieldValue.serverTimestamp(),
      });

      // The following notification provider
      await NotificationService.showInstantNotification(
        "New Request",
        "Your listing '${widget.title}' has a new request!",
      );


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request sent successfully!")),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error requesting collection: $e")),
      );

    } finally {

      setState(() {
        isRequesting = false;
      });

    }
  }

  Future<void> showTimeSlotDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select a Time Slot"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: widget.timeSlots.map((slot) {
                return RadioListTile<String>(
                  title: Text("${slot['date']} • ${slot['time']}"),
                  value: "${slot['date']} - ${slot['time']}",
                  groupValue: selectedTimeSlot,
                  onChanged: (value) {
                    setState(() {
                      selectedTimeSlot = value;
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng listingLatLng = LatLng(widget.location.latitude, widget.location.longitude);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing Details'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.teal,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Listing Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.imagePath.isNotEmpty
                  ? Image.file(
                File(widget.imagePath),
                width: double.maxFinite,
                height: 200,
                fit: BoxFit.contain,
              ) : const Icon(Icons.image, size: 100, color: Colors.grey),
            ),

             SizedBox(height: 16),

            // Title
            Center(
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 8),

            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 4),
            Text(
              widget.description,
              style: const TextStyle(fontSize: 16),
            ),

            SizedBox(height: 16),

             Text(
              "Posted By",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 4),

            Text(
              widget.postedBy,
              style: const TextStyle(fontSize: 16),
            ),

            SizedBox(height: 16),

            Text(
              "Date Posted",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 4),

            Text(
              DateFormat.yMMMMd().format(widget.datePosted),
              style: const TextStyle(fontSize: 16),
            ),

            SizedBox(height: 16),

             Text(
              "Location",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            SizedBox(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: listingLatLng,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('listingLocation'),
                    position: listingLatLng,
                    infoWindow: InfoWindow(title: widget.title),
                  ),
                },
              ),
            ),

            SizedBox(height: 24),

             Text(
              "Time Slots AVAILABLE",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            widget.timeSlots.isEmpty ? const Text(
              "No time slots available",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            )

             : Column(
              children: widget.timeSlots.map((slot) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.timer, color: Colors.teal),
                    title: Text(slot['date'] ?? ''),
                    subtitle: Text(slot['time'] ?? ''),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Request Button
            if (currentUserId != widget.postedBy) // Only show the button for non-listers
              Center(
                child: ElevatedButton(
                  onPressed: isRequesting ? null : () async {
                    await showTimeSlotDialog();
                    if (selectedTimeSlot != null) {
                      await requestCollection();
                    }
                  },
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                  ),

                  child: isRequesting ? const CircularProgressIndicator() : Text('Request',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
