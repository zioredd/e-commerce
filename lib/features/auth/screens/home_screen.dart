import 'package:e_commerce_app/common/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // get the user from the provider
    // final user = Provider.of<UserProvider>(context).user;

    return const Scaffold(
      body: Center(child: Text('Home Page')),
    );
  }
}
