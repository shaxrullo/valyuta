import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valyuta/Pages/homepage.dart';
import 'package:valyuta/homepageProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Homepageprovider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valyuta',
      theme: ThemeData.dark(),
      home: const Homepage(),
    );
  }
}