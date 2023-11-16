import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/aligned_text.dart';

class CustomPieChart extends StatefulWidget {
  final List<PieChartSectionDataInfo> sections;
  final String? centeredText;
  final String? captionText;

  final double? touchedRadius;
  final double? untouchedRadius;
  final double? touchedFontSize;
  final double? untouchedFontSize;
  const CustomPieChart(
      {super.key,
      required this.sections,
      this.touchedRadius = 60.0,
      this.untouchedRadius = 50.0,
      this.touchedFontSize = 20.0,
      this.untouchedFontSize = 16.0,
      this.centeredText,
      this.captionText});

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PieChart(PieChartData(
                  startDegreeOffset: 270,
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 30,
                  sections: widget.sections.mapIndexed((index, element) {
                    final isTouched = index == touchedIndex;
                    final fontSize = isTouched
                        ? widget.touchedFontSize
                        : widget.untouchedFontSize;
                    final radius = isTouched
                        ? widget.touchedRadius
                        : widget.untouchedRadius;

                    //const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
                    return PieChartSectionData(
                        value: element.value,
                        color: element.color,
                        radius: radius,
                        showTitle: false,
                        // title: "${element.value} %",
                        titleStyle: TextStyle(
                          fontSize: fontSize,
                          //fontWeight: FontWeight.bold,
                          //shadows: shadows,
                        ));
                  }).toList())),
            ),
            Text(
              widget.centeredText ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        if (widget.captionText != null)
          AlignedText(
            widget.captionText!,
            alignment: Alignment.center,
          )
      ],
    );
  }
}

class PieChartSectionDataInfo {
  double? value;
  Color? color;
  PieChartSectionDataInfo({this.value, this.color});
}
