class MarkModel {
  String? cdMarca;
  String? dsMarca;
  String? stAtivo;

  MarkModel({this.cdMarca, this.dsMarca, this.stAtivo});

  MarkModel.fromJson(Map<String, dynamic> json) {
    cdMarca = json['cd_marca'];
    dsMarca = json['ds_marca'];
    stAtivo = json['st_ativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cd_marca'] = cdMarca;
    data['ds_marca'] = dsMarca;
    data['st_ativo'] = stAtivo;
    return data;
  }
}
