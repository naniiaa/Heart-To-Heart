import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayListings extends StatefulWidget {
  const DisplayListings({super.key});

  @override
  State<DisplayListings> createState() => _DisplayListingsState();
}

class _DisplayListingsState extends State<DisplayListings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('listings').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Check connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Handle any errors in the stream
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          }

          // If data is empty, show a message
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data available"));
          }

          // Get the length of the data
          int dataLength = snapshot.data!.docs.length;

          return ListView.builder(
            itemCount: dataLength,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];

              // Safely access fields, and provide default values if fields are missing
              String field1 = document['field1'] ?? 'No value';
              String field2 = document['field2'] ?? 'No value';

              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Item ${index + 1}",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Field 1: $field1", // Display field1
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Field 2: $field2", // Display field2
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
