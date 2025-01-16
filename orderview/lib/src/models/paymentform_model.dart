class PaymentFormModel {
  String? cdForma;
  String? dsForma;
  String? stAtivo;

  PaymentFormModel({this.cdForma, this.dsForma, this.stAtivo});

  PaymentFormModel.fromJson(Map<String, dynamic> json) {
    cdForma = json['cd_forma'];
    dsForma = json['ds_forma'];
    stAtivo = json['st_ativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cd_forma'] = cdForma;
    data['ds_forma'] = dsForma;
    data['st_ativo'] = stAtivo;
    return data;
  }
}
