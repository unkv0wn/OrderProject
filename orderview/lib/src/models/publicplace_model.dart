class PublicPlaceModel {
  String? cdLogradouro;
  String? dsLogradouro;
  String? stAtivo;

  PublicPlaceModel({this.cdLogradouro, this.dsLogradouro, this.stAtivo});

  PublicPlaceModel.fromJson(Map<String, dynamic> json) {
    cdLogradouro = json['cd_logradouro'];
    dsLogradouro = json['ds_logradouro'];
    stAtivo = json['st_ativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cd_logradouro'] = cdLogradouro;
    data['ds_logradouro'] = dsLogradouro;
    data['st_ativo'] = stAtivo;
    return data;
  }
}
