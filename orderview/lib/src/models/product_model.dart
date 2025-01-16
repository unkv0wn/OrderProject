class ProductModel {
  int? idProduto;
  String? dsNome;
  String? cdUnidade;
  String? cdMarca;
  String? vlPreco;
  String? nrCodbarras;
  String? stStatus;

  ProductModel(
      {this.idProduto,
      this.dsNome,
      this.cdUnidade,
      this.cdMarca,
      this.vlPreco,
      this.nrCodbarras,
      this.stStatus});

  ProductModel.fromJson(Map<String, dynamic> json) {
    idProduto = json['id_produto'];
    dsNome = json['ds_nome'];
    cdUnidade = json['cd_unidade'];
    cdMarca = json['cd_marca'];
    vlPreco = json['vl_preco'];
    nrCodbarras = json['nr_codbarras'];
    stStatus = json['st_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_produto'] = idProduto;
    data['ds_nome'] = dsNome;
    data['cd_unidade'] = cdUnidade;
    data['cd_marca'] = cdMarca;
    data['vl_preco'] = vlPreco;
    data['nr_codbarras'] = nrCodbarras;
    data['st_status'] = stStatus;
    return data;
  }
}
