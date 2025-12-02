import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef LogoutCallback = void Function();

class LogoutButton extends StatelessWidget {
  final LogoutCallback onPressed;
  final String text;

  const LogoutButton({
    super.key,
    required this.onPressed,
    this.text = 'Çıkış Yap',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 10.0.w, 
        top: 3.0.h, 
        bottom: 3.0.h,
        left: 10.0.w,
      ), 
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF003366),
          side: BorderSide(
            color: Colors.grey[350]!,
            width: 1.0.w, 
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0.w), 
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10.w, 
            vertical: 4.h,
          ), 
          backgroundColor: Colors.transparent, 
        ),
        child: Text(
          text, 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 48.sp, 
          ),
        ),
      ),
    );
  }
}