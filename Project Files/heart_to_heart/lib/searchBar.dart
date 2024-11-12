import 'package:flutter/material.dart';
import 'dart:ui';

import 'mainNavBar.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  bool isDark = false;
  int searchCount = 1;

  @override
  Widget build(BuildContext context)
  {
    final ThemeData themeData = ThemeData
    (
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20,
        ),
        body:
        Padding(
          padding: EdgeInsets.all(8.0),
          child:
            Column(
              children:
              [
                Row(
                  children:
                  [
                      InkWell(
                        onTap: ()
                        {
                            //Text('main page');
                        }, // Splash color over image
                        child: Ink.image(
                          fit: BoxFit.cover, // Fixes border issues
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(15.0),
                          image: const AssetImage('assets/images/heart.png'),
                        ),
                      ),

                      IconButton(
                        onPressed: ()
                        {

                        }, icon: Icon(Icons.map_outlined,size: 45),
                        padding: const EdgeInsets.all(15.0),
                      ),

                      SearchAnchor(builder:
                          (BuildContext context, SearchController controller)
                      {
                        return SizedBox
                          (
                          width: 280,
                          child:
                          SearchBar(
                            controller: controller,
                            padding: const  WidgetStatePropertyAll <EdgeInsets>
                              (
                                EdgeInsets.symmetric(horizontal: 16.0)
                            ),
                            onTap: ()
                            {
                              controller.openView();
                            },
                            onChanged: (_)
                            {
                              controller.openView();
                            },
                            leading: const Icon(Icons.search),
                            trailing: <Widget>
                            [
                              Tooltip(
                                message: "Change brightness mode",
                                child: IconButton(
                                  onPressed: ()
                                  {
                                    setState(() {
                                      isDark = !isDark;
                                    });
                                  },
                                  icon: const Icon(Icons.wb_sunny_outlined),
                                  selectedIcon: const Icon(Icons.brightness_2_outlined),
                                ),
                              )
                            ],
                          ),
                        );

                      },
                        suggestionsBuilder:
                            (BuildContext context, SearchController controller)
                        {
                          return List<ListTile>.generate(searchCount, (int index)
                          {
                            final String data = 'example that it work';
                            return ListTile(
                              title: Text(data),
                              onTap: ()
                              {
                                setState(()
                                {
                                  controller.closeView(data);
                                });
                              },
                            );
                          });
                        }
                      ),
                  ],
                ),
                    Expanded(child: UpperNavBar())
              ],
            )
        ),
      ),
    );
  }
}
