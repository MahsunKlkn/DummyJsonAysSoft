import 'package:ayssoft/app/manager/provider/product.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/product-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListWidget extends ConsumerWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productNotifierProvider);

    if (productState.isLoading) {
      return const SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (productState.errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: Text('Hata: ${productState.errorMessage}')),
      );
    }

    if (productState.products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text('Ürün bulunamadı.')),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), 

      itemCount: productState.products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final product = productState.products[index];
        return ProductCard(product: product);
      },
    );
  }
}


