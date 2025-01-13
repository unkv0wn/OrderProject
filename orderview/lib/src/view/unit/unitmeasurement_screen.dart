import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/utils/colors/colors.dart';
import 'package:orderview/src/widgets/button/custombutton_widget.dart';
import 'package:orderview/src/widgets/dropdown/dropdown_wigdet.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';
import 'package:orderview/src/widgets/table/table_widget.dart';

class MeasurementScreen extends StatelessWidget {
  MeasurementScreen({super.key});

  final TextEditingController _customController = TextEditingController();

  final ValueNotifier<String> dropValueMark = ValueNotifier<String>(" ");

  final List<String> unidadesDeMedida = [
    'R',
    'AVD',
    'BR',
    'EST',
    'CND',
  ];

    final List<Map<String, dynamic>> _data = [
    {'Código': 'UN', 'Descricao': 'UNIDADE', 'Ativo': 'S'},
    {'Código': 'KG', 'Descricao': 'KILOS', 'Ativo': 'F'},
    {'Código': 'GR', 'Descricao': 'GRAMAS', 'Ativo': 'S'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Cadastro de Unidade de Medida.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                FormInput(
                    labelText: "Codigo Unidade Medida",
                    customController: _customController,
                    isRequired: true,
                    validadorCustom: (value) {
                      return null;
                    },
                    hintText: "UN"),
                SizedBox(
                  height: 8,
                ),
                FormInput(
                    labelText: "Descrição Unidade Medida",
                    customController: _customController,
                    isRequired: true,
                    validadorCustom: (value) {
                      return null;
                    },
                    hintText: "Unidade"),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 220,
                    height: 50,
                    child: CustomButton(
                      text: "Cadastrar",
                      onPressed: () {},
                      backgroundColor: AppColors.primaryBlue,
                      icon: LucideIcons.save,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      width: 120,
                      height: 60,
                      child: CustomDropdown(
                          valueNotifier: dropValueMark,
                          items: unidadesDeMedida,
                          hint: "Filtros")),
                ),
                SizedBox(
                   width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: CustomPaginatedDataTable<Map<String, dynamic>>(
                    data:
                        _data, // Aqui você pode passar diferentes listas de dados
                    columns: const [
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'Código',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.M,
                        label: Text(
                          'Descricao',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'Ativo',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    cellBuilders: [
                      (row) => DataCell(Text(row['Código'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['Descricao'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['Ativo'],
                          style: TextStyle(color: Colors.white))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
