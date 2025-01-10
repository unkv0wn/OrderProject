import 'package:flutter/material.dart';
import 'package:orderview/src/utils/colors/colors.dart';

class CustomDialog {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    IconData? icon,
    Color iconColor = Colors.blue,
    String cancelText = "Cancelar",
    String confirmText = "Confirmar",
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool isDismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              color: Color(0xFF1d1b20).withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 64,
                    color: iconColor,
                  ),
                SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (confirmText.isNotEmpty)
                      SizedBox(
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (onConfirm != null) onConfirm();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Altere o valor para o grau de arredondamento desejado
                            ),
                          ),
                          child: Text(
                            confirmText,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
