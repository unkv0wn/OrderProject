import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/models/clifor_model.dart';
import 'package:orderview/src/models/order_model.dart';
import 'package:orderview/src/view/clients/service/clients_service.dart';
import 'package:orderview/src/view/order/new_orders/clientdialog.dart';
import 'package:orderview/src/view/order/new_orders/itensdialog.dart';
import 'package:orderview/src/view/order/services/order_service.dart';
import 'package:orderview/src/widgets/button/custombutton_widget.dart';
import 'package:orderview/src/widgets/iconbutton/iconbutton_wiget.dart';
import 'package:orderview/src/widgets/statusIndicator/statusindicator_widget.dart';
import 'package:orderview/src/widgets/table/table_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    _loadOrder();
  }

  List<Map<String, dynamic>> _data = [];

  final logger = Logger();

  Future<void> _loadOrder() async {
    try {
      final service = OrderService();
      List<OrderModel> forms = await service.getAllOrders();

      final markload = ClientsService();
      List<CliforModel> fromClients = await markload.getAllClifor();

      setState(() {
        _data = forms.map((form) {
          CliforModel marca = fromClients.firstWhere(
            (marca) => marca.idClifor == form.idClifor,
            orElse: () =>
                CliforModel(idClifor: 0, dsNome: 'Cliente Não Encontrado'),
          );

          return {
            'Código': form.idPedido.toString(),
            'Cliente': marca.dsNome,
            'Status': form.stPedido ?? 'N/A',
            'Pagamento': form.cdForma ?? 'N/A',
            'ValorTotal': form.valorTotal.toString()
          };
        }).toList();
      });
    } catch (e) {
      logger.e('Erro ao carregar dados', error: e);
    }
  }

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
                    "Cadastro de Pedido.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                //Valores total
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFF0EA5E9),
                        Color(0xFF2563EB)
                      ]), // Cor de fundo do card
                      borderRadius:
                          BorderRadius.circular(16), // Cantos arredondados
                    ),
                    child: Stack(
                      children: [
                        // Fundo decorativo
                        Positioned(
                          top: 10,
                          right: -20,
                          child: Icon(
                            LucideIcons.circleDollarSign,
                            size: 150,
                            color: Colors.blue.shade200.withValues(alpha: 0.2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Texto principal
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Valor Total de Pedidos',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '\$600,00',
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 160,
                    height: 50,
                    child: CustomButton(
                      text: "Novo",
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Clientdialog(),
                              );
                            });
                      },
                      backgroundColor: Colors.greenAccent.shade700,
                      icon: LucideIcons.filePlus2,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: CustomPaginatedDataTable<Map<String, dynamic>>(
                    data: _data,
                    columns: const [
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'Id Pedido',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.M,
                        label: Text(
                          'Cliente',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'Status',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'Form Pagamento',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'Valor total',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'Ações',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    cellBuilders: [
                      (row) => DataCell(Text(row['Código'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['Cliente'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(
                            StatusIndicator(status: row['Status']),
                          ),
                      (row) => DataCell(Text(row['Pagamento'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['ValorTotal'] ?? '0',
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Row(
                            children: [
                              CustomIconButton(
                                icon: LucideIcons.pencil,
                                onPressed: () {
                                  int idPedidoChange = int.parse(row['Código']);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Itensdialog(
                                            idPedido: idPedidoChange,
                                            isEdit: false,
                                          ),
                                        );
                                      });
                                },
                                color: Colors.amber,
                                tooltip: "Editar",
                              ),
                              CustomIconButton(
                                icon: LucideIcons.search,
                                onPressed: () {
                                  int idPedidoChange = int.parse(row['Código']);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Itensdialog(
                                            idPedido: idPedidoChange,
                                            isEdit: true,
                                          ),
                                        );
                                      });
                                },
                                color: Colors.blueAccent,
                                tooltip: "Vizualizar",
                              ),
                              CustomIconButton(
                                icon: LucideIcons.printer,
                                onPressed: () {},
                                color: Colors.blueGrey,
                                tooltip: "Imprimir",
                              ),
                              CustomIconButton(
                                icon: LucideIcons.trash2,
                                onPressed: () {},
                                color: Colors.redAccent,
                                tooltip: "Deletar",
                              ),
                            ],
                          )),
                    ],
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
