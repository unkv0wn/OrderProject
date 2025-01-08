import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/widgets/button/custombutton_widget.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';

class PaymentformScreen extends StatelessWidget {
  PaymentformScreen({super.key});

  final TextEditingController _customController = TextEditingController();

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
                    "Cadastro de Forma de Pagamento.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                FormInput(
                    labelText: "Codigo Forma Pagamento",
                    customController: _customController,
                    isRequired: true,
                    validadorCustom: (value) {
                      return null;
                    },
                    hintText: "BL"),
                SizedBox(
                  height: 8,
                ),
                FormInput(
                    labelText: "Descrição Forma Pagamento",
                    customController: _customController,
                    isRequired: true,
                    validadorCustom: (value) {
                      return null;
                    },
                    hintText: "Boleto"),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 220,
                    height: 50,
                    child: CustomButton(
                      text: "Cadastrar",
                      onPressed: () {},
                      backgroundColor: Colors.amber,
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
