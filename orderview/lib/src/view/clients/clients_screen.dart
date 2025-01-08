import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/utils/colors/colors.dart';
import 'package:orderview/src/widgets/button/custombutton_widget.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';

class ClientsScreen extends StatelessWidget {
  ClientsScreen({super.key});

  final TextEditingController _customController = TextEditingController();

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
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "Joao Silva"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FormInput(
                          labelText: "Nr CPF",
                          customController: _customController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "123.456.789-00"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FormInput(
                          labelText: "Data Nascimento",
                          customController: _customController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "09/04/2004"),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: FormInput(
                          labelText: "Logradouro",
                          customController: _customController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "R"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FormInput(
                          labelText: "Rua",
                          customController: _customController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "Rua das Flores"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: FormInput(
                          labelText: "Complemento",
                          customController: _customController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "Apt 45"),
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
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "Centro"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FormInput(
                          labelText: "Cidade",
                          customController: _customController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "Sao Paulo"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FormInput(
                          labelText: "CEP",
                          customController: _customController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "01000-000"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
