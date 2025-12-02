import 'package:ayssoft/app/data/service/Base/productBase.dart';
import 'package:dio/dio.dart';
import '../../core/config/dio.dart';
import '../../core/config/endpoint.dart';

class ProductService implements ProductBase {
  final Dio _dio = DioClient.instance;

  @override
  Future<Map<String, dynamic>?> getProducts() async {
    try {
      final response = await _dio.get(ApiPaths.products);

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } on DioException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
