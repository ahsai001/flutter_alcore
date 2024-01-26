import 'package:flutter/material.dart';
import 'package:flutter_alcore/flutter_alcore.dart';
import 'package:flutter_alcore/src/extensions/datetime_extension.dart';
import 'package:intl/intl.dart';

class DateTimeTextFieldController {
  TextEditingController? textEditingController;
  DateTime? dateTime;
  DateFormat? displayDateTimeFormat;
  DateFormat? resultDateTimeFormat;
  DateTimeTextFieldController(
      {this.textEditingController,
      this.dateTime,
      this.displayDateTimeFormat,
      this.resultDateTimeFormat}) {
    init();
    updateDateTimeText();
  }

  bool isNeedCloseTEC = false;
  void init() {
    if (textEditingController == null) {
      textEditingController = TextEditingController();
      isNeedCloseTEC = true;
    }
    dateTime ??= DateTime.now();
    displayDateTimeFormat ??= DateFormat("dd MMM yyyy HH:mm");
    resultDateTimeFormat ??= DateFormat("yyyyMMdd HH:mm");
  }

  void dispose() {
    if (isNeedCloseTEC) {
      textEditingController?.dispose();
    }
  }

  void updateDateTimeText([DateTime? newDate]) {
    if (newDate != null) {
      dateTime = newDate;
    }
    textEditingController?.text =
        dateTime == null ? "" : "${displayDateTimeFormat?.format(dateTime!)}";
  }

  String getDateTimeResultString() {
    if (resultDateTimeFormat != null && dateTime != null) {
      return resultDateTimeFormat!.format(dateTime!);
    } else {
      return "";
    }
  }

  String getDateTimeDisplayString() {
    return textEditingController!.text;
  }
}

class DateTimeTextField extends StatelessWidget {
  final String? label;
  final DateTimeTextFieldController controller;
  const DateTimeTextField({super.key, required this.controller, this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.textEditingController,
      readOnly: true,
      onTap: () {
        _showDateTimePicker(context);
      },
      decoration: InputDecoration(label: Text(label ?? "DateTime")),
    );
  }

  void _showDateTimePicker(BuildContext context) async {
    final today = DateTime.now();
    await showDatePicker(
      context: context,
      initialDate: controller.dateTime == null ? today : controller.dateTime!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(today.year - globalYearPeriodSelection, 1,
          1), // the earliest allowable
      lastDate: today, // the latest allowable
      currentDate: today,
      builder: (context, child) {
        return CustomLightThemeWidget(child: child!);
      },
      //confirmText: 'DONE',
    ).then((DateTime? date) {
      if (date != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return CustomLightThemeWidget(child: child!);
          },
        ).then((TimeOfDay? time) {
          if (time != null) {
            final result = date.setTimeOfDay(time);
            controller.updateDateTimeText(result);
          }
        });
      }
    });
  }
}
