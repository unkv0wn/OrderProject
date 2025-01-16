import 'package:dio/dio.dart';
import 'package:orderview/src/models/publicplace_model.dart';
import 'package:orderview/src/service/apiservice/api_service.dart';

class PlublicplaceService {
  final Dio dio = DioService.getDioInstance();

  Future<List<PublicPlaceModel>> getAllPlace() async {
    try {
      Response response = await dio.get('/publicplace');

      return (response.data as List)
          .map((data) => PublicPlaceModel.fromJson(data))
          .toList();
    } catch (e) {
      throw Exception('Erro ao carregar formas de pagamento: $e');
    }
  }

  Future<PublicPlaceModel> createPublicPlace(
      PublicPlaceModel publicPlace) async {
    try {
      Response response = await dio.post(
        '/publicplace',
        data: publicPlace.toJson(),
      );

      if (response.statusCode == 201) {
        return PublicPlaceModel.fromJson(response.data);
      } else {
        throw Exception('Erro ao criar forma de pagamento');
      }
    } catch (e) {
      throw Exception('Erro ao criar forma de pagamento: $e');
    }
  }
}
