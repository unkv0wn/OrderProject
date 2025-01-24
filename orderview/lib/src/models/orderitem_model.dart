class OrderitemModel {
  int? idItempedido;
  int? idPedido;
  int? idProduto;
  double? quantidade;
  double? vlUnitario;
  double? desconto;
  double? vlTotal;

  OrderitemModel(
      {this.idItempedido,
      this.idPedido,
      this.idProduto,
      this.quantidade,
      this.vlUnitario,
      this.desconto,
      this.vlTotal});

  OrderitemModel.fromJson(Map<String, dynamic> json) {
    idItempedido = json['id_itempedido'];
    idPedido = json['id_pedido'];
    idProduto = json['id_produto'];
    quantidade = json['quantidade'];
    vlUnitario = json['vl_unitario'];
    desconto = json['desconto'];
    vlTotal = json['vl_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_itempedido'] = this.idItempedido;
    data['id_pedido'] = this.idPedido;
    data['id_produto'] = this.idProduto;
    data['quantidade'] = this.quantidade;
    data['vl_unitario'] = this.vlUnitario;
    data['desconto'] = this.desconto;
    data['vl_total'] = this.vlTotal;
    return data;
  }
}
