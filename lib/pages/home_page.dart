import 'package:flutter/material.dart';
import 'package:memenote/pages/main_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _adminImage() {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 150,
      width: 150,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/admin_circular.png"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Center(child: _adminImage()),
    );
  }
}
