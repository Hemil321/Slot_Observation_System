// ignore: implementation_imports

// ignore_for_file: unused_catch_clause

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: implementation_imports

// ignore: camel_case_types
class viewcal extends StatefulWidget {
  const viewcal({super.key});

  @override
  State<viewcal> createState() => _viewcalState();
}

// ignore: camel_case_types
class _viewcalState extends State<viewcal> {
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

  String selectslot = '';
  var slots = [
    'Slot 1 9:10 to 10:10',
    'Slot 2 10:10 to 11:10',
    'lunch',
    'Slot 3 12:10 to 13:10',
    'Slot 4 13:10 to 14:10',
    'Slot 5 14:20 to 15:20',
    'Slot 6 15:20 to 16:20',
    'No Slot'
  ];
  List<dynamic> classes = [
    {"subjectname": "", "classno": "", "facultyname": "", "batchname": ""}
  ];
  String slot = "";
  var date = DateTime.now();
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

      // time = "10:10 to 11:10";
      slot = "slot2";
    } else if ((date.hour == 11 && date.minute >= 10) ||
        (date.hour == 12 && date.minute < 10)) {
      selectslot = 'lunch';
      slot = 'lunch';
      // time = "Lunch Break";
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
      // time = "${date.hour}:${date.minute}";
      // time = DateFormat('hh:mm a').format(DateTime.now());
      selectslot = "No Slot";
      slot = "No Slot";
    }
    super.initState();
    recorddate = DateFormat('ddMMyyyy').format(DateTime.now());
    super.initState();
    getdata();
  }

  getdata() async {
    try {
      await FirebaseFirestore.instance
          .collection("Admin")
          .doc("joQJQSsNtyQaojWnXlwdzjKCrJF3")
          .collection("schedular")
          .doc(dayddm.toLowerCase())
          .collection("slots")
          .doc(slot)
          .get()
          .then((value) {
        final doc = value.data()!;
        setState(() {
          classes = doc['classes'];
        });
      });
      // ignore: empty_catches
    } catch (e) {
      classes = [
        {"subjectname": "", "classno": "", "facultyname": "", "batchname": ""}
      ];
    }
  }

  deleteCollection(int index1) async {
    try {
      await FirebaseFirestore.instance
          .collection("Admin")
          .doc("joQJQSsNtyQaojWnXlwdzjKCrJF3")
          .collection("schedular")
          .doc(dayddm.toLowerCase())
          .collection("slots")
          .doc(slot)
          .update({
        'classes': FieldValue.arrayRemove([classes[index1]]),
      });
      // ignore: empty_catches
    } on Exception catch (e) {}
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("View",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          // backgroundColor: Color(0xFFbfeb91),
          // backgroundColor: const Color.fromARGB(255, 17, 0, 129),
          // backgroundColor: Color.fromARGB(255, 53, 150, 230),
          backgroundColor: const Color(
            (0xFF3388ff),
          )),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton(
                iconEnabledColor: Colors.blue,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                dropdownColor: const Color.fromARGB(255, 133, 177, 244),
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
                    getdata();
                  });
                },
              ),
              DropdownButton(
                iconEnabledColor: Colors.blue,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                dropdownColor: const Color.fromARGB(255, 133, 177, 244),
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
                    getdata();
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ExpansionTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        collapsedBackgroundColor: Colors.cyan[50],
                        backgroundColor: Colors.red[50],
                        title: Row(
                          children: [
                            const Text("Class No: "),
                            Text(classes[index]["classno"]),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2),
                            Text(classes[index]["batchname"]),
                          ],
                        ),

                        // subtitle: const Text("Hello"),
                        children: [
                          const Divider(
                            thickness: 0.3,
                            height: 2.0,
                            color: Colors.black,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: Column(children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Faculty Name:",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            classes[index]["facultyname"],
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Subject Name:",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        classes[index]["subjectname"],
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: MaterialButton(
                                          onPressed: () {
                                            deleteCollection(index);
                                          },
                                          // ignore: sort_child_properties_last
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          color: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          elevation: 1),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
