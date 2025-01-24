class OrderModel {
  int? idPedido;
  int? idClifor;
  String? cdForma;
  String? dtEmissao;
  String? stPedido;
  String? valorTotal;

  OrderModel(
      {this.idPedido,
      this.idClifor,
      this.cdForma,
      this.dtEmissao,
      this.stPedido,
      this.valorTotal});

  OrderModel.fromJson(Map<String, dynamic> json) {
    idPedido = json['id_pedido'];
    idClifor = json['id_clifor'];
    cdForma = json['cd_forma'];
    dtEmissao = json['dt_emissao'];
    stPedido = json['st_pedido'];
    valorTotal = json['valor_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_pedido'] = idPedido;
    data['id_clifor'] = idClifor;
    data['cd_forma'] = cdForma;
    data['dt_emissao'] = dtEmissao;
    data['st_pedido'] = stPedido;
    data['valor_total'] = valorTotal;
    return data;
  }
}
