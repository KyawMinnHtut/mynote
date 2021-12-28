import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Note',
      theme: ThemeData(primarySwatch: Colors.blue),
      getPages: MyRoutes.routes,
      initialRoute: '/home',
    );
  }
}
