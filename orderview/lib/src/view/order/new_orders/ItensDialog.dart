import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/models/clifor_model.dart';
import 'package:orderview/src/models/order_model.dart';
import 'package:orderview/src/models/orderitem_model.dart';
import 'package:orderview/src/models/paymentform_model.dart';
import 'package:orderview/src/models/product_model.dart';
import 'package:orderview/src/utils/colors/colors.dart';
import 'package:orderview/src/view/clients/service/clients_service.dart';
import 'package:orderview/src/view/order/services/order_service.dart';
import 'package:orderview/src/view/order/services/orderitem_service.dart';
import 'package:orderview/src/view/paymentform/services/paymentform_services.dart';
import 'package:orderview/src/view/products/service/product_service.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';
import 'package:orderview/src/widgets/iconbutton/iconbutton_wiget.dart';
import 'package:orderview/src/widgets/table/table_widget.dart';

class Itensdialog extends StatefulWidget {
  final int idPedido;
  final bool isEdit;

  const Itensdialog({super.key, required this.idPedido, this.isEdit = true});

  @override
  State<Itensdialog> createState() => _ItensdialogState();
}

class _ItensdialogState extends State<Itensdialog> {
  // Controllers
  TextEditingController idController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController formaController = TextEditingController();
  TextEditingController idprodutoController = TextEditingController();
  TextEditingController dsprodutoController = TextEditingController();
  TextEditingController qtdprodutoController = TextEditingController();
  TextEditingController vlUnitprodutoController = TextEditingController();
  TextEditingController vlDescontoController = TextEditingController();
  TextEditingController vlTotalprodutoController = TextEditingController();

  // Logger
  final logger = Logger();

