import 'package:flutter/material.dart';

class CommonListTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final void Function()? onTap;
  const CommonListTile({
    super.key,
    required this.icon,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        onTap: onTap,
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
