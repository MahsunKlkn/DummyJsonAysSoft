import 'package:ayssoft/app/manager/state/productState.dart';
import 'package:ayssoft/app/repository/productRepository.dart';
import 'package:flutter_riverpod/legacy.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductRepository _repository;

  ProductNotifier(this._repository) : super(ProductState());

  

  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _repository.fetchProducts();

      if (response != null && response.products != null) {
        state = state.copyWith(
          products: response.products,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: "Ürünler yüklenemedi veya liste boş.",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(), 
      );
    }
  }
}