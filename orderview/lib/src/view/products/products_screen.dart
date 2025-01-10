import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/utils/colors/colors.dart';
import 'package:orderview/src/widgets/button/custombutton_widget.dart';
import 'package:orderview/src/widgets/dropdown/dropdown_wigdet.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  final TextEditingController _customController = TextEditingController();
  final TextEditingController _unidadeDescController = TextEditingController();
  final TextEditingController _marcaDescController = TextEditingController();
  final ValueNotifier<String> dropValue = ValueNotifier<String>(" ");
  final ValueNotifier<String> dropValueMark = ValueNotifier<String>(" ");

  final Map<String, String> unidadesDeMedida = {
    'KG': 'Quilograma',
    'G': 'Grama',
    'MG': 'Miligrama',
  };

  final Map<String, String> marcas = {
    '1': 'MarcaX',
    '2': 'MarcaY',
    '3': 'MarcaZ',
  };

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
                    "Cadastro de Produtos.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FormInput(
                          labelText: "Codigo",
                          customController: _customController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: ""),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 8,
                      child: FormInput(
                          labelText: "Descrição",
                          customController: _customController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "Produto exemplo"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        valueNotifier: dropValue,
                        items: unidadesDeMedida.keys.toList(),
                        hint: "Unidade",
                        labelText: "Unidade Medida",
                        isRequired: true, // Exibirá o '*' ao lado do rótulo
                        onChanged: (newValue) {
                          _unidadeDescController.text =
                              unidadesDeMedida[newValue] ?? '';
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 8,
                      child: FormInput(
                          labelText: "Descrição",
                          customController: _unidadeDescController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "Unidade"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        valueNotifier: dropValueMark,
                        items: marcas.keys.toList(),
                        hint: "Marca",
                        labelText: "Marca",
                        isRequired: true,
                        onChanged: (newValue) {
                          _marcaDescController.text = marcas[newValue] ?? '';
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 8,
                      child: FormInput(
                          labelText: "Descrição",
                          customController: _marcaDescController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "MarcaX"),
                    ),
                  ],
                ),
                FormInput(
                    labelText: "Valor Unitario",
                    customController: _customController,
                    isRequired: true,
                    validadorCustom: (value) {
                      return null;
                    },
                    hintText: "99.00"),
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
