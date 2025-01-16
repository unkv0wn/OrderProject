import 'package:dio/dio.dart';
import 'package:orderview/src/models/clifor_model.dart';
import 'package:orderview/src/service/apiservice/api_service.dart';

class ClientsService {
  final Dio dio = DioService.getDioInstance();

  Future<List<CliforModel>> getAllClifor() async {
    try {
      Response response = await dio.get('/clifor');

      return (response.data as List)
          .map((data) => CliforModel.fromJson(data))
          .toList();
    } catch (e) {
      throw Exception('Erro ao carregar formas de pagamento: $e');
    }
  }

  Future<CliforModel> createClifor(CliforModel clifor) async {
    try {
      Response response = await dio.post('/clifor', data: clifor.toJson());

      if (response.statusCode == 201) {
        return CliforModel.fromJson(response.data);
      } else {
        throw Exception('Erro ao criar forma de pagamento');
      }
    } catch (e) {
      throw Exception('Erro ao criar produto: $e');
    }
  }
}
