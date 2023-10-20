// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, sort_child_properties_last, file_names

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TakeView extends StatefulWidget {
  const TakeView({super.key});

  @override
  State<TakeView> createState() => _TakeViewState();
}

class _TakeViewState extends State<TakeView> {
  var date = DateTime.now();
  List<bool> checkbox = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  List<bool> visi = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  List<bool> proxy = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  final List<TextEditingController> _controllers = [];
  final List<TextEditingController> _proxycontrollers = [];
  // late bool _proxy;
  late var time;
  List<dynamic> classes = [
    {
      "subjectname": "",
      "classno": "",
      "facultyname": "",
      "batchname": "",
      "proxyname": ""
    }
  ];

  late String slot, recorddate;
  String day = DateFormat.EEEE().format(DateTime.now()).toLowerCase();
  @override
  void initState() {
    if ((date.hour == 9 && date.minute >= 10) ||
        (date.hour == 10 && date.minute <= 10)) {
      time = "9:10 to 10:10";
      slot = "slot1";
    } else if ((date.hour == 10 && date.minute >= 10) ||
        (date.hour == 11 && date.minute < 10)) {
      time = "10:10 to 11:10";
      slot = "slot2";
    } else if ((date.hour == 11 && date.minute >= 10) ||
        (date.hour == 12 && date.minute < 10)) {
      time = "Lunch Break";
    } else if ((date.hour == 12 && date.minute >= 10) ||
        (date.hour == 13 && date.minute < 10)) {
      time = "12:10 to 13:10";
      slot = "slot3";
    } else if ((date.hour == 13 && date.minute >= 10) ||
        (date.hour == 14 && date.minute < 10)) {
      time = "13:10 to 14:10";
      slot = "slot4";
    } else if ((date.hour == 14 && date.minute >= 10 && date.minute <= 20)) {
      time = "Short Breaks";
    } else if ((date.hour == 14 && date.minute >= 20) ||
        (date.hour == 15 && date.minute < 10)) {
      time = "14:10 to 15:10";
      slot = "slot5";
    } else if ((date.hour == 15 && date.minute >= 10) ||
        (date.hour == 16 && date.minute < 20)) {
      time = "15:10 to 16:10";
      slot = "slot6";
    } else {
      // time = "${date.hour}:${date.minute}";
      time = DateFormat('hh:mm a').format(DateTime.now());

      slot = "slot7";
    }
    super.initState();
    recorddate = DateFormat('ddMMyyyy').format(DateTime.now());
    getdata();
  }

  getdata() async {
    try {
      await FirebaseFirestore.instance
          .collection("Admin")
          .doc("joQJQSsNtyQaojWnXlwdzjKCrJF3")
          .collection("schedular")
          .doc(day)
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
    } catch (e) {}
  }

  savedata(index1) async {
    List<dynamic> list = [
      {
        "students": _controllers[index1].text.toString(),
        "subjectname": classes[index1]["subjectname"],
        "classno": classes[index1]["classno"],
        "facultyname": classes[index1]["facultyname"],
        "batchname": classes[index1]["batchname"],
        "proxyname": _proxycontrollers[index1].text.toString().isNotEmpty ? _proxycontrollers[index1].text.toString() : "NA" 
      }
    ];

    FocusManager.instance.primaryFocus?.unfocus();

    var a = await FirebaseFirestore.instance
        .collection("Admin")
        .doc("joQJQSsNtyQaojWnXlwdzjKCrJF3")
        .collection("records")
        .doc(recorddate)
        .collection("slots")
        .doc(slot)
        .get();
    if (a.exists) {
      FirebaseFirestore.instance
          .collection("Admin")
          .doc("joQJQSsNtyQaojWnXlwdzjKCrJF3")
          .collection("records")
          .doc(recorddate)
          .collection("slots")
          .doc(slot)
          .update({
        'records': FieldValue.arrayUnion(list),
      });
    } else {
      FirebaseFirestore.instance
          .collection("Admin")
          .doc("joQJQSsNtyQaojWnXlwdzjKCrJF3")
          .collection("records")
          .doc(recorddate)
          .collection("slots")
          .doc(slot)
          .set({
        'records': FieldValue.arrayUnion(list),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Take Follow",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            backgroundColor: const Color(
              (0xFF3388ff),
            )),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 300,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month_outlined),
                        const SizedBox(width: 10),
                        Text(
                          "${date.day}/${date.month}/${date.year} $time",
                          style: const TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  _controllers.add(TextEditingController());
                  _proxycontrollers.add(TextEditingController());
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
                      child: Visibility(
                        visible: visi[index],
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
                              Text("Class No: "),
                              Text(classes[index]["classno"]),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2),
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
                                            Text(
                                              "Faculty Name:",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              classes[index]["facultyname"],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Checkbox(
                                            activeColor: Colors.black,
                                            focusColor: Colors.blue,
                                            value: checkbox[index],
                                            onChanged: (value) {
                                              setState(() {
                                                checkbox[index] = value!;
                                              });
                                            })
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Subject Name:",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          classes[index]["subjectname"],
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "No of Student:",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                              width: 150,
                                              child: TextFormField(
                                                controller: _controllers[index],
                                                style: const TextStyle(
                                                    fontSize: 16),
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            'Enter no of student',
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                        )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    checkbox[index] == true
                                        ? Text("")
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Proxy Faculty:",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    width: 150,
                                                    child: TextFormField(
                                                      controller:
                                                          _proxycontrollers[
                                                              index],
                                                      // controller:
                                                      //     _controllers[index],
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                      // keyboardType:
                                                      //     TextInputType.number,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Name of proxy faculty',
                                                              enabledBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              focusedBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: MaterialButton(
                                            onPressed: () {
                                              savedata(index);
                                              setState(() {
                                                visi[index] = false;
                                                // visit = false;
                                              });
                                            },
                                            child: Text(
                                              "Save",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
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
                    ),
                  );
                }),
          )
        ]));
  }
}
