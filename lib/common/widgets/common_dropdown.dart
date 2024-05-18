import 'package:flutter/material.dart';

class CommonDropDown extends StatelessWidget {
  final String? hintText;
  final List<DropdownMenuItem<int>>? dropdownMenuItems;
  final int? value;
  final void Function(int?)? onChanged;
  const CommonDropDown({
    super.key,
    this.hintText,
    this.dropdownMenuItems,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      items: dropdownMenuItems,
      onChanged: onChanged,
      value: value,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
    );
  }
}
