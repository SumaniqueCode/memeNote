import 'package:flutter/material.dart';

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
              color: Colors.blue,
            ),
          ),
          _menuDropDown(),
        ],
      ),
    );
  }

  Widget _menuDropDown() {
    const TextStyle navStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.blue,
    );
    String selectedValue = "Home";
    List<DropdownMenuItem<String>> items =
        ["Home", "About", "Contact", "Login", "Sign Up"].map((e) {
          return DropdownMenuItem(child: Text(e), value: e);
        }).toList();
    return DropdownButton<String>(
      value: selectedValue,
      style: navStyle,
      items: items,
      onChanged: (String? newValue) {
        selectedValue = newValue!;
      },
    );
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
