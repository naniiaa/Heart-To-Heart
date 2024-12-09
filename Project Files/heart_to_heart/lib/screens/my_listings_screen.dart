import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'update_listing_screen.dart';
import 'add_listing_screen.dart';
import '../../model/listing.dart';

class MyListingsPage extends StatelessWidget {
  final bool isDark;

  const MyListingsPage({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'User not logged in.',
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
        ),
      );
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text('My Listings'),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.teal,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('listings').where('postedBy', isEqualTo: user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No listings found.',
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
            );
          }

          final listings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: listings.length,
            itemBuilder: (context, index) {
              final listingData = listings[index].data() as Map<String, dynamic>;
              final listing = Listing.fromFirestore(listingData, listings[index].id);

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(listing.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(listing.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateListingScreen(
                                listing: listing,
                                isDark: isDark,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final confirmDelete = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Delete Listing'),
                              content: Text('Are you sure you want to delete this listing?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirmDelete == true) {
                            await FirebaseFirestore.instance.collection('listings').doc(listing.id).delete();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: isDark ? Colors.teal : Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewListingPage(isDark: isDark),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
