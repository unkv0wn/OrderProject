import 'package:flutter/material.dart';
import 'package:orderview/src/view/clients/clients_screen.dart';
import 'package:orderview/src/view/error/erros_screen.dart';
import 'package:orderview/src/view/mark/marks_screen.dart';
import 'package:orderview/src/view/paymentform/paymentform_screen.dart';
import 'package:orderview/src/view/products/products_screen.dart';
import 'package:orderview/src/view/publicplace/publicplace_screen.dart';
import 'package:orderview/src/view/unit/unitmeasurement_screen.dart';

Widget menuHandler(int index) {
  switch (index) {
    case 0:
      return ErrorScreen();
    case 1:
      return ClientsScreen();
    case 2:
      return PublicplaceScreen();
    case 3:
      return MeasurementScreen();
    case 4:
      return PaymentformScreen();
    case 5:
      return MarksScreen();
    case 6:
      return ProductsScreen();
    case 7:
      return const Text("Cadastro de Pedidos");
    default:
      return const ErrorScreen();
  }
}
