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

  RxList<Map<String, String>> scheduleShift = RxList<Map<String, String>>([]);

  void addToSchedule(String day, String shift) {
    bool isShiftAlreadyAdded = scheduleShift.any((item) =>
        item['day'] == day && item['shift'] == shift);

    if (!isShiftAlreadyAdded) {
      scheduleShift.add({"day": day, "shift": shift});
    }
  }
}
