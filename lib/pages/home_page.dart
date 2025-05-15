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
              color: Colors.white,
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
      color: Colors.white,
    );
    String selectedValue = "Home";
    List<String> items =["Home", "About", "Contact", "Login", "Sign Up"];
    return DropdownButton<String>(
      value: selectedValue,
      style: navStyle,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      dropdownColor: Colors.blue.shade800,
      borderRadius: BorderRadius.circular(6),
      underline: SizedBox(),
      items: items.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: Text(e),
            ),
          );
        }).toList(),
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
