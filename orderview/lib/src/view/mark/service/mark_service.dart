import 'package:dio/dio.dart';
import 'package:orderview/src/models/mark_model.dart';
import 'package:orderview/src/service/apiservice/api_service.dart';

class MarkService {
  final Dio dio = DioService.getDioInstance();

  Future<List<MarkModel>> getAllMark() async {
    try {
      Response response = await dio.get('/mark');

      return (response.data as List)
          .map((data) => MarkModel.fromJson(data))
          .toList();
    } catch (e) {
      throw Exception('Erro ao carregar formas de pagamento: $e');
    }
  }

  Future<MarkModel> createMark(MarkModel mark) async {
    try {
      Response response = await dio.post(
        '/mark',
        data: mark.toJson(),
      );

      if (response.statusCode == 201) {
        return MarkModel.fromJson(response.data);
      } else {
        throw Exception('Falha ao cadastrar marca');
      }
    } catch (e) {
      throw Exception('Erro ao cadastrar marca: $e');
    }
  }
}
