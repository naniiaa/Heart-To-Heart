import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heart_to_heart/screens/entry/textfield_decoration.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../requests/request_management_screen.dart';
import 'bottom_nav_bar.dart';
import 'listing_details_screen.dart';
import '../listings/my_listings_screen.dart';
import '../listings/add_listing_screen.dart';

class HomePageScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDark;

  const HomePageScreen({Key? key, required this.toggleTheme, required this.isDark}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with SingleTickerProviderStateMixin {

  bool isDark = false;
  late TabController tabController;

  String selectedSort = 'New to Old';
  String selectedCategory = 'All';
  String selectedType = 'Items';
  String searchString = "";

  // Use Montreal's coordinates
  GeoPoint defaultLocation = GeoPoint(45.5017, -73.5673);
  GeoPoint? userLocation;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {
        selectedCategory = 'All';
      });
    });
  }

  Future<void> requestLocationPermission() async {

    try {

      final permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied');
      }


      final position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
      );

      setState(() {
        userLocation = GeoPoint(position.latitude, position.longitude);
      });

    } catch (e) {

      print('Error fetching location: $e');

      setState(() {
        userLocation = defaultLocation;
      });

    }
  }


  Stream<QuerySnapshot> getListings(String type) {

    Query query = FirebaseFirestore.instance.collection('listings');

    // Gets the donation type whether its items, food or service
    if (type.isNotEmpty) {
      query = query.where('type', isEqualTo: type);
    }

    // Gets the selected category, its all by default
    if (selectedCategory != 'All') {
      query = query.where('category', isEqualTo: selectedCategory);
    }

    if (searchString.isNotEmpty) {
      query = query.where(
        'title',
        isGreaterThanOrEqualTo: searchString,
        isLessThan: searchString + '\uf8ff', // Ensures range-based search
      );
    }

    // If the sort by is selected then it will do desc or ascending
    if (selectedSort == 'New to Old') {
      query = query.orderBy('createdAt', descending: true);
    } else if (selectedSort == 'Old to New') {
      query = query.orderBy('createdAt', descending: false);
    }

    return query.snapshots();

  }

  List<String> getCategoriesForCurrentTab() {
    if (tabController.index == 0) {
      return ['All', 'Furniture', 'Clothing', 'Appliances'];
    } else if (tabController.index == 1) {
      return ['All', 'Fresh Food', 'Preserved Food', 'Dairy'];
    } else {
      return ['All', 'Repair', 'Sanitation', 'Healthcare'];
    }
  }

  // Use geolocators built-in distance calculator
  double calculateDistance(GeoPoint location1, GeoPoint location2) {
    return Geolocator.distanceBetween(
      location1.latitude,
      location1.longitude,
      location2.latitude,
      location2.longitude,
    ) / 1000; // km
  }

  String formatDistance(double distance) {
    if (distance < 1) {
      return '${(distance * 1000).toStringAsFixed(0)} m';
    } else {
      return '${distance.toStringAsFixed(1)} km';
    }
  }

  // Default to Montreal
  String getFormattedDistance(GeoPoint listingLocation) {
    GeoPoint comparisonLocation = GeoPoint(45.5017, -73.5673);

    if (userLocation != null) {
      comparisonLocation = userLocation!;
    } else {
      comparisonLocation = defaultLocation;
    }

    final distance = calculateDistance(comparisonLocation, listingLocation);

    return formatDistance(distance);
  }


  Widget buildGridView(Stream<QuerySnapshot> stream) {

    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final listings = snapshot.data!.docs;

        if (listings.isEmpty) {
          return const Center(child: Text('No Listings Found'));
        }

        return GridView.builder(

          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.65,
          ),

          itemCount: listings.length,

          itemBuilder: (context, index) {

            final listing = listings[index];
            final imagePath = listing['imagePath'];
            final createdAt = listing['createdAt'].toDate();
            final postedByUid = listing['postedBy'];
            final distance = userLocation != null ? formatDistance(calculateDistance(userLocation!, listing['location'] as GeoPoint))
                : 'N/A';

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(postedByUid).get(),

              builder: (context, userSnapshot) {

                if (!userSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final userData = userSnapshot.data!;

                final fullName = userData['fullName'] ?? 'Unknown';

                final distance = getFormattedDistance(listing['location'] as GeoPoint);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListingDetailsScreen(
                          listingId: listing.id,
                          title: listing['title'] ?? 'Listing',
                          description: listing['description'] ?? 'No description available.',
                          postedBy: fullName,
                          datePosted: createdAt,
                          location: listing['location'] as GeoPoint,
                          imagePath: listing['imagePath'] ?? '',
                          timeSlots: (listing['timeSlots'] as List<dynamic>?)?.map((e) => e as Map<String, dynamic>).toList() ?? [],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imagePath != null
                                ? Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200 ,
                            ) : Icon(Icons.image, size: 50, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            listing['title'] ?? 'Listing',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text('$distance • $fullName • ${DateFormat.yMMMd().format(createdAt)}',
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final theme = Theme.of(context);

    return Scaffold(

      backgroundColor: isDark ? theme.scaffoldBackgroundColor : Colors.white,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 18,
        backgroundColor: isDark ?  theme.appBarTheme.backgroundColor : Colors.white70,
        elevation: 2,
      ),

      body: Column(
        children: [
          // H2H logo with search and map icon
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

            child: Row(
              children: [
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Image.asset(
                          'assets/images/heart.png',
                          width: 50,
                          height: 50,
                    )
                  ),
                ),

                // SizedBox(width: 10),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildSearchBar(context),
                    /*TextField(
                      decoration: InputDecoration(
                        hintText: "Search Listings",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ), */
                  ),
                ),
              ],
            ),
          ),


          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.transparent),
              ),

              child: TabBar(
                indicator: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(25.0),),

                // Designs
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                controller: tabController,
                indicatorColor: Colors.black,
                labelPadding: EdgeInsets.symmetric(horizontal: 30.0),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),

                tabs: const [
                  Tab(text: 'Items'),
                  Tab(text: 'Food'),
                  Tab(text: 'Service'),
                ],

                onTap: (index) {
                  setState(() {
                    selectedType = ['Items', 'Food', 'Services'][index];
                    selectedCategory = 'All';
                  });

                },
              ),
            ),
          ),

          // Filter and Sort Dropdowns
          Padding(

            padding: const EdgeInsets.all(8.00),

            child: Row(

              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Padding(

                  padding: const EdgeInsets.only(left: 20.00),

                  child: DropdownButton<String>(
                    dropdownColor: isDark ? Colors.black87 : Colors.white,
                    borderRadius: BorderRadius.circular(17.00),
                    value: selectedSort,

                    items: ['New to Old', 'Old to New', 'Distance'].map((sort) => DropdownMenuItem(
                        value: sort,
                        child: Text(sort,
                          style: TextStyle(fontSize: 18, color: isDark ? Colors.white : Colors.black),
                        )
                      )).toList(),

                      onChanged: (value) {
                        setState(() {
                          selectedSort = value!;
                        });
                    },
                  ),
                ),

                SizedBox(width: 100),

                Padding(
                  padding: const EdgeInsets.only(right:20.00),
                  child: DropdownButton<String>(
                    dropdownColor: isDark ? Colors.black87 : Colors.white,
                    borderRadius: BorderRadius.circular(17.00),
                    value: selectedCategory,

                    items:  getCategoriesForCurrentTab().map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category, style: TextStyle(fontSize: 18, color: isDark ? Colors.white : Colors.black),
                        ),
                      )
                    ).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),

              ],
            ),
          ),

          // Listings GridView
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                buildGridView(getListings('Items')),
                buildGridView(getListings('Food')),
                buildGridView(getListings('Services')),
              ],
            ),

          ),

          BottomNavBar(
            onItemSelected: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, 'requests');
              } else if (index == 1) {
                Navigator.pushNamed(context, '/home');
              } else if (index == 2) {
                Navigator.pushNamed(context, '/listings');
              } else if (index == 3) {
                Navigator.pushNamed(context, '/settings');
              }
            },
          ),
        ],
      ),
    );
  }

  // Search bar does not work
  Widget buildSearchBar(BuildContext context) {
    final isDark = widget.isDark;

    return Row(

      children: [

        Expanded(
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchString = value.toLowerCase();
              });
            },
            decoration: customInputDecoration('Search Listings', isDark),
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
        ),

         SizedBox(width: 10),

        IconButton(
          onPressed: widget.toggleTheme,
          icon: isDark ? Icon(Icons.brightness_2_outlined, color: Colors.white) : Icon(Icons.wb_sunny_outlined, color: Colors.black),
        ),
      ],
    );
  }

}
