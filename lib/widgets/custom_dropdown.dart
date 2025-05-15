import "package:flutter/material.dart";

class CustomDropdown extends StatelessWidget {
  final List<String> values;
  const CustomDropdown({required this.values, super.key});
  @override
  Widget build(BuildContext context) {
    const TextStyle menuItemStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );
    String selectedValue = "Home";

    return DropdownButton<String>(
      value: selectedValue,
      style: menuItemStyle,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      dropdownColor: Colors.blue.shade800,
      borderRadius: BorderRadius.circular(6),
      underline: SizedBox(),
      items:
          values.map((e) {
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
}
