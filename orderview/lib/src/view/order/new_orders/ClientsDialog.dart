import 'package:flutter/material.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';

class Clientsdialog {
  static void show(
    BuildContext context, {
    Color iconColor = Colors.blue,
    String cancelText = "Cancelar",
    String confirmText = "Confirmar",
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool isDismissible = true,
  }) {
    TextEditingController customcontroller = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            color:
                Colors.transparent, // Fundo transparente para manter o estilo
            child: Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.4,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF1d1b20),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FormInput(
                          labelText: "Codigo",
                          customController: customcontroller,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "12",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 5,
                        child: FormInput(
                          labelText: "Nome",
                          customController: customcontroller,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "Ana Luiza Oliveira Moraes",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: FormInput(
                          labelText: "Codigo Forma",
                          customController: customcontroller,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "DI",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 5,
                        child: FormInput(
                          labelText: "Descrição",
                          customController: customcontroller,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "Dinheiro",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 50,
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onConfirm != null) onConfirm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          confirmText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
