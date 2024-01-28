import 'package:flutter/material.dart';
import 'package:flutter_alcore/flutter_alcore.dart';
import 'package:intl/intl.dart';

class DateTextFieldController {
  TextEditingController? textEditingController;
  DateTime? dateTime;
  DateFormat? displayDateFormat;
  DateFormat? resultDateFormat;
  DateTextFieldController(
      {this.textEditingController,
      this.dateTime,
      this.displayDateFormat,
      this.resultDateFormat}) {
    init();
    updateDateText();
  }

  bool isNeedCloseTEC = false;
  void init() {
    if (textEditingController == null) {
      textEditingController = TextEditingController();
      isNeedCloseTEC = true;
    }
    dateTime ??= DateTime.now();
    displayDateFormat ??= DateFormat("dd MMM yyyy");
    resultDateFormat ??= DateFormat("yyyyMMdd");
  }

  void dispose() {
    if (isNeedCloseTEC) {
      textEditingController?.dispose();
    }
  }

  void updateDateText([DateTime? newDate]) {
    if (newDate != null) {
      dateTime = newDate;
    }
    textEditingController?.text =
        dateTime == null ? "" : "${displayDateFormat?.format(dateTime!)}";
  }

  String getDateResultString() {
    if (resultDateFormat != null && dateTime != null) {
      return resultDateFormat!.format(dateTime!);
    } else {
      return "";
    }
  }

  DateTime? getDateResult() {
    return dateTime;
  }

  String getDateDisplayString() {
    return textEditingController!.text;
  }
}

class DateTextField extends StatelessWidget {
  final String? label;
  final DateTextFieldController controller;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool todayAsLastDate;
  const DateTextField(
      {super.key,
      required this.controller,
      this.label,
      this.firstDate,
      this.lastDate,
      this.todayAsLastDate = true});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.textEditingController,
      readOnly: true,
      onTap: () {
        _showDateRangeFilter(context);
      },
      decoration: InputDecoration(label: Text(label ?? "Date")),
    );
  }

  void _showDateRangeFilter(BuildContext context) async {
    final today = DateTime.now();
    DateTime? result = await showDatePicker(
      context: context,
      initialDate: controller.dateTime == null ? today : controller.dateTime!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: firstDate ??
          DateTime(today.year - globalYearPeriodSelection, 1,
              1), // the earliest allowable
      lastDate: lastDate ??
          (todayAsLastDate
              ? today
              : DateTime(today.year + globalYearPeriodSelection, 12,
                  31)), // the latest allowable
      currentDate: today,
      builder: (context, child) {
        return CustomLightThemeWidget(child: child!);
      },
      //confirmText: 'DONE',
    );

    if (result != null) {
      controller.updateDateText(result);
    }
  }
}
