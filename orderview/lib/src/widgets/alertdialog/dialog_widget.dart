import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              color: Color(0xFF1d1b20),
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
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centralizando o conteúdo verticalmente
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Centralizando o conteúdo horizontalmente
              children: [
                Spacer(),
                if (icon != null)
                  Icon(
                    icon,
                    size: 84,
                    color: iconColor,
                  ),
                SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign
                      .center, // Garantir que o título está centralizado
                ),
                SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign
                      .center, // Garantir que a mensagem está centralizada
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 17,
                      letterSpacing: 2.0),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centralizando o botão
                  children: [
                    if (confirmText.isNotEmpty)
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (onConfirm != null) onConfirm();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              confirmText,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
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
