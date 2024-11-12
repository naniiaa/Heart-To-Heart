import 'package:flutter/material.dart';

class UpperNavBar extends StatefulWidget {
  const UpperNavBar({super.key});

  @override
  State<UpperNavBar> createState() => _UpperNavBarState();
}

class _UpperNavBarState extends State<UpperNavBar> with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Items'),
    Tab(text: 'Service'),
    Tab(text: 'Services'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        bottom: TabBar(
          //padding: EdgeInsets.all(10.0),
          controller: _tabController,
          tabs: myTabs,
          isScrollable: false,

          labelStyle:
          const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),

          unselectedLabelStyle:
          const TextStyle(
            color: Colors.grey,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),

          indicator:
          BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.black,
          ),
          indicatorSize: TabBarIndicatorSize.tab,  // This controls the width
          indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children:
        [

          Center(
            child: Text(
              'Items Content',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),


          Center(
            child: Text(
              'Service Content',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),


          Center(
            child: Text(
              'Services Content',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),


        ],
      ),
    );
  }
}
