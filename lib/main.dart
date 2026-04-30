import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/login_screen.dart';
import 'package:ecommerce_app/pages/register.screen.dart';
import 'package:ecommerce_app/pages/splash_screen.dart';
import 'package:ecommerce_app/layout/main_layout.dart';
import 'utils/routes.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => CartProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        routes: {
          Routes.splash: (context) => const SplashScreen(),
          Routes.login: (context) => const LoginScreen(),
          Routes.reg: (context) => const RegScreen(),
          Routes.main: (context) => const MainLayout(),
        },
      ),
    );
  }
}
