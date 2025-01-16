class CliforModel {
  int? idClifor;
  String? dsNome;
  String? nrCpf;
  String? dtNascimento;
  String? dtCadastro;
  String? cdLogradouro;
  String? dsRua;
  String? nrRua;
  String? dsComplemento;
  String? dsBairro;
  String? dsCidade;
  String? cdCep;
  String? stAtivo;

  CliforModel(
      {this.idClifor,
      this.dsNome,
      this.nrCpf,
      this.dtNascimento,
      this.dtCadastro,
      this.cdLogradouro,
      this.dsRua,
      this.nrRua,
      this.dsComplemento,
      this.dsBairro,
      this.dsCidade,
      this.cdCep,
      this.stAtivo});

  CliforModel.fromJson(Map<String, dynamic> json) {
    idClifor = json['id_clifor'];
    dsNome = json['ds_nome'];
    nrCpf = json['nr_cpf'];
    dtNascimento = json['dt_nascimento'];
    dtCadastro = json['dt_cadastro'];
    cdLogradouro = json['cd_logradouro'];
    dsRua = json['ds_rua'];
    nrRua = json['nr_rua'];
    dsComplemento = json['ds_complemento'];
    dsBairro = json['ds_bairro'];
    dsCidade = json['ds_cidade'];
    cdCep = json['cd_cep'];
    stAtivo = json['st_ativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_clifor'] = idClifor;
    data['ds_nome'] = dsNome;
    data['nr_cpf'] = nrCpf;
    data['dt_nascimento'] = dtNascimento;
    data['dt_cadastro'] = dtCadastro;
    data['cd_logradouro'] = cdLogradouro;
    data['ds_rua'] = dsRua;
    data['nr_rua'] = nrRua;
    data['ds_complemento'] = dsComplemento;
    data['ds_bairro'] = dsBairro;
    data['ds_cidade'] = dsCidade;
    data['cd_cep'] = cdCep;
    data['st_ativo'] = stAtivo;
    return data;
  }


}
