class UnitMeasurementModel {
  String? cdUnidade;
  String? dsUnidade;
  String? stAtivo;

  UnitMeasurementModel({this.cdUnidade, this.dsUnidade, this.stAtivo});

  UnitMeasurementModel.fromJson(Map<String, dynamic> json) {
    cdUnidade = json['cd_unidade'];
    dsUnidade = json['ds_unidade'];
    stAtivo = json['st_ativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cd_unidade'] = cdUnidade;
    data['ds_unidade'] = dsUnidade;
    data['st_ativo'] = stAtivo;
    return data;
  }
}
