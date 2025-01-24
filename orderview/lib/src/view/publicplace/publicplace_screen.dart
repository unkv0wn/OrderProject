import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/models/publicplace_model.dart';
import 'package:orderview/src/utils/colors/colors.dart';
import 'package:orderview/src/utils/dialoginfos/dialoginfo.dart';
import 'package:orderview/src/view/publicplace/service/plublicplace_service.dart';
import 'package:orderview/src/widgets/button/custombutton_widget.dart';
//import 'package:orderview/src/widgets/dropdown/dropdown_wigdet.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';
import 'package:orderview/src/widgets/table/table_widget.dart';

class PublicplaceScreen extends StatefulWidget {
  const PublicplaceScreen({super.key});

  @override
  State<PublicplaceScreen> createState() => _PublicplaceScreenState();
}

class _PublicplaceScreenState extends State<PublicplaceScreen> {
  final logger = Logger();

  final TextEditingController _cdLogradouroController = TextEditingController();
  final TextEditingController _dsLogradouroController = TextEditingController();

  // Lista de dados para a tabela
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _loadPublicPlace(); // Carregar dados da API quando a tela for carregada
  }

  // Função para carregar os dados da API
  Future<void> _loadPublicPlace() async {
    try {
      final service = PlublicplaceService();
      List<PublicPlaceModel> forms = await service.getAllPlace();

      // Mapeando os dados para o formato da tabela
      setState(() {
        _data = forms.map((form) {
          return {
            'Código': form.cdLogradouro ?? 'N/A',
            'Descricao': form.dsLogradouro ?? 'N/A',
            'Ativo': form.stAtivo == 'S' ? 'Sim' : 'Não',
          };
        }).toList(); // Converte a lista de objetos para o formato de mapa
      });
    } catch (e) {
      logger.e('Erro ao carregar dados', error: e);
    }
  }

  Future<void> _createPublicPlace() async {
    if (_cdLogradouroController.text.isEmpty ||
        _dsLogradouroController.text.isEmpty) {
      DialogsInfo.showWarningDialog(context);
    }

    try {
      final publicPlace = PublicPlaceModel(
          cdLogradouro: _cdLogradouroController.text,
          dsLogradouro: _dsLogradouroController.text,
          stAtivo: 'S');

      await PlublicplaceService().createPublicPlace(publicPlace);

      _loadPublicPlace();

      await Future.delayed(Duration(microseconds: 1));
      if (!mounted) return;

      DialogsInfo.showSuccessDialog(context);
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
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Cadastro de Logradouro.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                FormInput(
                    labelText: "Codigo Logradouro",
                    customController: _cdLogradouroController,
                    isRequired: true,
                    validadorCustom: (value) {
                      return null;
                    },
                    hintText: "AV"),
                SizedBox(
                  height: 8,
                ),
                FormInput(
                    labelText: "Descrição Logradouro",
                    customController: _dsLogradouroController,
                    isRequired: true,
                    validadorCustom: (value) {
                      return null;
                    },
                    hintText: "Avenida"),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 220,
                    height: 50,
                    child: CustomButton(
                      text: "Cadastrar",
                      onPressed: () {
                        _createPublicPlace();
                      },
                      backgroundColor: AppColors.primaryBlue,
                      icon: LucideIcons.save,
                    ),
                  ),
                ),
                Spacer(),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: SizedBox(
                //       width: 120,
                //       height: 60,
                //       child: CustomDropdown(
                //           valueNotifier: dropValueMark,
                //           items: unidadesDeMedida,
                //           hint: "Filtros")),
                // ),
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
