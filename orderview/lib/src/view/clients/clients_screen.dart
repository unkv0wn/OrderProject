import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/models/clifor_model.dart';
import 'package:orderview/src/models/publicplace_model.dart';
import 'package:orderview/src/utils/colors/colors.dart';
import 'package:orderview/src/utils/dialoginfos/dialoginfo.dart';
import 'package:orderview/src/view/clients/service/clients_service.dart';
import 'package:orderview/src/view/publicplace/service/plublicplace_service.dart';
import 'package:orderview/src/widgets/button/custombutton_widget.dart';
import 'package:orderview/src/widgets/date/date_widget.dart';
import 'package:orderview/src/widgets/dropdown/dropdown_wigdet.dart';
import 'package:orderview/src/widgets/form/forminput_widgets.dart';
import 'package:intl/intl.dart';
import 'package:orderview/src/widgets/table/table_widget.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final logger = Logger();

  final TextEditingController _dsnomeController = TextEditingController();
  final TextEditingController _nrcpfController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _cdlogradouroController = TextEditingController();
  final TextEditingController _dsruaController = TextEditingController();
  final TextEditingController _nrCasaController = TextEditingController();
  final TextEditingController _dscomplementoController =
      TextEditingController();
  final TextEditingController _dsbairroController = TextEditingController();
  final TextEditingController _dscidadeController = TextEditingController();
  final TextEditingController _cdcepController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  final ValueNotifier<String> dropValue = ValueNotifier<String>(" ");

  void _onDateSelected(DateTime pickedDate) {
    setState(() {
      selectedDate = pickedDate;
      _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    });
  }

  // Lista de dados para a tabela
  List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> _logradouro = [];

  @override
  void initState() {
    super.initState();
    _loadClients();
    _loadPublicPlace(); // Carregar dados da API quando a tela for carregada
  }

  // Função para carregar os dados da API
  Future<void> _loadPublicPlace() async {
    try {
      final service = PlublicplaceService();
      List<PublicPlaceModel> forms = await service.getAllPlace();

      // Mapeando os dados para o formato da tabela
      setState(() {
        _logradouro = forms.map((form) {
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

  Future<void> _loadClients() async {
    try {
      final service = ClientsService();
      List<CliforModel> forms = await service.getAllClifor();

      // Mapeando os dados para o formato da tabela
      setState(() {
        _data = forms.map((form) {
          return {
            'Código': form.idClifor?.toString() ?? 'N/A',
            'Nome': form.dsNome ?? 'N/A',
            'CPF': form.nrCpf ?? 'N/A',
            'Cidade': form.dsCidade ?? 'N/A',
            'DataNascimento': form.dtNascimento ?? 'N/A',
            'CEP': form.cdCep ?? 'N/A',
            'Ativo': form.stAtivo == 'S' ? 'Sim' : 'Não',
          };
        }).toList();
      });
    } catch (e) {
      logger.e('Erro ao carregar dados', error: e);
    }
  }

  Future<void> _createClient() async {
    try {
      final client = CliforModel(
        dsNome: _dsnomeController.text,
        nrCpf: _nrcpfController.text,
        dtNascimento: _dateController.text,
        cdLogradouro: _cdlogradouroController.text,
        dsRua: _dsruaController.text,
        nrRua: _nrCasaController.text,
        dsComplemento: _dscomplementoController.text,
        dsBairro: _dsbairroController.text,
        dsCidade: _dscidadeController.text,
        cdCep: _cdcepController.text,
      );

      await ClientsService().createClifor(client);

      _loadClients();

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
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Cadastro de Cliente.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FormInput(
                        labelText: "Nome",
                        customController: _dsnomeController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "Joao Silva",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: FormInput(
                        labelText: "CPF",
                        customController: _nrcpfController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "123.456.789-00",
                      ),
                    ),
                    SizedBox(width: 10),
                    DateWidget(
                      dateController: _dateController,
                      selectedDate: selectedDate,
                      isRequired: true,
                      onDateSelected: _onDateSelected,
                      labeltext: 'Data de Nascimento',
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        valueNotifier: dropValue,
                        items: _logradouro
                            .map((logradouro) => logradouro['Código'] as String)
                            .toList(),
                        hint: "R",
                        labelText: "Logradouro",
                        isRequired: true,
                        onChanged: (newValue) {
                          Map<String, dynamic>? selectedUnit =
                              _logradouro.firstWhere(
                            (unit) => unit['Código'] == newValue,
                          );
                          _cdlogradouroController.text =
                              selectedUnit['Código'] ?? '';
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 6,
                      child: FormInput(
                        labelText: "Rua",
                        customController: _dsruaController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "Rua das Flores",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: FormInput(
                        labelText: "Numero",
                        customController: _nrCasaController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "125",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: FormInput(
                        labelText: "Complemento",
                        customController: _dscomplementoController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "Apt 45",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: FormInput(
                        labelText: "Bairro",
                        customController: _dsbairroController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "Centro",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: FormInput(
                        labelText: "Cidade",
                        customController: _dscidadeController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "Sao Paulo",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: FormInput(
                        labelText: "CEP",
                        customController: _cdcepController,
                        isRequired: true,
                        validadorCustom: (value) => null,
                        hintText: "01000-000",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 220,
                    height: 50,
                    child: CustomButton(
                      text: "Cadastrar",
                      onPressed: () {
                        _createClient();
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
                //table
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
                          'Nome',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'CPF',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.M,
                        label: Text(
                          'Cidade',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: Text(
                          'CEP',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.M,
                        label: Text(
                          'Data Nascimento',
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
                      (row) => DataCell(Text(row['Nome'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['CPF'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['Cidade'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['CEP'],
                          style: TextStyle(color: Colors.white))),
                      (row) => DataCell(Text(row['DataNascimento'],
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
