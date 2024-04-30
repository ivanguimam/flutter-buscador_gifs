import 'package:flutter/material.dart';

import 'package:buscador_gifs/pages/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.white,
      )
    );
  }
}
