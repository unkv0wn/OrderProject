import 'package:dio/dio.dart';
import 'package:orderview/src/models/paymentform_model.dart';
import 'package:orderview/src/service/apiservice/api_service.dart';

class PaymentformServices {
  final Dio dio = DioService.getDioInstance();

  Future<List<PaymentFormModel>> getAllPaymentForm() async {
    try {
      Response response = await dio.get('/paymentform');

      return (response.data as List)
          .map((data) => PaymentFormModel.fromJson(data))
          .toList();
    } catch (e) {
      throw Exception('Erro ao carregar formas de pagamento: $e');
    }
  }

  Future<PaymentFormModel> createPaymentForm(
      PaymentFormModel paymentForm) async {
    try {
      Response response = await dio.post(
        '/paymentform',
        data: paymentForm.toJson(),
      );

      if (response.statusCode == 201) {
        return PaymentFormModel.fromJson(response.data);
      } else {
        throw Exception('Falha ao cadastrar forma de pagamento');
      }
    } catch (e) {
      throw Exception('Erro ao cadastrar forma de pagamento: $e');
    }
  }

  Future<PaymentFormModel> getPaymentToId(String id) async {
    try {
      // Passando o ID como parâmetro de consulta
      Response response = await dio.get('/paymentform/${id.toUpperCase()}');

      return PaymentFormModel.fromJson(response.data.first);
    } catch (e) {
      throw Exception(
          'Erro ao carregar dados do cliente ou forma de pagamento: $e');
    }
  }
}
