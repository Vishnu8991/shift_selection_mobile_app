import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shift_selection_mobile_app/controller/controller.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff98ecec),
      appBar: AppBar(
        title: Text("Selected Schedule"),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade600,
      ),
      body: Column(
        children: [
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              width: double.infinity,
              color: Colors.white,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Day",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                Text("Shift",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ],
            ),),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                final List<Map<String, String>> scheduleShift =
                    Get.find<Controller>().scheduleShift.toList();
              
                Map<String, List<String>> selectedShiftsByDay = {};
              
                scheduleShift.forEach((shift) {
                  String day = shift["day"]!;
                  String selectedShift = shift["shift"]!;
                  if (selectedShiftsByDay.containsKey(day)) {
                    if (!selectedShiftsByDay[day]!.contains(selectedShift)) {
                      selectedShiftsByDay[day]!.add(selectedShift);
                    }
                  } else {
                    selectedShiftsByDay[day] = [selectedShift];
                  }
                });
              
                return ListView.builder(
                  itemCount: selectedShiftsByDay.length,
                  itemBuilder: (context, index) {
                    String day = selectedShiftsByDay.keys.elementAt(index);
                    List<String> shifts = selectedShiftsByDay.values.elementAt(index);
                    return 
                    Container(
                          decoration: BoxDecoration(
                          color: Colors.white,
                            border: Border.all()),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                          color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                day,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),),),
                        
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                "${shifts.join(", ")}",
                                style: TextStyle(fontSize: 16),
                              ),
                                  )
                                
                              ],
                            ),
                          ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
