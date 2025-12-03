import 'package:ayssoft/app/data/model/HiveModel/cart.dart';
import 'package:ayssoft/app/data/model/HiveModel/cartProduct.dart';
import 'package:ayssoft/app/repository/Base/cartBase.dart';
import 'package:hive/hive.dart';

class HiveCartRepository implements ICartBaseRepository {
  static const String _boxName = 'cartBox';
  static const String _cartKey = 'myCart';

  late Box<Cart> _box;

  @override
  Future<void> init() async {
    try {
      _box = await Hive.openBox<Cart>(_boxName);
    } catch (e) {
      print('Hive Cart init hatası: $e');
      rethrow;
    }
  }

  @override
  Cart? getCart() {
    try {
      return _box.get(_cartKey);
    } catch (e) {
      print('Sepeti getirme hatası: $e');
      return null;
    }
  }

  Future<void> _saveCart(Cart cart) async {
    try {
      await _box.put(_cartKey, cart);
    } catch (e) {
      print('Sepeti kaydetme hatası: $e');
      rethrow;
    }
  }

  /// Ürün ekle
  @override
  Future<void> addProduct(CartProduct product) async {
    try {
      final cart = getCart();

      if (cart == null) {
        final newCart = Cart(
          id: DateTime.now().millisecondsSinceEpoch,
          products: [product],
          total: product.total,
          discountedTotal: product.discountedTotal,
          userId: 0,
          totalProducts: 1,
          totalQuantity: product.quantity,
        );
        await _saveCart(newCart);
        return;
      }

      final products = List<CartProduct>.from(cart.products);

      final index = products.indexWhere((p) => p.id == product.id);
      if (index >= 0) {
        final existing = products[index];
        final updatedQuantity = existing.quantity + product.quantity;

        products[index] = CartProduct(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          quantity: updatedQuantity,
          total: existing.price * updatedQuantity,
          discountPercentage: existing.discountPercentage,
          discountedTotal:
              (existing.price * updatedQuantity) * (1 - existing.discountPercentage / 100),
          thumbnail: existing.thumbnail,
        );
      } else {
        products.add(product);
      }

      await _saveCart(Cart(
        id: cart.id,
        products: products,
        total: products.fold(0.0, (sum, p) => sum + (p.price * p.quantity)), 
        discountedTotal: products.fold(0.0, (sum, p) => sum + p.discountedTotal),
        userId: cart.userId,
        totalProducts: products.length,
        totalQuantity: products.fold(0, (sum, p) => sum + p.quantity),
      ));
    } catch (e) {
      print('Ürün ekleme/güncelleme hatası: $e');
      rethrow;
    }
  }

  @override
  Future<void> removeProduct(int productId) async {
    try {
      final cart = getCart();
      if (cart == null) return;

      final products = cart.products.where((p) => p.id != productId).toList();

      await _saveCart(Cart(
        id: cart.id,
        products: products,
        total: products.fold(0.0, (sum, p) => sum + (p.price * p.quantity)),
        discountedTotal: products.fold(0.0, (sum, p) => sum + p.discountedTotal),
        userId: cart.userId,
        totalProducts: products.length,
        totalQuantity: products.fold(0, (sum, p) => sum + p.quantity),
      ));
    } catch (e) {
      print('Ürün silme hatası: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await _box.delete(_cartKey);
    } catch (e) {
      print('Sepeti temizleme hatası: $e');
      rethrow;
    }
  }
}