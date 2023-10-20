// ignore_for_file: file_names, sort_child_properties_last, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gridview/PastEntry.dart';
import 'package:gridview/TakeView.dart';
import 'package:gridview/Schedular.dart';
import 'package:gridview/viewcal.dart';

import 'Example.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> image = [
    'images/Attandance2.png',
    'images/timetable2.png',
    'images/View100.png',
    'images/PastRecord.png',
    // 'images/PastRecord.png',
    'images/AboutUs.png'
  ];

  List<String> text = [
    'Take Follow',
    'Schedular',
    'View',
    'Past Entry',
    // 'Example',
    'About Us'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[dashBg, content],
      ),
    );
  }

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(30)),
                color: Color(0xFF3388ff),
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Container(color: Color.fromARGB(0, 255, 0, 0)),
            flex: 5,
          ),
        ],
      );

  get content => Container(
        child: Column(
          children: <Widget>[
            header,
            grid,
          ],
        ),
      );

  get header => const ListTile(
        contentPadding: EdgeInsets.only(top: 80, left: 20, right: 20),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 28,
            ),
          ),
        ),
      );

  get grid => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            padding: EdgeInsets.only(top: 70, left: 16, right: 16, bottom: 16),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                ),
                itemCount: image.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TakeView()));
                      }
                      if (index == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Schedular()));
                      }
                      if (index == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => viewcal())));
                      }
                      if (index == 3) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PastEntry()));
                      }
                      if (index == 4) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                // ignore: non_constant_identifier_names
                                builder: (Context) => Animated()));
                      }
                      if (index == 5) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                // ignore: non_constant_identifier_names
                                builder: (Context) => Animated()));
                      }
                    },
                    child: Card(
                      color: Color.fromARGB(255, 236, 238, 239),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              image[index],
                              height: 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                text[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      );
}
