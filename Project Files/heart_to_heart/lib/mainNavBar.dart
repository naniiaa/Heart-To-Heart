import 'package:flutter/material.dart';


class TabItem extends StatelessWidget
{
  final String title;
  final int count;

  const TabItem({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context)
  {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
          count > 0
              ? Container(
            margin: const EdgeInsetsDirectional.only(start: 5),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                count > 9 ? "9+" : count.toString(),
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                ),
              ),
            ),
          )
              : const SizedBox(width: 0, height: 0),
        ],
      ),
    );
  }
}


















// class UpperNavBar extends StatefulWidget {
//   const UpperNavBar({super.key});
//
//   @override
//   State<UpperNavBar> createState() => _UpperNavBarState();
// }
//
// class _UpperNavBarState extends State<UpperNavBar> with SingleTickerProviderStateMixin {
//   static const List<Tab> myTabs = <Tab>[
//     Tab(text: 'Items'),
//     Tab(text: 'Service'),
//     Tab(text: 'Services'),
//   ];
//
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: myTabs.length);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context)
//   {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 10,
//         bottom: TabBar(
//           //padding: EdgeInsets.symmetric(horizontal: 50.0),
//           controller: _tabController,
//           tabs: myTabs,
//           isScrollable: true,
//
//           labelStyle:
//           const TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//
//           unselectedLabelStyle:
//           const TextStyle(
//             color: Colors.grey,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//
//           indicator:
//           BoxDecoration(
//             borderRadius: BorderRadius.circular(16.0),
//             color: Colors.black,
//           ),
//         ),
//       ),
//
//       body: TabBarView(
//         controller: _tabController,
//         children:
//         [
//
//           Center(
//             child: Text(
//               'Items Content',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//
//
//           Center(
//             child: Text(
//               'Service Content',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//
//
//           Center(
//             child: Text(
//               'Services Content',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//
//
//         ],
//       ),
//     );
//   }
// }
