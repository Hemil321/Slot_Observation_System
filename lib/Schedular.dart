// ignore_for_file: file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart'
    show FieldValue, FirebaseFirestore;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Schedular extends StatefulWidget {
  const Schedular({super.key});

  @override
  State<Schedular> createState() => _SchedularState();
}

// ignore: camel_case_types
class _SchedularState extends State<Schedular> {
  String dayddm = DateFormat.EEEE().format(DateTime.now());

  var days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  // String selectslot = "";
  // String slot = "";
  String selectslot = '';
  String slot = "";

  var slots = [
    'Slot 1 9:10 to 10:10',
    'Slot 2 10:10 to 11:10',
    'lunch',
    'Slot 3 12:10 to 13:10',
    'Slot 4 13:10 to 14:10',
    'Slot 5 14:20 to 15:20',
    'Slot 6 15:20 to 16:20',
    'No Slot',
  ];

  final _classcontroller = TextEditingController();
  final _facultycontroller = TextEditingController();
  final _subjectcontroller = TextEditingController();
  final _batchcontroller = TextEditingController();

  addSchedule() async {
    List<dynamic> list = [
      {
        "subjectname": _subjectcontroller.text.trim().toUpperCase(),
        "classno": _classcontroller.text.trim().toUpperCase(),
        "facultyname": _facultycontroller.text.trim(),
        "batchname": _batchcontroller.text.trim().toUpperCase()
      }
    ];

    FocusManager.instance.primaryFocus?.unfocus();

    var a = await FirebaseFirestore.instance
        .collection("Admin")
        .doc("joQJQSsNtyQaojWnXlwdzjKCrJF3")
        .collection("schedular")
        .doc(dayddm.toLowerCase())
        .collection("slots")
        .doc(slot)
        .get();
    if (a.exists) {
      FirebaseFirestore.instance
          .collection("Admin")
          .doc("joQJQSsNtyQaojWnXlwdzjKCrJF3")
          .collection("schedular")
          .doc(dayddm.toLowerCase())
          .collection("slots")
          .doc(slot)
          .update({
        'classes': FieldValue.arrayUnion(list),
      });
    } else {
      FirebaseFirestore.instance
          .collection("Admin")
          .doc("joQJQSsNtyQaojWnXlwdzjKCrJF3")
          .collection("schedular")
          .doc(dayddm.toLowerCase())
          .collection("slots")
          .doc(slot)
          .set({
        'classes': FieldValue.arrayUnion(list),
      });
    }
    _classcontroller.clear();
    _facultycontroller.clear();
    _subjectcontroller.clear();
    _batchcontroller.clear();
  }

  var date = DateTime.now();
  // late var time;
  late String recorddate;
  @override
  void initState() {
    if ((date.hour == 9 && date.minute >= 10) ||
        (date.hour == 10 && date.minute <= 10)) {
      // time = "9:10 to 10:10";
      selectslot = 'Slot 1 9:10 to 10:10';
      slot = "slot1";
    } else if ((date.hour == 10 && date.minute >= 10) ||
        (date.hour == 11 && date.minute < 10)) {
      selectslot = 'Slot 2 10:10 to 11:10';

      // time = "10:10 to 11:10"
      slot = "slot2";
    } else if ((date.hour == 11 && date.minute >= 10) ||
        (date.hour == 12 && date.minute < 10)) {
      selectslot = 'lunch';

      // time = "12:10 to 13:10";
      slot = "lunch";
    } else if ((date.hour == 12 && date.minute >= 10) ||
        (date.hour == 13 && date.minute < 10)) {
      selectslot = 'Slot 3 12:10 to 13:10';

      // time = "12:10 to 13:10";
      slot = "slot3";
    } else if ((date.hour == 13 && date.minute >= 10) ||
        (date.hour == 14 && date.minute < 10)) {
      selectslot = 'Slot 4 13:10 to 14:10';

      // time = "13:10 to 14:10";
      slot = "slot4";
    } else if ((date.hour == 14 && date.minute >= 20) ||
        (date.hour == 15 && date.minute < 20)) {
      selectslot = 'Slot 5 14:20 to 15:20';

      // time = "14:10 to 15:10";
      slot = "slot5";
    } else if ((date.hour == 15 && date.minute >= 20) ||
        (date.hour == 16 && date.minute < 20)) {
      selectslot = 'Slot 6 15:20 to 16:20';

      // time = "15:10 to 16:10";
      slot = "slot6";
    } else {
      selectslot = 'No Slot';
      slot = "No Slot";
    }
    super.initState();
    recorddate = DateFormat('ddMMyyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Schedular",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          // backgroundColor: Color(0xFFbfeb91),
          // backgroundColor: const Color.fromARGB(255, 17, 0, 129),
          // backgroundColor: Color.fromARGB(255, 53, 150, 230),
          backgroundColor: Color(
            (0xFF3388ff),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  iconEnabledColor: Colors.blue,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  alignment: AlignmentDirectional.center,
                  value: dayddm,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  items: days.map((String days) {
                    return DropdownMenuItem(
                      value: days,
                      child: Text(days),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dayddm = value!;
                    });
                  },
                ),
              ),
              DropdownButton(
                iconEnabledColor: Colors.blue,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                alignment: AlignmentDirectional.center,
                value: selectslot,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                items: slots.map((String slots) {
                  return DropdownMenuItem(
                    value: slots,
                    child: Text(slots),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectslot = value!;
                    if (selectslot == "Slot 1 9:10 to 10:10") {
                      slot = "slot1";
                    } else if (selectslot == "Slot 2 10:10 to 11:10") {
                      slot = "slot2";
                    } else if (selectslot == "lunch") {
                      slot = "lunch";
                    } else if (selectslot == "Slot 3 12:10 to 13:10") {
                      slot = "slot3";
                    } else if (selectslot == "Slot 4 13:10 to 14:10") {
                      slot = "slot4";
                    } else if (selectslot == "Slot 5 14:20 to 15:20") {
                      slot = "slot5";
                    } else if (selectslot == "Slot 6 15:20 to 16:20") {
                      slot = "slot6";
                    } else if (selectslot == "No Slot") {
                      slot = "No Slot";
                    }
                  });
                },
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    TextField(
                      controller: _classcontroller,
                      decoration: const InputDecoration(
                        labelText: 'Enter Class No.',
                      ),
                    ),
                    TextField(
                      controller: _facultycontroller,
                      decoration: const InputDecoration(
                        labelText: 'Enter Faculty Name',
                      ),
                    ),
                    TextField(
                      controller: _subjectcontroller,
                      decoration: const InputDecoration(
                        labelText: 'Enter Subject Name',
                      ),
                    ),
                    TextField(
                      controller: _batchcontroller,
                      decoration: const InputDecoration(
                        labelText: 'Enter Batch Name (Ex. 6IT1)',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 120, right: 120),
                child: ElevatedButton(
                  onPressed: () {
                    addSchedule();
                  },
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
