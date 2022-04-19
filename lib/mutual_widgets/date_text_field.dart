import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/mutual_widgets/platform_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTextField extends StatefulWidget {
  final ServiceRequest serviceRequest;

  DateTextField(this.serviceRequest);

  @override
  _DateTextFieldState createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  DateTime date;
  String formattedDate;

  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    date = widget.serviceRequest.date ?? DateTime.now();
    widget.serviceRequest.date ??= date;

    formattedDate = DateFormat('yyyy-MM-dd – h:mma').format(date);
    textFieldController.text = formattedDate;

    return PlatformSwitch(
      // Android Date Picker
      android: GestureDetector(
        onTap: () async {
          final selectedDate =
              await _selectDateTime(context, initialDate: date);
          if (selectedDate == null) return;

          final selectedTime = await _selectTime(context, initialDate: date);
          if (selectedTime == null) return;

          setState(
            () {
              widget.serviceRequest.date = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              );
            },
          );
        },
        child: TextField(
          enabled: false,
          controller: textFieldController,
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Date',
            hintText: 'Tap To Enter Date',
            labelStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: Icon(
              Icons.calendar_today,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
      // IOS Date Picker
      ios: GestureDetector(
        onTap: () async {
          _buildCupertinoDatePicker(context);
        },
        child: TextField(
          enabled: false,
          controller: textFieldController,
          // keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Date',
            hintText: 'Tap To Enter Date',
            labelStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: Icon(
              Icons.calendar_today,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  _buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: 250,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              onDateTimeChanged: (picked) {
                // print("DATE: " + picked.toIso8601String());

                if (picked != null)
                  setState(() {
                    widget.serviceRequest.date = picked;
                  });
              },
              initialDateTime: date,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }

  Future<TimeOfDay> _selectTime(BuildContext context, {DateTime initialDate}) {
    return showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: initialDate.hour, minute: initialDate.minute),
    );
  }

  Future<DateTime> _selectDateTime(BuildContext context,
      {DateTime initialDate}) {
    final now = DateTime.now();
    final newestDate = initialDate.isAfter(now) ? initialDate : now;
    return showDatePicker(
      context: context,
      initialDate: date.add(Duration(seconds: 1)),
      firstDate: date,
      lastDate: DateTime(2100),
    );
  }
}
