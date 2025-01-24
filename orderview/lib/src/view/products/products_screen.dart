import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/models/mark_model.dart';
import 'package:orderview/src/models/product_model.dart';
import 'package:orderview/src/models/unitymeasurement_model.dart';
import 'package:orderview/src/utils/colors/colors.dart';
import 'package:orderview/src/utils/dialoginfos/dialoginfo.dart';
import 'package:orderview/src/view/mark/service/mark_service.dart';
import 'package:orderview/src/view/products/service/product_service.dart';
import 'package:orderview/src/view/unit/service/unit_service.dart';
import 'package:orderview/src/widgets/button/custombutton_widget.dart';
import 'package:orderview/src/widgets/dropdown/dropdown_wigdet.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';
import 'package:orderview/src/widgets/table/table_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final logger = Logger();

  final TextEditingController _cdProdutoController = TextEditingController();
  final TextEditingController _dsProdutoController = TextEditingController();
  final TextEditingController _unidadeProdutoController =
      TextEditingController();
  final TextEditingController _marcaProdutoController = TextEditingController();
  final TextEditingController _vlProdutoController = TextEditingController();

  final TextEditingController _unidadeDescController = TextEditingController();
  final TextEditingController _marcaDescController = TextEditingController();

  final ValueNotifier<String> dropValue = ValueNotifier<String>(" ");

  final ValueNotifier<String> dropValueMark = ValueNotifier<String>(" ");

  // Lista de dados para a tabela
  List<Map<String, dynamic>> _unitymeasurement = [];
  List<Map<String, dynamic>> _marks = [];

  final Map<String, String> marcas = {
    '1': 'MarcaX',
    '2': 'MarcaY',
    '3': 'MarcaZ',
  };

  final ValueNotifier<String> dropValueFilter = ValueNotifier<String>(" ");

  final List<String> filtros = [
    'R',
    'AVD',
    'BR',
    'EST',
    'CND',
  ];

  // Lista de dados para a tabela
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadUnits();
    _loadMarks(); // Carregar dados da API quando a tela for carregada
  }

  Future<void> _loadMarks() async {
    try {
      final service = MarkService();
      List<MarkModel> forms = await service.getAllMark();

      setState(() {
        _marks = forms.map((form) {
          return {
            'Código': form.cdMarca ?? 'N/A',
            'Descricao': form.dsMarca ?? 'N/A',
            'Ativo': form.stAtivo == 'S' ? 'Sim' : 'Não',
          };
        }).toList();
      });
    } catch (e) {
      logger.e('Erro ao carregar dados', error: e);
    }
  }

  // Função para carregar os dados da API
  Future<void> _loadUnits() async {
    try {
      final service = UnitService();
      List<UnitMeasurementModel> forms = await service.getAllUnitys();

      setState(() {
        _unitymeasurement = forms.map((form) {
          return {
            'Código': form.cdUnidade ?? 'N/A',
            'Descricao': form.dsUnidade ?? 'N/A',
            'Ativo': form.stAtivo == 'S' ? 'Sim' : 'Não',
          };
        }).toList();
      });
    } catch (e) {
      logger.e('Erro ao carregar dados', error: e);
    }
  }

  // Função para carregar os dados da API
  Future<void> _loadProducts() async {
    try {
      final service = ProductService();
      List<ProductModel> forms = await service.getAllProducts();

      final markload = MarkService();

      List<MarkModel> formsMarks = await markload.getAllMark();
      setState(() {
        _data = forms.map((form) {
          MarkModel marca = formsMarks.firstWhere(
            (marca) => marca.cdMarca == form.cdMarca,
            orElse: () => MarkModel(cdMarca: '', dsMarca: 'N/A', stAtivo: 'N'),
          );

          return {
            'Código': form.idProduto?.toString() ?? 'N/A',
            'Descricao': form.dsNome ?? 'N/A',
            'Unidade': form.cdUnidade ?? 'N/A',
            'Marca': marca.dsMarca,
            'Ativo': form.stStatus == 'S' ? 'Sim' : 'Não',
          };
        }).toList();
      });
    } catch (e) {
      logger.e('Erro ao carregar dados', error: e);
    }
  }

  Future<void> _createProduct() async {
    if (_dsProdutoController.text.isEmpty ||
        _unidadeProdutoController.text.isEmpty ||
        _marcaProdutoController.text.isEmpty ||
        _vlProdutoController.text.isEmpty) {
      return DialogsInfo.showAlertDialog(context);
    }

    try {
      final product = ProductModel(
          dsNome: _dsProdutoController.text,
          cdUnidade: _unidadeProdutoController.text,
          cdMarca: _marcaProdutoController.text,
          vlPreco: _vlProdutoController.text);

      await ProductService().createProduct(product);

      _loadProducts();

      await Future.delayed(Duration(microseconds: 1));
      if (!mounted) return;

      DialogsInfo.showSuccessDialog(context);
    } catch (e) {
      logger.e('Error ao cadastrar Produto', error: e);
      DialogsInfo.showErrorDialog(context);
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
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Cadastro de Produtos.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FormInput(
                          labelText: "Codigo",
                          customController: _cdProdutoController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: ""),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 8,
                      child: FormInput(
                          labelText: "Descrição",
                          customController: _dsProdutoController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "Produto exemplo"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        valueNotifier: dropValue,
                        items: _unitymeasurement
                            .map((unit) => unit['Código'] as String)
                            .toList(),
                        hint: "Unidade",
                        labelText: "Unidade Medida",
                        isRequired: true, // Exibirá o '*' ao lado do rótulo
                        onChanged: (newValue) {
                          Map<String, dynamic>? selectedUnit =
                              _unitymeasurement.firstWhere(
                            (unit) => unit['Código'] == newValue,
                          );

                          _unidadeDescController.text =
                              selectedUnit['Descricao'] ?? '';
                          _unidadeProdutoController.text =
                              selectedUnit['Código'] ?? '';
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 8,
                      child: FormInput(
                          labelText: "Descrição",
                          customController: _unidadeDescController,
                          isRequired: false,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "Unidade"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        valueNotifier: dropValueMark,
                        items: _marks
                            .map((unit) => unit['Descricao'] as String)
                            .toList(),
                        hint: "Marca",
                        labelText: "Marca",
                        isRequired: true,
                        onChanged: (newValue) {
                          final Map<String, dynamic> selectedUnit =
                              _marks.firstWhere(
                            (unit) => unit['Descricao'] == newValue,
                          );
                          // Atualiza os valores no controlador
                          _marcaDescController.text =
                              selectedUnit['Descricao'] ?? '';
                          _marcaProdutoController.text =
                              selectedUnit['Código'] ?? '';
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 8,
                      child: FormInput(
                          labelText: "Descrição",
                          customController: _marcaDescController,
                          isRequired: true,
                          validadorCustom: (value) {
                            return null;
                          },
                          hintText: "MarcaX"),
                    ),
                  ],
                ),
                FormInput(
                    labelText: "Valor Unitario",
                    customController: _vlProdutoController,
                    isRequired: true,
                    validadorCustom: (value) {
                      return null;
                    },
                    hintText: "99.00"),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 220,
                    height: 50,
                    child: CustomButton(
                      text: "Cadastrar",
                      onPressed: () {
                        _createProduct();
                      },
                      backgroundColor: AppColors.primaryBlue,
                      icon: LucideIcons.save,
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      width: 120,
                      height: 60,
                      child: CustomDropdown(
                          valueNotifier: dropValueFilter,
                          items: filtros,
                          hint: "Filtros")),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: CustomPaginatedDataTable<Map<String, dynamic>>(
                    data:
                        _data, // Aqui você pode passar diferentes listas de dados
                    columns: const [
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'Código',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.M,
                        label: Text(
                          'Descricao',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'Unidade',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'Marca',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'Ativo',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    cellBuilders: [
                      (row) => DataCell(Text(row['Código'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['Descricao'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['Unidade'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['Marca'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['Ativo'],
                          style: TextStyle(color: Colors.white))),
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
