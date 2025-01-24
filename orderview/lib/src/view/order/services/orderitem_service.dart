import 'package:dio/dio.dart';
import 'package:orderview/src/models/orderitem_model.dart';
import 'package:orderview/src/service/apiservice/api_service.dart';

class OrderitemService {
  final Dio dio = DioService.getDioInstance();

  Future<OrderitemModel> CreateItemOrder(OrderitemModel product) async {
    try {
      Response response = await dio.post('/orderitem', data: product.toJson());

      if (response.statusCode == 201) {
        return OrderitemModel.fromJson(response.data);
      } else {
        throw Exception('Erro ao criar forma de pagamento');
      }
    } catch (e) {
      throw Exception('Erro ao criar produto: $e');
    }
  }

  Future<List<OrderitemModel>> getItensByIdOrder(int? id) async {
    try {
      Response response = await dio.get('/orderitem/listitem/$id');

      return (response.data as List)
          .map((data) => OrderitemModel.fromJson(data))
          .toList();
    } catch (e) {
      throw Exception('Erro ao carregar formas de pagamento: $e');
    }
  }

  Future<bool> deleteItem(int? id) async {
    try {
      Response response = await dio.delete('/orderitem/$id');
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Erro ao deletar item: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao deletar item: $e');
    }
  }
}
