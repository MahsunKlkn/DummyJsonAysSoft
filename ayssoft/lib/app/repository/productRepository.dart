import 'package:ayssoft/app/data/model/productList.dart';
import 'package:ayssoft/app/data/service/Base/productBase.dart';
import 'package:ayssoft/app/repository/Base/productBase.dart';
// import 'dart:developer'; // Gelişmiş logging için kullanılabilir

class ProductRepository implements ProductBaseRepository {
  final ProductBase _productService;
  ProductRepository(this._productService);
  @override
  Future<ProductListResponse?> fetchProducts() async {
    try {
      final rawData = await _productService.getProducts();
      if (rawData == null) {
        print(
          'HATA [Repository]: ProductService.getProducts() null (boş) JSON döndü.',
        );
        return null;
      }

      final response = ProductListResponse.fromJson(rawData);
      if (response.products != null && response.products!.isNotEmpty) {
        print(
          '✅ BAŞARILI [Repository]: Ürünler başarıyla maplendi. Toplam ürün sayısı: ${response.products!.length}',
        );
        print('İlk Ürün Başlığı: ${response.products!.first.title}');
      } else {
        print(
          '⚠️ UYARI [Repository]: Mapping başarılı, ancak products listesi null veya boş.',
        );
      }

      return response;
    } catch (e) {
      print(
        '❌ KRİTİK HATA [Repository]: Veri modeline dönüştürürken hata oluştu: $e',
      );
      return null;
    }
  }
}
