import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/models/mark_model.dart';
import 'package:orderview/src/utils/colors/colors.dart';
import 'package:orderview/src/utils/dialoginfos/dialoginfo.dart';
import 'package:orderview/src/view/mark/service/mark_service.dart';
import 'package:orderview/src/widgets/button/custombutton_widget.dart';
import 'package:orderview/src/widgets/dropdown/dropdown_wigdet.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';
import 'package:orderview/src/widgets/table/table_widget.dart';

class MarksScreen extends StatefulWidget {
  const MarksScreen({super.key});

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  final logger = Logger();

  final TextEditingController _dsmarcaController = TextEditingController();

  final ValueNotifier<String> dropValueMark = ValueNotifier<String>(" ");

  final List<String> unidadesDeMedida = [
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
    _loadMarks(); // Carregar dados da API quando a tela for carregada
  }

  // Função para carregar os dados da API
  Future<void> _loadMarks() async {
    try {
      final service = MarkService();
      List<MarkModel> forms = await service.getAllMark();

      setState(() {
        _data = forms.map((form) {
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

  Future<void> _createMark() async {
    if (_dsmarcaController.text.isEmpty) {
      return DialogsInfo.showAlertDialog(context);
    }

    try {
      final marks = MarkModel(
        dsMarca: _dsmarcaController.text,
        stAtivo: 'S',
      );

      await MarkService().createMark(marks);

      _loadMarks();

      await Future.delayed(Duration(microseconds: 1));
      if (!mounted) return;

      DialogsInfo.showSuccessDialog(context);
      _dsmarcaController.text = '';
    } catch (e) {
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
                    "Cadastro de Marcas.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                FormInput(
                    labelText: "Descrição Marca",
                    customController: _dsmarcaController,
                    isRequired: true,
                    validadorCustom: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo Descrição Marca não pode estar vazio.";
                      }
                      return null;
                    },
                    hintText: "MarcaX"),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 220,
                    height: 50,
                    child: CustomButton(
                      text: "Cadastrar",
                      onPressed: () {
                        _createMark();
                      },
                      backgroundColor: AppColors.primaryBlue,
                      icon: LucideIcons.save,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      width: 120,
                      height: 60,
                      child: CustomDropdown(
                          valueNotifier: dropValueMark,
                          items: unidadesDeMedida,
                          hint: "Filtros")),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
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
