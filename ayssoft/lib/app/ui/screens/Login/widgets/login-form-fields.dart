import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginFormFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;

  const LoginFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberMeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Kullanıcı Adı',
            hintText: 'örn: emilys',
            prefixIcon: const Icon(Icons.person),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            labelStyle: TextStyle(fontSize: 40.sp),
            hintStyle: TextStyle(fontSize: 40.sp),
          ),
        ),
        SizedBox(height: 50.h),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Şifre',
            hintText: 'örn: emilyspass',
            prefixIcon: const Icon(Icons.lock),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: const Icon(Icons.visibility_off),
            labelStyle: TextStyle(fontSize: 40.sp),
            hintStyle: TextStyle(fontSize: 40.sp),
          ),
        ),
        SizedBox(height: 30.h),
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: onRememberMeChanged, // Dışarıdan gelen fonksiyonu kullan
            ),
            Text('Beni Hatırla', style: TextStyle(fontSize: 35.sp)),
          ],
        ),
        SizedBox(height: 80.h),
      ],
    );
  }
}