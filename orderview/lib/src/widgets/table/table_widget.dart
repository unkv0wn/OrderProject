import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CustomPaginatedDataTable<T> extends StatelessWidget {
  final List<T> data;
  final List<DataColumn> columns;
  final int rowsPerPage;
  final Color cellTextColor;
  final List<DataCell Function(T)> cellBuilders;

  const CustomPaginatedDataTable({
    super.key,
    required this.data,
    required this.columns,
    required this.cellBuilders,
    this.rowsPerPage = 10,
    this.cellTextColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable2(
      rowsPerPage: rowsPerPage,
      columnSpacing: 5,
      horizontalMargin: 5,
      minWidth: 600,
      columns: columns,
      source: _DataTableSource(data, cellBuilders, cellTextColor),
    );
  }
}

class _DataTableSource<T> extends DataTableSource {
  final List<T> data;
  final List<DataCell Function(T)> cellBuilders;
  final Color cellTextColor;

  _DataTableSource(this.data, this.cellBuilders, this.cellTextColor);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final row = data[index];
    return DataRow(cells: cellBuilders.map((builder) => builder(row)).toList());
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
