import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/data/model/HiveModel/cartProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemCompact extends StatelessWidget {
  final CartProduct product;
  final Color primaryColor;
  final VoidCallback onRemove; 

  const CartItemCompact({
    super.key,
    required this.product,
    required this.primaryColor,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // İndirim olup olmadığını kontrol eder
    final bool hasDiscount = product.total != product.discountedTotal;
    // Nihai fiyatı (indirimli fiyatı) belirler
    final double finalPrice = product.discountedTotal;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            // Dikey dolgu artırıldı (vertical: 20.h'dan 25.h'ye)
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h), 
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ürün Resmi/İkonu
                    Container(
                      // Boyut 160.w'dan 180.w'ye çıkarıldı
                      width: 180.w, 
                      height: 180.w, 
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.w),
                        // Eğer ürünün görsel URL'si yoksa fallback olarak Icon kullanılır.
                        child: product.thumbnail.isNotEmpty
                            ? Image.network(
                                product.thumbnail, 
                                fit: BoxFit.cover,
                                // Yüklenirken veya hata oluştuğunda gösterilecek widget'lar
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(child: CircularProgressIndicator(color: AppColors.primary));
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.broken_image, color: Colors.grey, size: 90.sp); // İkon boyutu büyütüldü
                                },
                              )
                            : Icon(Icons.shopping_bag, color: AppColors.primary, size: 90.sp), // İkon boyutu büyütüldü
                      ),
                    ),
                    SizedBox(width: 25.w),

                    // Ürün Bilgileri
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            // Yazı tipi boyutu 44.sp'den 48.sp'ye çıkarıldı
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 48.sp), 
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Stok Kodu: ${product.id}",
                            // Yazı tipi boyutu 38.sp'den 40.sp'ye çıkarıldı
                            style: TextStyle(fontSize: 40.sp, color: Colors.grey[600]), 
                          ),
                          Text(
                            "Adet: ${product.quantity}",
                            // Yazı tipi boyutu 38.sp'den 40.sp'ye çıkarıldı
                            style: TextStyle(fontSize: 40.sp, color: Colors.grey[600]), 
                          ),
                        ],
                      ),
                    ),

                    // Fiyat ve Silme Butonu
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Orijinal Fiyat (İndirim varsa üstü çizili gösterilir)
                        if (hasDiscount) 
                          Text(
                            "${product.total.toStringAsFixed(2)} TL",
                            style: TextStyle(
                              // Yazı tipi boyutu 36.sp'den 38.sp'ye çıkarıldı
                              fontSize: 38.sp, 
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.grey,
                            ),
                          ),
                        // İndirimli/Nihai Fiyat (Her zaman gösterilir ve vurgulanır)
                        Text(
                          "${finalPrice.toStringAsFixed(2)} TL",
                          // Yazı tipi boyutu 46.sp'den 50.sp'ye çıkarıldı
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp, color: AppColors.primary), 
                        ),
                        SizedBox(height: 10.h),
                        // Silme Butonu
                        IconButton(
                          onPressed: onRemove,
                          icon: Icon(Icons.delete_outline, color: Colors.red, size: 60.sp), // İkon boyutu büyütüldü
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Ayırıcı Çizgi
          Divider(height: 1.h, thickness: 1.w, indent: 25.w, endIndent: 25.w, color: AppColors.grey50),
        ],
      ),
    );
  }
}