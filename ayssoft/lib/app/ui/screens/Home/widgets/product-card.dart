import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/data/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ScreenUtil import edildi!

class ProductCard extends StatelessWidget {
  final Product product;
  
  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, 
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: InkWell(
        onTap: () {
        },
        borderRadius: BorderRadius.circular(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
                    child: Image.network(
                      product.thumbnail,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator(strokeWidth: 2.w));
                      },
                      errorBuilder: (context, error, stackTrace) => 
                          Center(child: Icon(Icons.broken_image, size: 40.w, color: Colors.grey)),
                    ),
                  ),
                  
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: IconButton(
                        iconSize: 72.sp, 
                        padding: EdgeInsets.all(4.r), 
                        icon: const Icon(Icons.favorite_border, color: Colors.red),
                        onPressed: () {
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 36.sp, 
                        color: Colors.black87
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w900,
                                fontSize: 36.sp, 
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 36.sp), 
                                SizedBox(width: 2.w),
                                Text(
                                  product.rating.toStringAsFixed(1),
                                  style: TextStyle(fontSize: 48.sp, color: Colors.grey), 
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 100.h, 
                              width: 250.w,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r), 
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                ),
                                icon: Icon(Icons.shopping_cart, size: 36.sp), 
                                label: Text(
                                  'Sepete Ekle',
                                  style: TextStyle(
                                    fontSize: 28.sp, 
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}