import 'package:ayssoft/app/manager/state/cartState.dart';
import 'package:ayssoft/app/data/model/HiveModel/cartProduct.dart';
import 'package:ayssoft/app/repository/Base/cartBase.dart';
import 'package:flutter_riverpod/legacy.dart';

class CartNotifier extends StateNotifier<CartState> {
  final ICartBaseRepository _repository;

  CartNotifier(this._repository) : super( CartState()) { 
    _loadCart();
  }

  Future<void> _loadCart() async {
    state = state.copyWith(isLoading: true);
    try {
      await _repository.init(); // Repository'i başlat
      final cart = _repository.getCart(); // Repository'den sepeti al
      state = state.copyWith(cart: cart, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> addProduct(CartProduct product) async {
    state = state.copyWith(isLoading: true);

    try {
      await _repository.addProduct(product); // Repository ile ekle
      final cart = _repository.getCart(); // Repository'den güncel sepeti al
      state = state.copyWith(cart: cart, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> removeProduct(int productId) async {
    state = state.copyWith(isLoading: true);

    try {
      await _repository.removeProduct(productId); // Repository ile sil
      final cart = _repository.getCart(); // Repository'den güncel sepeti al
      state = state.copyWith(cart: cart, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> clearCart() async {
    state = state.copyWith(isLoading: true);

    try {
      await _repository.clearCart(); // Repository ile temizle
      state = state.copyWith(cart: null, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}