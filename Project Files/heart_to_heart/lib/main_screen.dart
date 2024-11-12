import 'package:flutter/material.dart';
import 'dart:ui';

void main()
{
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget
{
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          HomePageItemsGeneral(),
        ]),
      ),
    );
  }
}

class HomePageItemsGeneral extends StatelessWidget
{
  bool isDark = false;
  @override
  Widget build(BuildContext context)
  {
    return Column(
      children: [
        Container(
          width: 418,
          height: 977,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 2,
                child: Container(
                  width: 418,
                  height: 970,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 8,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0x7F747775),
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [

                          ],
                        ),
                      ),
                      Container(
                        width: 418,
                        height: 24,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 108,
                              height: 4,
                              decoration: ShapeDecoration(
                                color: Color(0xFF171D1B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 144,
                top: 40,
                child: Container(
                  width: 265,
                  height: 63,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 16,
                          right: 48,
                          bottom: 10,
                        ),
                        decoration: ShapeDecoration(
                          color: Color(0xFFEFF1F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.only(
                                top: 3,
                                left: 3,
                                right: 3.42,
                                bottom: 3.42,
                              ),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                ],
                              ),
                            ),
                            const SizedBox(width: 8),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 13,
                top: 103,
                child: Container(
                  width: 395,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Color(0xFFEFF1F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(52),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF1C1B1F),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x0C000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Items',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0.10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Food',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFA09CAB),
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          height: 0.10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Service',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFA09CAB),
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          height: 0.10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 167,
                child: Container(
                  width: 353,
                  height: 36,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 113,
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2, color: Color(0xFFAEB0B6)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  'Sort By',
                                  style: TextStyle(
                                    color: Color(0xFF61646B),
                                    fontSize: 12,
                                    fontFamily: 'Work Sans',
                                    fontWeight: FontWeight.w500,
                                    height: 0.11,
                                    letterSpacing: 0.60,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              width: 16,
                              height: 16,
                              padding: const EdgeInsets.symmetric(horizontal: 2.83, vertical: 5.17),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 105),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: Color(0xFFAEB0B6)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    'Clothing',
                                    style: TextStyle(
                                      color: Color(0xFF61646B),
                                      fontSize: 12,
                                      fontFamily: 'Work Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 0.11,
                                      letterSpacing: 0.60,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.symmetric(horizontal: 2.83, vertical: 5.17),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 70.43,
                child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.70),
                  child: Container(
                    width: 38,
                    height: 37,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://via.placeholder.com/38x37"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 109,
                top: 66,
                child: Container(
                  width: 35,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/35x30"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 215,
                child: Container(
                  width: 369,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 337,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF7F8FD),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 162.50,
                                      height: 120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: double.infinity,
                                              padding: const EdgeInsets.all(40),
                                              decoration: BoxDecoration(color: Color(0xFFEAF2FF)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(),
                                                    child: FlutterLogo(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 142,
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 54,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'Amazing Shoes',
                                                    style: TextStyle(
                                                      color: Color(0xFF1F2024),
                                                      fontSize: 12,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      height: 0.11,
                                                      letterSpacing: 0.12,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'Distance • Name • Time Posted',
                                                    style: TextStyle(
                                                      color: Color(0xFF1F2024),
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w700,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Container(
                                            width: double.infinity,
                                            height: 40,
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(width: 1.50, color: Color(0xFF006FFD)),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Contact',
                                                  style: TextStyle(
                                                    color: Color(0xFF006FFD),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF7F8FD),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 162.50,
                                      height: 120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: double.infinity,
                                              padding: const EdgeInsets.all(40),
                                              decoration: BoxDecoration(color: Color(0xFFEAF2FF)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(),
                                                    child: FlutterLogo(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 125,
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 37,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'Faboulous Shoes',
                                                    style: TextStyle(
                                                      color: Color(0xFF1F2024),
                                                      fontSize: 12,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      height: 0.11,
                                                      letterSpacing: 0.12,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    '1.5 km • Jen • 1d',
                                                    style: TextStyle(
                                                      color: Color(0xFF1F2024),
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w700,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Container(
                                            width: double.infinity,
                                            height: 40,
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(width: 1.50, color: Color(0xFF006FFD)),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Contact',
                                                  style: TextStyle(
                                                    color: Color(0xFF006FFD),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 337,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF7F8FD),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 162.50,
                                      height: 120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: double.infinity,
                                              padding: const EdgeInsets.all(40),
                                              decoration: BoxDecoration(color: Color(0xFFEAF2FF)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(),
                                                    child: FlutterLogo(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 69,
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 37,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'Fantastic Shoes',
                                                    style: TextStyle(
                                                      color: Color(0xFF1F2024),
                                                      fontSize: 12,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      height: 0.11,
                                                      letterSpacing: 0.12,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text.rich(
                                                    TextSpan(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF7F8FD),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 162.50,
                                      height: 120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: double.infinity,
                                              padding: const EdgeInsets.all(40),
                                              decoration: BoxDecoration(color: Color(0xFFEAF2FF)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(),
                                                    child: FlutterLogo(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 69,
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 37,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'Spectacular Shoes',
                                                    style: TextStyle(
                                                      color: Color(0xFF1F2024),
                                                      fontSize: 12,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      height: 0.11,
                                                      letterSpacing: 0.12,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text.rich(
                                                    TextSpan(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 337,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF7F8FD),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 162.50,
                                      height: 120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: double.infinity,
                                              padding: const EdgeInsets.all(40),
                                              decoration: BoxDecoration(color: Color(0xFFEAF2FF)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(),
                                                    child: FlutterLogo(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 69,
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 37,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'Stunning Shoes',
                                                    style: TextStyle(
                                                      color: Color(0xFF1F2024),
                                                      fontSize: 12,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      height: 0.11,
                                                      letterSpacing: 0.12,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text.rich(
                                                    TextSpan(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF7F8FD),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 162.50,
                                      height: 120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: double.infinity,
                                              padding: const EdgeInsets.all(40),
                                              decoration: BoxDecoration(color: Color(0xFFEAF2FF)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(),
                                                    child: FlutterLogo(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 69,
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 37,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'Wonderful Shoes',
                                                    style: TextStyle(
                                                      color: Color(0xFF1F2024),
                                                      fontSize: 12,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      height: 0.11,
                                                      letterSpacing: 0.12,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text.rich(
                                                    TextSpan(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 1,
                top: 899,
                child: Container(
                  width: 416,
                  height: 60,
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: 32,
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: FlutterLogo(),
                              ),
                              Text(
                                'Messages',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF71727A),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0.14,
                                  letterSpacing: 0.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: FlutterLogo(),
                              ),
                              Text(
                                'Home',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF71727A),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0.14,
                                  letterSpacing: 0.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: FlutterLogo(),
                              ),
                              Text(
                                'Settings',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1F2024),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 4,
                top: 12,
                child: Container(
                  width: 418,
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 128,
                                height: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '9:30',
                                      style: TextStyle(
                                        color: Color(0xFF171D1B),
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0.10,
                                        letterSpacing: 0.25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 24,
                                height: 24,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF2E2E2E),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            padding: const EdgeInsets.only(
                                              top: 2.96,
                                              left: 0.67,
                                              right: 0.67,
                                              bottom: 2.67,
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 16,
                                            height: 16,
                                            padding: const EdgeInsets.all(1.33),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 16,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            padding: const EdgeInsets.symmetric(horizontal: 3.75, vertical: 0.92),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}