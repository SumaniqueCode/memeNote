import 'package:flutter/material.dart';
import 'package:memenote/pages/about_page.dart';
import 'package:memenote/pages/login_page.dart';
import 'package:memenote/pages/signup_page.dart';

// Reusable dropdown widget
class CustomDropdown extends StatefulWidget {
  final List<String> values;
  final void Function(String) onSelected;

  const CustomDropdown({
    required this.values,
    required this.onSelected,
    super.key,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.values.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      dropdownColor: Colors.blue.shade800,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      underline: const SizedBox(),
      items:
          widget.values
              .map((v) => DropdownMenuItem(value: v, child: Text(v)))
              .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => selectedValue = value);
          widget.onSelected(value);
        }
      },
    );
  }
}

// Main page with dynamic body content
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> menuItems = [
    "Home",
    "About",
    "Contact",
    "Login",
    "Sign Up",
  ];
  String selectedMenu = "Home";

  Widget getBodyWidget() {
    switch (selectedMenu) {
      case "About":
        return AboutPage();
      case "Contact":
        return Text(
          "Contact Page",
          style: const TextStyle(fontSize: 24, color: Colors.white),
        );
      case "Login":
        return LoginPage();
      case "Sign Up":
        return SignupPage();
      default:
        return Center(child: _adminImage());
    }
  }

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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text(
          "MemeNote",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        actions: [
          Center(
            child: CustomDropdown(
              values: menuItems,
              onSelected: (value) {
                setState(() {
                  selectedMenu = value;
                });
              },
            ),
          ),
        ],
      ),
      body: SafeArea(child: getBodyWidget()),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: HomePage()));
}
