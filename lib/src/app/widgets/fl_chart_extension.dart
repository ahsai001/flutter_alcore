import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

extension ShowingTooltipIndicatorsForLineChart on List<LineChartBarData> {
  List<ShowingTooltipIndicators> getShowingTooltipIndicators() {
    List<ShowingTooltipIndicators> result = [];
    forEachIndexed((index, lineChartBarData) {
      result.addAll(lineChartBarData.spots.mapIndexed((spotIndex, spot) {
        return ShowingTooltipIndicators([
          LineBarSpot(lineChartBarData, index, spot),
        ]);
      }).toList());
    });

    return result;
  }
}
