import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommonRadioButton extends StatefulWidget {
  final String? title;
  final Function(bool?)? onChanged;
  final bool? value;
  const CommonRadioButton({super.key, this.title, this.value, this.onChanged});

  @override
  State<CommonRadioButton> createState() => _CommonRadioButtonState();
}

class _CommonRadioButtonState extends State<CommonRadioButton> {
  bool? _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.value;
  }

  void _handleRadioValueChange(bool? value) {
    setState(() {
      _groupValue = value;
      widget.onChanged!(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title!,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                activeColor: Colors.black,
                title: const Text('Yes'),
                value: true,
                groupValue: _groupValue,
                onChanged: _handleRadioValueChange,
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                activeColor: Colors.black,
                title: const Text('No'),
                value: false,
                groupValue: _groupValue,
                onChanged: _handleRadioValueChange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
