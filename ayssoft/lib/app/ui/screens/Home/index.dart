import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/core/storage/auth.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/hero-banner.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/logout-btn.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/product-list.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/section-title.dart';
import 'package:ayssoft/app/ui/screens/Login/index.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _signOutAndNavigate() async {
    await AuthCacheManager.instance.signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: AppColors.grey50,
        title: Text(widget.title),
        actions: <Widget>[LogoutButton(onPressed: _signOutAndNavigate)],
      ),

      body: SingleChildScrollView( 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start, 
        
        children: <Widget>[
          const HeroBanner(),
          const SectionTitle(title: "Ürünler"),
          ProductListWidget(),
        ],
      ),
    ),
    );
  }
}
