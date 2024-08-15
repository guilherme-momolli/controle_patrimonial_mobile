import 'package:flutter/material.dart';

class CalendarManager {
  static final CalendarManager _instance = CalendarManager._internal();

  factory CalendarManager() {
    return _instance;
  }

  CalendarManager._internal();

  DateTime? _selectedDate;

  DateTime get selectedDate => _selectedDate!;

  set selectedDate(DateTime date) {
    _selectedDate = date;
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;
    }

    return pickedDate;
  }
}
