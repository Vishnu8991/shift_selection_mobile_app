import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class Controller {

  List days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  List shift = [
    "Morning",
    "Afternoon",
    "Night",
  ];

  RxList scheduleShift = [].obs;

  RxList selectedDays = [].obs;
  RxList selectedShifts = [].obs;
  

  void addSelectedDay(String day){
    if (!selectedDays.contains(day)) {
      selectedDays.add(day);
    }
  }

  void removeSelectedDay(String day){
      selectedDays.remove(day);
  }

  
  void addShift(String shift){
    if (!selectedShifts.contains(shift)) {
      selectedDays.add(shift);
    }

  }

  void removeShift(String shift){
      selectedShifts.remove(shift);
  }


  void schedule(){
    for (var day in selectedDays) {
      for(var shift in selectedShifts){

        scheduleShift.add("$day $shift");
      }
      
    }
  }
}