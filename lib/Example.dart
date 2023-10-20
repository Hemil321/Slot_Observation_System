// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Animated extends StatefulWidget {
  const Animated({super.key});

  @override
  State<Animated> createState() => _AnimatedState();
}

class _AnimatedState extends State<Animated> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // ignore: sort_child_properties_last
      child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 85, horizontal: 17),
          child: Text('About Us',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(35)),
        color: Colors.blue,
      ),
    ));
  }
}
