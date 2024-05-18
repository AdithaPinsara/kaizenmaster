import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommonTile extends StatelessWidget {
  final String? title;
  final String? datetime;
  const CommonTile({super.key, this.title, this.datetime});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(title ?? ""), Text(datetime ?? "")],
      ),
    );
  }
}
