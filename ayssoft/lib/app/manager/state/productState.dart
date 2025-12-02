// app/data/state/product_state.dart
import 'package:ayssoft/app/data/model/product.dart';

class ProductState {
  final List<Product> products;
  final bool isLoading;
  final String? errorMessage;

  ProductState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // Hata mesajı null olabilir
    );
  }
}