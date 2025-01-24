import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:orderview/src/models/clifor_model.dart';
import 'package:orderview/src/models/order_model.dart';
import 'package:orderview/src/models/paymentform_model.dart';
import 'package:orderview/src/view/clients/service/clients_service.dart';
import 'package:orderview/src/view/order/new_orders/ItensDialog.dart';
import 'package:orderview/src/view/order/services/order_service.dart';
import 'package:orderview/src/view/paymentform/services/paymentform_services.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';

class Clientdialog extends StatefulWidget {
  const Clientdialog({super.key});

  @override
  State<Clientdialog> createState() => _ClientdialogState();
}

// Text Controllers
final TextEditingController idClieneteController = TextEditingController();
final TextEditingController dsnomeController = TextEditingController();
final TextEditingController idFormaController = TextEditingController();
final TextEditingController dsFormaController = TextEditingController();

//logger define
final Logger logger = Logger();

// GlobalIdPedido = Recebe o id do pedido criado

int? globalIdPedido;

//Procura o nome do cliente pelo seu ID
void getClient() async {
  if (idClieneteController.text.isNotEmpty) {
    CliforModel client =
        await ClientsService().getCliforById(idClieneteController.text);

    if (client.dsNome != null) {
      dsnomeController.text = client.dsNome!;
    } else {
      dsnomeController.text = '';
    }
  }
}

//Procura o nome da forma de pagamento pelo seu ID
void getPaymentForm() async {
  if (idFormaController.text.isNotEmpty && idFormaController.text.length > 1) {
    PaymentFormModel paymentForm =
        await PaymentformServices().getPaymentToId(idFormaController.text);
    if (paymentForm.dsForma != null) {
      dsFormaController.text = paymentForm.dsForma!;
    } else {
      dsFormaController.text = '';
    }
  }
}

// chama a rota de criação de pedido
Future<void> createOrder() async {
  try {
    final int? idClifor = int.tryParse(idClieneteController.text);
    if (idClifor == null) {
      // Se o id não for válido, retorne sem fazer nada
      return;
    }

    final client = OrderModel(
      idClifor: idClifor,
      cdForma: idFormaController.text,
    );

    // Espera o retorno de createorder e captura o idPedido
    final int? idPedido = await OrderService().createorder(client);

    if (idPedido != null) {
      globalIdPedido = idPedido;
      print(globalIdPedido);
    } else {
      logger.e("Erro ao puxar dados");
    }
  } catch (e) {
    logger.e('Erro ao carregar dados', error: e);
  }
}

class _ClientdialogState extends State<Clientdialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  customController: idClieneteController,
                  validadorCustom: (value) {
                    return null;
                  },
                  onEditingComplete: getClient,
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
                  customController: dsnomeController,
                  validadorCustom: (value) {
                    return null;
                  },
                  hintText: "Ana Luiza Oliveira Moraes",
                  readOnly: true,
                  //focusNode: focusNode,
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
                  customController: idFormaController,
                  validadorCustom: (value) {
                    return null;
                  },
                  onEditingComplete: getPaymentForm,
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
                  customController: dsFormaController,
                  validadorCustom: (value) {
                    return null;
                  },
                  readOnly: true,
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
              width: 130,
              child: ElevatedButton(
                onPressed: () async {
                  // Aguarda a criação do pedido
                  await createOrder();
                  // Verifica se o globalIdPedido foi corretamente atribuído
                  if (globalIdPedido != null) {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            child: Itensdialog(
                              idPedido: globalIdPedido!,
                              isEdit: false,
                            ),
                          );
                        });
                  } else {
                    print("Erro ao criar pedido. ID do pedido não disponível.");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Avançar",
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
    );
  }
}
