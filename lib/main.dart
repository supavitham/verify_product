import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verify_product/controller/verify_product_controller.dart';
import 'package:verify_product/screen/verify_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<VerifyProductController>(
        create: (BuildContext context) => VerifyProductController(context),
        child: const VerifyProductScreen(),
      ),
    );
  }
}