  // Data list
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    getClient(widget.idPedido);
    loadItens(widget.idPedido);
  }

  // ----- Funções de manipulação de dados -----

  // Carregar os itens de um pedido
  Future<void> loadItens(int idPedido) async {
    try {
      final service = OrderitemService();
      List<OrderitemModel> forms = await service.getItensByIdOrder(idPedido);

      final Product = ProductService();
      List<ProductModel> fromProducts = await Product.getAllProducts();

      // Chama setState para atualizar o estado e reconstruir a UI
      setState(() {
        data = forms.map((form) {
          double vlTotal = (form.quantidade ?? 0) * (form.vlUnitario ?? 0) -
              (form.desconto ?? 0);

          ProductModel marca = fromProducts.firstWhere(
            (marca) => marca.idProduto == form.idProduto,
          );

          return {
            'Pedido': form.idPedido.toString(),
            'CodItemPedido': form.idItempedido?.toString(),
            'CdProduto': form.idProduto.toString(),
            'DsProduto': marca.dsNome,
            'Quantidade': form.quantidade?.toStringAsFixed(1) ?? '0.00',
            'ValorUnitario': form.vlUnitario?.toStringAsFixed(2) ?? '0.00',
            'Desconto': form.desconto?.toStringAsFixed(2) ?? '0.00',
            'valorTotal': vlTotal.toStringAsFixed(2),
          };
        }).toList();
      });
    } catch (e) {
      logger.e('Erro ao carregar dados', error: e);
    }
  }

  // Obter dados do cliente pelo idPedido
  void getClient(int? idPedido) async {
    if (idPedido == null) {
      print("ID do pedido inválido");
      return;
    }

    // Chama o serviço que busca os dados do pedido com base no id
    OrderModel pedido = await OrderService().getOrderById(idPedido);

    // Verifica se o pedido foi encontrado
    if (pedido.idClifor != null) {
      // Chama o serviço para buscar o cliente pelo id
      CliforModel cliente =
          await ClientsService().getCliforById(pedido.idClifor.toString());
      PaymentFormModel pagamento =
          await PaymentformServices().getPaymentToId(pedido.cdForma.toString());

      // Preenche o nome do cliente
      idController.text = idPedido.toString();
      nomeController.text = cliente.dsNome ?? 'Nome não encontrado';
      formaController.text = pagamento.dsForma ?? "N/A";
    } else {
      print("Cliente não encontrado no pedido");
    }
  }

  // Obter dados do produto pelo idProduto
  void getProduct() async {
    if (idprodutoController.text.isNotEmpty) {
      ProductModel client =
          await ProductService().getProductById(idprodutoController.text);

      if (client.dsNome != null) {
        dsprodutoController.text = client.dsNome!;
        vlUnitprodutoController.text = client.vlPreco.toString();
      } else {
        dsprodutoController.text = '';
      }
    }
  }

  // ----- Funções de lógica de negócios -----

  // Função para calcular o valor total com base no valor unitário, quantidade e desconto
  void calcularValorTotal() {
    double valorUnitario = double.tryParse(vlUnitprodutoController.text) ?? 0.0;
    int quantidade = int.tryParse(qtdprodutoController.text) ?? 0;
    double desconto = double.tryParse(vlDescontoController.text) ?? 0.0;

    double valorTotal = (valorUnitario * quantidade) - desconto;
    vlTotalprodutoController.text = valorTotal.toStringAsFixed(2);
  }

  // ----- Funções de interação com UI (funções que interagem diretamente com o backend) -----

  Future<void> createOrdeItem() async {
    try {
      final int idProduto = int.tryParse(idprodutoController.text) ?? 0;
      final double quantidade =
          double.tryParse(qtdprodutoController.text) ?? 0.0;
      final double vlUnitario =
          double.tryParse(vlUnitprodutoController.text) ?? 0.0;

      // Garantir que o desconto seja 0.0 caso não seja preenchido
      final double desconto = vlDescontoController.text.isNotEmpty
          ? double.tryParse(vlDescontoController.text) ?? 0.0
          : 0.0;

      final product = OrderitemModel(
        idPedido: widget.idPedido,
        idProduto: idProduto,
        quantidade: quantidade,
        vlUnitario: vlUnitario,
        desconto: desconto,
      );

      // Chama o serviço para criar o item do pedido
      await OrderitemService().CreateItemOrder(product);

      // Recarrega os itens após criar o produto
      loadItens(widget.idPedido);
    } catch (e) {
      logger.e('Erro ao cadastrar Produto', error: e);
      // DialogsInfo.showErrorDialog(context);
    }
  }

  Future<void> _deleteItem(int itemPedidoId) async {
    await OrderitemService().deleteItem(itemPedidoId);
    loadItens(widget.idPedido);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(25),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.45,
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
            children: [
              Row(
                children: [
                  Expanded(
                    child: FormInput(
                      labelText: "Pedido",
                      customController: idController,
                      validadorCustom: (value) => null,
                      readOnly: true,
                      hintText: "1",
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 7,
                    child: FormInput(
                      labelText: "Cliente",
                      customController: nomeController,
                      validadorCustom: (value) => null,
                      readOnly: true,
                      hintText: "Ana Luiza",
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: FormInput(
                      labelText: "Forma de Pagamento",
                      customController: formaController,
                      validadorCustom: (value) => null,
                      readOnly: true,
                      hintText: "DI",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Adicionar Produtos", style: TextStyle(color: Colors.white)),
              Row(
                children: [
                  Expanded(
                    child: FormInput(
                      labelText: "ID",
                      customController: idprodutoController,
                      validadorCustom: (value) => null,
                      onEditingComplete: getProduct,
                      hintText: "123",
                      readOnly: widget.isEdit,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 9,
                    child: FormInput(
                      labelText: "Descrição",
                      customController: dsprodutoController,
                      validadorCustom: (value) => null,
                      hintText: "Produto Exemplo",
                      readOnly: widget.isEdit,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FormInput(
                      labelText: "Quantidade",
                      customController: qtdprodutoController,
                      validadorCustom: (value) => null,
                      hintText: "10",
                      readOnly: widget.isEdit,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: FormInput(
                      labelText: "Valor Unitario",
                      customController: vlUnitprodutoController,
                      validadorCustom: (value) => null,
                      onEditingComplete: calcularValorTotal,
                      hintText: "30.00",
                      readOnly: widget.isEdit,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: FormInput(
                      labelText: "Desconto",
                      customController: vlDescontoController,
                      validadorCustom: (value) => null,
                      hintText: "30",
                      onEditingComplete: calcularValorTotal,
                      readOnly: widget.isEdit,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: FormInput(
                      labelText: "Valor total",
                      customController: vlTotalprodutoController,
                      validadorCustom: (value) => null,
                      hintText: "300.00",
                      readOnly: widget.isEdit,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: 50,
                  width: 140,
                  child: ElevatedButton(
                    onPressed: createOrdeItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Inserir",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                child: CustomPaginatedDataTable<Map<String, dynamic>>(
                  data: data,
                  columns: const [
                    DataColumn2(
                      size: ColumnSize.S,
                      label:
                          Text('Pedido', style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn2(
                      size: ColumnSize.S,
                      label: Text('ItemPedido',
                          style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn2(
                      size: ColumnSize.S,
                      label: Text('Produto',
                          style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Text('Descrição',
                          style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn2(
                      size: ColumnSize.S,
                      label: Text('Quantidade',
                          style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn2(
                      size: ColumnSize.S,
                      label: Text('Valor Unitario',
                          style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn2(
                      size: ColumnSize.S,
                      label: Text('Desconto',
                          style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn2(
                      size: ColumnSize.S,
                      label: Text('Valor Total',
                          style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn2(
                      size: ColumnSize.S,
                      label:
                          Text('Ações', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  cellBuilders: [
                    (row) => DataCell(Text(row['Pedido'],
                        style: TextStyle(color: Colors.white))),
                    (row) => DataCell(Text(row['CodItemPedido'],
                        style: TextStyle(color: Colors.white))),
                    (row) => DataCell(Text(row['CdProduto'],
                        style: TextStyle(color: Colors.white))),
                    (row) => DataCell(Text(row['DsProduto'],
                        style: TextStyle(color: Colors.white))),
                    (row) => DataCell(Text(row['Quantidade'],
                        style: TextStyle(color: Colors.white))),
                    (row) => DataCell(Text(row['ValorUnitario'] ?? '0',
                        style: TextStyle(color: Colors.white))),
                    (row) => DataCell(Text(row['Desconto'] ?? '0',
                        style: TextStyle(color: Colors.white))),
                    (row) => DataCell(Text(row['valorTotal'] ?? '0',
                        style: TextStyle(color: Colors.white))),
                    (row) => DataCell(Row(
                          children: [
                            ...widget.isEdit
                                ? []
                                : [
                                    CustomIconButton(
                                      icon: LucideIcons.trash2,
                                      onPressed: () {
                                        int itempedidoid =
                                            int.parse(row['CodItemPedido']);

                                        _deleteItem(itempedidoid);
                                        // calcularValorTotal();
                                      },
                                      color: Colors.redAccent,
                                      tooltip: "Deletar",
                                    )
                                  ]
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
