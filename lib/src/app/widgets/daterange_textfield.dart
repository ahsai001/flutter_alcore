import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/custom_light_theme_widget.dart';
import 'package:flutter_alcore/src/utils/widget_util.dart';
import 'package:intl/intl.dart';

class DateRangeTextFieldController {
  TextEditingController? textEditingController;
  DateTimeRange? dateTimeRange;
  DateFormat? displayDateFormat;
  DateFormat? resultDateFormat;
  String? rangeDateConnector; //to or until or sampai
  DateRangeTextFieldController(
      {this.textEditingController,
      this.dateTimeRange,
      this.displayDateFormat,
      this.resultDateFormat,
      this.rangeDateConnector}) {
    init();
    updateRangeText();
  }

  bool isNeedCloseTEC = false;

  void init() {
    if (textEditingController == null) {
      textEditingController = TextEditingController();
      isNeedCloseTEC = true;
    }

    final today = DateTime.now();
    dateTimeRange ??=
        DateTimeRange(start: DateTime(today.year, today.month), end: today);
    displayDateFormat ??= DateFormat("dd MMM yyyy");
    resultDateFormat ??= DateFormat("yyyyMMdd");
    rangeDateConnector ??= "to";
  }

  void dispose() {
    if (isNeedCloseTEC) {
      textEditingController?.dispose();
    }
  }

  void updateRangeText([DateTimeRange? newDateTimeRange]) {
    if (newDateTimeRange != null) {
      dateTimeRange = newDateTimeRange;
    }
    textEditingController?.text = dateTimeRange == null
        ? ""
        : "${displayDateFormat?.format(dateTimeRange!.start)} $rangeDateConnector ${displayDateFormat?.format(dateTimeRange!.end)}";
  }

  String getStartDateResultString({bool isUtc = false}) {
    if (resultDateFormat != null && dateTimeRange != null) {
      return resultDateFormat!
          .format(isUtc ? dateTimeRange!.start.toUtc() : dateTimeRange!.start);
    } else {
      return "";
    }
  }

  String getEndDateResultString({bool isUtc = false}) {
    if (resultDateFormat != null && dateTimeRange != null) {
      return resultDateFormat!
          .format(isUtc ? dateTimeRange!.end.toUtc() : dateTimeRange!.end);
    } else {
      return "";
    }
  }

  String getRangeDateDisplayString() {
    return textEditingController!.text;
  }
}

class DateRangeTextField extends StatelessWidget {
  final DateRangeTextFieldController controller;
  const DateRangeTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.textEditingController,
      readOnly: true,
      onTap: () {
        _showDateRangeFilter(context);
      },
      decoration: const InputDecoration(label: Text("Date Range")),
    );
  }

  void _showDateRangeFilter(BuildContext context) async {
    final today = DateTime.now();
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      initialDateRange: controller.dateTimeRange,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(today.year - globalYearPeriodSelection, 1,
          1), // the earliest allowable
      lastDate: today, // the latest allowable
      currentDate: today,
      builder: (context, child) {
        return CustomLightThemeWidget(child: child!);
      },
      saveText: 'Done',
    );

    if (result != null) {
      controller.updateRangeText(result);
    }
  }
}
