import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';
import 'package:orderview/src/widgets/iconbutton/iconbutton_wiget.dart';
import 'package:orderview/src/widgets/statusIndicator/statusindicator_widget.dart';
import 'package:orderview/src/widgets/table/table_widget.dart';

class Itensdialog {
  static void show(
    BuildContext context, {
    Color iconColor = Colors.blue,
    String cancelText = "Cancelar",
    String confirmText = "Confirmar",
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool isDismissible = true,
  }) {
    TextEditingController customController = TextEditingController();

    List<Map<String, dynamic>> data = [
      {
        'Código': '001',
        'Descrição': 'Produto A',
        'Quantidade': 10.toString(),
        'ValorUnitario': '25.00',
        'valorTotal': '250.00',
      },
      {
        'Código': '002',
        'Descrição': 'Produto B',
        'Quantidade': 5.toString(),
        'ValorUnitario': '40.00',
        'valorTotal': '200.00',
      },
      {
        'Código': '003',
        'Descrição': 'Produto C',
        'Quantidade': 8.toString(),
        'ValorUnitario': '15.00',
        'valorTotal': '120.00',
      },
      {
        'Código': '004',
        'Descrição': 'Produto D',
        'Quantidade': 12.toString(),
        'ValorUnitario': '30.00',
        'valorTotal': '360.00',
      },
      // Adicione mais itens conforme necessário
    ];

    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            color:
                Colors.transparent, // Fundo transparente para manter o estilo
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
                        flex: 4,
                        child: FormInput(
                            labelText: "Cliente",
                            customController: customController,
                            validadorCustom: (value) {
                              return null;
                            },
                            hintText: "Ana Luiza"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: FormInput(
                            labelText: "Forma de Pagamento",
                            customController: customController,
                            validadorCustom: (value) {
                              return null;
                            },
                            hintText: "DI"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Adicionar Produtos",
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormInput(
                            labelText: "ID",
                            customController: customController,
                            validadorCustom: (value) {
                              return null;
                            },
                            hintText: "123"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 9,
                        child: FormInput(
                            labelText: "Descrição",
                            customController: customController,
                            validadorCustom: (value) {
                              return null;
                            },
                            hintText: "Produto Exemplo"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormInput(
                            labelText: "Quantidade",
                            customController: customController,
                            validadorCustom: (value) {
                              return null;
                            },
                            hintText: "10"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: FormInput(
                            labelText: "Valor Unitario",
                            customController: customController,
                            validadorCustom: (value) {
                              return null;
                            },
                            hintText: "30.00"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: FormInput(
                            labelText: "Valor total",
                            customController: customController,
                            validadorCustom: (value) {
                              return null;
                            },
                            hintText: "300.00"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 50,
                      width: 140,
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
                          "Inserir",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
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
                          label: Text(
                            'ID Produto',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.L,
                          label: Text(
                            'Descrição',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.S,
                          label: Text(
                            'Quantidade',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.S,
                          label: Text(
                            'Valor Unitario',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.S,
                          label: Text(
                            'Valor Total',
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
                        (row) => DataCell(Text(row['Descrição'],
                            style: TextStyle(color: Colors.white))),
                        (row) => DataCell(Text(row['Quantidade'],
                            style: TextStyle(color: Colors.white))),
                        (row) => DataCell(Text(row['ValorUnitario'] ?? '0',
                            style: TextStyle(color: Colors.white))),
                        (row) => DataCell(Text(row['valorTotal'] ?? '0',
                            style: TextStyle(color: Colors.white))),
                        (row) => DataCell(Row(
                              children: [
                                CustomIconButton(
                                  icon: LucideIcons.pencil,
                                  onPressed: () {},
                                  color: Colors.amber,
                                  tooltip: "Editar",
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
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
                          "Salvar",
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
