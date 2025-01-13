import 'package:flutter/material.dart';
import 'package:orderview/src/utils/colors/colors.dart';
import 'package:orderview/src/widgets/alertdialog/dialog_widget.dart';

class DialogsInfo {
  static void showSuccessDialog(BuildContext context) {
    CustomDialog.show(
      context,
      title: "Sucesso",
      message: "A operação foi concluída com êxito.",
      icon: Icons.check_circle,
      iconColor: AppColors.primaryBlue,
      confirmText: "OK",
      onConfirm: () {
        print("Ação confirmada!");
      },
    );
  }

  static void showErrorDialog(BuildContext context) {
    CustomDialog.show(
      context,
      title: "Erro",
      message: "Ocorreu um problema inesperado.",
      icon: Icons.error,
      iconColor: Colors.red,
      confirmText: "Tentar Novamente",
      onConfirm: () {
        print("Tentando novamente...");
      },
    );
  }

  static void showWarningDialog(BuildContext context) {
    CustomDialog.show(
      context,
      title: "Aviso",
      message: "Você tem certeza de que deseja continuar?",
      icon: Icons.warning,
      iconColor: Colors.orange,
      confirmText: "Continuar",
      onConfirm: () {
        print("Operação continuada!");
      },
    );
  }
}
