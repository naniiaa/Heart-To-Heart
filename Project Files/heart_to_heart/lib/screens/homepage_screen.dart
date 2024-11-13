import 'package:flutter/material.dart';

import 'package:heart_to_heart/searchBar.dart';

import 'newPostLisitngForm.dart';

class HomePageScreen extends StatefulWidget
{
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("chikenc nuggets"),
      ),
      body: NewListing()
      //HomePage(),
    );
  }
}
