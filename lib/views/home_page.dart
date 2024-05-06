import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_selection_mobile_app/controller/controller.dart';
import 'package:shift_selection_mobile_app/views/schedule_screen.dart'; 

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Controller controller = Get.put(Controller());
  late List<List<bool>> shiftColors;
  late List<bool> dayCheckboxes;
  late List<bool> anyShiftSelected;

  @override
  void initState() {
    super.initState();
    shiftColors = List.generate(
      controller.days.length, 
      (dayIndex) => List.generate(controller.shift.length, (shiftIndex) => false),
    );
    dayCheckboxes = List.filled(controller.days.length, false);
    anyShiftSelected = List.filled(controller.days.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff98ecec),
      appBar: AppBar(
        title: Text("Schedule Working Time"),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade600,
      ),
      body: ListView.builder(
        itemCount: controller.days.length,
        itemBuilder: (BuildContext context, int dayIndex) {
          return Container(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.cyan.shade50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: dayCheckboxes[dayIndex],
                          onChanged: anyShiftSelected[dayIndex]
                              ? (bool? value) {
                                  setState(() {
                                    dayCheckboxes[dayIndex] = value!;
                                  });
                                }
                              : null,
                        ),
                        Text(controller.days[dayIndex]),
                      ],
                    ),
                    Row(
                      children: List.generate(
                        controller.shift.length,
                        (shiftIndex) => GestureDetector(
                          onTap: () {
                            setState(() {
                              shiftColors[dayIndex][shiftIndex] =
                                  !shiftColors[dayIndex][shiftIndex];
                              anyShiftSelected[dayIndex] =
                                  shiftColors[dayIndex].contains(true);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: shiftColors[dayIndex][shiftIndex]
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(controller.shift[shiftIndex]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.cyan.shade700,
        onPressed: () {
          addToSchedule();
          Get.to(() => SchedulePage());
        },
        label: Text(
          "Schedule",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void addToSchedule() {
    for (int i = 0; i < dayCheckboxes.length; i++) {
      if (dayCheckboxes[i]) {
        for (int j = 0; j < shiftColors[i].length; j++) {
          if (shiftColors[i][j]) {
            controller.addToSchedule(controller.days[i], controller.shift[j]);
          }
        }
      }
    }
  }
}
