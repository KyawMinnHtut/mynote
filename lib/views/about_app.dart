import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        centerTitle: true,
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('About Note App'),
          SizedBox(height: 24,),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('This app is develped by using GetX state management. For data storage, sqflite package is used.'),
          )
        ],
      ),      
    );
  }
}