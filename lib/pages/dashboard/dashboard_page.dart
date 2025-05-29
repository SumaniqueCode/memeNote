import 'package:flutter/material.dart';
import 'package:memenote/pages/main_layout.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Center(
        child: Text(
          'This is Dashboard',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
