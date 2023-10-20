// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_catch_clause, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PastEntry extends StatefulWidget {
  const PastEntry({super.key});

  @override
  State<PastEntry> createState() => _PastEntryState();
}

class _PastEntryState extends State<PastEntry> {
  List<bool> checkbox = [true, true, true, true, true];
  String recorddate = DateFormat('ddMMyyyy').format(DateTime.now());
  List<dynamic> records = [
    {
      "subjectname": "",
      "classno": "",
      "facultyname": "",
      "batchname": "",
      "students": "",
      "proxyname": ""
    }
  ];

  String selectslot = "";
  String slot = "";
  var slots = [
    'Slot 1 9:10 to 10:10',
    'Slot 2 10:10 to 11:10',
    'Slot 3 12:10 to 13:10',
    'Slot 4 13:10 to 14:10',
    'Slot 5 14:20 to 15:20',
    'Slot 6 15:20 to 16:20',
    'No Slot'
  ];
  // ignore: prefer_typing_uninitialized_variables
  late var time;
  // String slot = "slot1";
  final dateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));

  var date = DateTime.now();

  @override
  void initState() {
    if ((date.hour == 9 && date.minute >= 10) ||
        (date.hour == 10 && date.minute <= 10)) {
      selectslot = 'Slot 1 9:10 to 10:10';
      slot = "slot1";
    } else if ((date.hour == 10 && date.minute >= 10) ||
        (date.hour == 11 && date.minute < 10)) {
      selectslot = 'Slot 2 10:10 to 11:10';
      slot = "slot2";
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
    } else if ((date.hour == 14 && date.minute >= 10 && date.minute <= 20)) {
      // time = "Short Breaks";
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
      slot = "slot7";
    }
    super.initState();
    recorddate = DateFormat('ddMMyyyy').format(DateTime.now());

    super.initState();
    getdata();
  }

  getdata() async {
    records = [
      {
        "subjectname": "",
        "classno": "",
        "facultyname": "",
        "batchname": "",
        "students": "",
        "proxyname": ""
      }
    ];
    try {
      await FirebaseFirestore.instance
          .collection("Admin")
          .doc("joQJQSsNtyQaojWnXlwdzjKCrJF3")
          .collection("records")
          .doc(recorddate)
          .collection("slots")
          .doc(slot)
          .get()
          .then((value) {
        final doc = value.data()!;
        setState(() {
          records = doc['records'];
        });
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  deleteCollection(int index1) async {
    try {
      await FirebaseFirestore.instance
          .collection("Admin")
          .doc("joQJQSsNtyQaojWnXlwdzjKCrJF3")
          .collection("records")
          .doc(recorddate)
          .collection("slots")
          .doc(slot)
          .update({
        'records': FieldValue.arrayRemove([records[index1]]),
      });
    } on Exception catch (e) {}
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Past Entry",
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
                // initialValue: SelectedDate,
                controller:
                    dateController, //editing controller of this TextField
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Select Date", //label text of field
                ),
                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  //when click we have to show the datepicker
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(
                          2023), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now());
                  if (pickedDate != null) {
                    //get the picked date in the format => 2022-07-04 00:00:00.000
                    String formattedDate = DateFormat('dd-MM-yyyy').format(
                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                    //formatted date output using intl package =>  2022-07-04
                    //You can format date as per your need

                    setState(() {
                      dateController.text = formattedDate
                          .toString(); //set foratted date to TextField value.
                      recorddate = DateFormat('ddMMyyyy').format(pickedDate);
                      getdata();
                    });
                  } else {}
                }),
            const SizedBox(height: 10),
            DropdownButton(
              iconEnabledColor: Colors.blue,
              style: const TextStyle(fontSize: 18, color: Colors.black),
              dropdownColor: const Color.fromARGB(255, 133, 177, 244),
              borderRadius: BorderRadius.circular(12),
              alignment: AlignmentDirectional.center,
              value: selectslot,
              // value: timenow,

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
                  } else if (selectslot == "Slot 3 12:10 to 13:10") {
                    slot = "slot3";
                  } else if (selectslot == "Slot 4 13:10 to 14:10") {
                    slot = "slot4";
                  } else if (selectslot == "Slot 5 14:20 to 15:20") {
                    slot = "slot5";
                  } else if (selectslot == "Slot 6 15:20 to 16:20") {
                    slot = "slot6";
                  } else {
                    // time = "${date.hour}:${date.minute}";
                    time = DateFormat('hh:mm a').format(DateTime.now());

                    slot = "slot7";
                  }
                });
                getdata();
              },
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: records.length,
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
                              Text(records[index]["classno"]),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15),
                              Text(records[index]["batchname"]),
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
                                              records[index]["facultyname"],
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
                                          records[index]["subjectname"],
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Students:",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          records[index]["students"],
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Proxy:",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          records[index]["proxyname"],
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
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
      ),
    );
  }
}
