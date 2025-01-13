import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/utils/colors/colors.dart';
import 'package:orderview/src/utils/dialoginfos/dialoginfo.dart';
import 'package:orderview/src/widgets/button/custombutton_widget.dart';
import 'package:orderview/src/widgets/date/date_widget.dart';
import 'package:orderview/src/widgets/dropdown/dropdown_wigdet.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';
import 'package:intl/intl.dart';
import 'package:orderview/src/widgets/table/table_widget.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final TextEditingController _customController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final isRequired = true;

  DateTime selectedDate = DateTime.now();

  void _onDateSelected(DateTime pickedDate) {
    setState(() {
      selectedDate = pickedDate;
      _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    });
  }

  final ValueNotifier<String> dropValueMark = ValueNotifier<String>(" ");

  final List<String> unidadesDeMedida = [
    'R',
    'AVD',
    'BR',
    'EST',
    'CND',
  ];

  final List<Map<String, dynamic>> _data = [
    {
      'Código': 'A1',
      'Nome': 'João Silva',
      'CPF': '123.456.789-00',
      'Cidade': 'São Paulo',
      'CEP': '01000-000',
    },
    {
      'Código': 'A2',
      'Nome': 'Maria Oliveira',
      'CPF': '987.654.321-00',
      'Cidade': 'Rio de Janeiro',
      'CEP': '02000-000',
    },
    {
      'Código': 'A3',
      'Nome': 'Carlos Pereira',
      'CPF': '456.789.123-00',
      'Cidade': 'Belo Horizonte',
      'CEP': '03000-000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Cadastro de Cliente.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FormInput(
                        labelText: "Nome",
                        customController: _customController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "Joao Silva",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: FormInput(
                        labelText: "CPF",
                        customController: _customController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "123.456.789-00",
                      ),
                    ),
                    SizedBox(width: 10),
                    DateWidget(
                      dateController: _dateController,
                      selectedDate: selectedDate,
                      isRequired: isRequired,
                      onDateSelected: _onDateSelected,
                      labeltext: 'Data de Nascimento',
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        valueNotifier: dropValueMark,
                        items: unidadesDeMedida,
                        hint: "R",
                        labelText: "Logradouro",
                        isRequired: true,
                        onChanged: (newValue) {
                          print("Selecionado: $newValue");
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 6,
                      child: FormInput(
                        labelText: "Rua",
                        customController: _customController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "Rua das Flores",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: FormInput(
                        labelText: "Complemento",
                        customController: _customController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "Apt 45",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: FormInput(
                        labelText: "Bairro",
                        customController: _customController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "Centro",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: FormInput(
                        labelText: "Cidade",
                        customController: _customController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "Sao Paulo",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: FormInput(
                        labelText: "CEP",
                        customController: _customController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "01000-000",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 220,
                    height: 50,
                    child: CustomButton(
                      text: "Cadastrar",
                      onPressed: () {
                        DialogsInfo.showErrorDialog(context);
                      },
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
                //table
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
                          'Nome',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'CPF',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.M,
                        label: Text(
                          'Cidade',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'CEP',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    cellBuilders: [
                      (row) => DataCell(Text(row['Código'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['Nome'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['CPF'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['Cidade'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['CEP'],
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
