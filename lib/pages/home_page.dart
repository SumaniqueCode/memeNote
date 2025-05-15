import 'package:flutter/material.dart';
import 'package:memenote/widgets/custom_dropdown.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [_titleText(), _adminImage()])),
    );
  }

  Widget _titleText() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'MemeNote',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          _menuDropDown(),
        ],
      ),
    );
  }

  Widget _menuDropDown() {
    List<String> items = ["Home", "About", "Contact", "Login", "Sign Up"];
    return CustomDropdown(values: items);
  }

  Widget _adminImage() {
    return Container(
      height: 150,
      width: 150,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage("assets/images/admin_circular.png"),
        ),
      ),
    );
  }
}
