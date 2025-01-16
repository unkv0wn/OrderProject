import 'package:dio/dio.dart';
import 'package:orderview/src/models/unitymeasurement_model.dart';
import 'package:orderview/src/service/apiservice/api_service.dart';

class UnitService {
  final Dio dio = DioService.getDioInstance();

  Future<List<UnitMeasurementModel>> getAllUnitys() async {
    try {
      Response response = await dio.get('/unitmeasurement');

      return (response.data as List)
          .map((data) => UnitMeasurementModel.fromJson(data))
          .toList();
    } catch (e) {
      throw Exception('Erro ao carregar formas de pagamento: $e');
    }
  }

  Future<UnitMeasurementModel> createUnitMeasurement(
      UnitMeasurementModel unitMeasurement) async {
    try {
      Response response =
          await dio.post('/unitmeasurement', data: unitMeasurement.toJson());

      if (response.statusCode == 201) {
        return UnitMeasurementModel.fromJson(response.data);
      } else {
        throw Exception('Erro ao criar unidade de medida');
      }
    } catch (e) {
      throw Exception('Erro ao criar unidade de medida: $e');
    }
  }
}
