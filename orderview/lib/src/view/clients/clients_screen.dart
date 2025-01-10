import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/utils/colors/colors.dart';
import 'package:orderview/src/widgets/alertdialog/dialog_widget.dart';
import 'package:orderview/src/widgets/button/custombutton_widget.dart';
import 'package:orderview/src/widgets/date/date_widget.dart';
import 'package:orderview/src/widgets/dropdown/dropdown_wigdet.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';
import 'package:intl/intl.dart';

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
                        CustomDialog.show(
                          context,
                          title: "Sucesso",
                          message: "A operação foi concluída com êxito.",
                          icon: LucideIcons.circleCheck,
                          iconColor: Colors.green,
                          confirmText: "OK",
                          onConfirm: () {
                            print("Ação confirmada!");
                          },
                        );
                      },
                      backgroundColor: AppColors.primaryBlue,
                      icon: LucideIcons.save,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
