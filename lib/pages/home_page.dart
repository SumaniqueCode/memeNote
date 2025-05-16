import 'package:flutter/material.dart';
import 'package:memenote/pages/about_page.dart';
import 'package:memenote/widgets/custom_dropdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> items = ["Home", "About", "Contact", "Login", "Sign Up"];
  String selectedValue = "Home";

  Widget _getSelectedContent() {
    switch (selectedValue) {
      case "About":
        return Center(child:AboutPage() );
      case "Contact":
        return Center(child: Text("Contact Page", style: TextStyle(color: Colors.white)));
      case "Login":
        return Center(child: Text("Login Page", style: TextStyle(color: Colors.white)));
      case "Sign Up":
        return Center(child: Text("Sign Up Page", style: TextStyle(color: Colors.white)));
      default:
        return _adminImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Optional: match design
      body: SafeArea(
        child: Column(
          children: [
            _titleText(),
            Expanded(child: _getSelectedContent()),
          ],
        ),
      ),
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
          CustomDropdown(
            values: items,
            onSelected: (value) {
              setState(() {
                selectedValue = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _adminImage() {
    return Container(
      height: 150,
      width: 150,
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage("assets/images/admin_circular.png"),
        ),
      ),
    );
  }
}
