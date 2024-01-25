import 'package:data_table_2/data_table_2.dart';

class ColumnInfo {
  final String? title;
  final ColumnSize? size;
  final bool? numeric;
  final double? fixedWidth;
  const ColumnInfo(this.title, this.size,
      {this.numeric = false, this.fixedWidth});
}
