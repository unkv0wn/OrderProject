import 'package:dio/dio.dart';
import 'package:orderview/src/models/order_model.dart';
import 'package:orderview/src/service/apiservice/api_service.dart';

class OrderService {
  final Dio dio = DioService.getDioInstance();

  Future<List<OrderModel>> getAllOrders() async {
    try {
      Response response = await dio.get('/order');

      return (response.data as List)
          .map((data) => OrderModel.fromJson(data))
          .toList();
    } catch (e) {
      throw Exception('Erro ao carregar pedidos: $e');
    }
  }

  Future<int?> createorder(OrderModel order) async {
    try {
      Response response = await dio.post('/order', data: order.toJson());

      if (response.statusCode == 201) {
        // Cria o objeto OrderModel a partir da resposta
        final newOrder = OrderModel.fromJson(response.data);

        print("id do pedido service: ${newOrder.idPedido}");
        return newOrder.idPedido;
      } else {
        throw Exception('Erro ao criar pedido');
      }
    } catch (e) {
      throw Exception('Erro ao criar pedido: $e');
    }
  }

  Future<OrderModel> getOrderById(int id) async {
    try {
      // Passando o ID como parâmetro de consulta
      Response response = await dio.get('/order/$id');

      return OrderModel.fromJson(response.data.first);
    } catch (e) {
      throw Exception('Erro ao carregar dados do pedido: $e');
    }
  }
}
