import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shift_selection_mobile_app/controller/controller.dart';

class HomePage extends StatelessWidget {

  final Controller controller = Get.put(Controller());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
              
    return Scaffold(backgroundColor:Color(0xff98ecec) ,
      appBar: AppBar(title: Text("Schedule Working Time"),centerTitle: true,backgroundColor: Colors.cyan.shade600,),      
      body: ListView.builder(
        itemCount: controller.days.length,
        itemBuilder: (BuildContext context,int dayIndex) {
        return 
        Container(
          child: Card(
            child: 
            Container(
              padding: EdgeInsets.all(10),
          color: Colors.cyan.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => 
                        Checkbox(value: 
                        controller.selectedDays.contains(controller.days[dayIndex]), 
                          onChanged: (bool? value){
                          if (value!=null && value) {
                          controller.addSelectedDay(controller.days[dayIndex]);
                          for(var shift in controller.shift){
                            controller.addShift('${controller.days[dayIndex]} $shift');
                          }
                          }else{
                            controller.removeSelectedDay(controller.days[dayIndex]);
                          }
                        },),
                      ),
                      Text(controller.days[dayIndex]),
                    ],
                  ),
                  for(var shift in controller.shift) InkWell(
                    onTap: () {
                      String shiftSelection = '${controller.days[dayIndex]} $shift';
                      if (controller.selectedShifts.contains(shiftSelection)) {
                        controller.removeShift(shiftSelection);
                      }else{
                        controller.addShift(shiftSelection);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                      color: controller.selectedShifts.contains('${controller.days[dayIndex]} $shift')? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                      child: Text(shift)),
                  )
                  ],
              ),
            ),
          ),
        );
      },),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.cyan.shade700,
        onPressed: (){
          controller.schedule();
        }, 
        label: Text("Schedule", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
      
    );
  }
}