import 'package:dio/dio.dart';
import 'package:orderview/src/models/product_model.dart';
import 'package:orderview/src/models/publicplace_model.dart';
import 'package:orderview/src/service/apiservice/api_service.dart';

class ProductService {
  final Dio dio = DioService.getDioInstance();

  Future<List<ProductModel>> getAllProducts() async {
    try {
      Response response = await dio.get('/product');

      return (response.data as List)
          .map((data) => ProductModel.fromJson(data))
          .toList();
    } catch (e) {
      throw Exception('Erro ao carregar formas de pagamento: $e');
    }
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    try {
      Response response = await dio.post('/product', data: product.toJson());

      if (response.statusCode == 201) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception('Erro ao criar forma de pagamento');
      }
    } catch (e) {
      throw Exception('Erro ao criar produto: $e');
    }
  }
}
