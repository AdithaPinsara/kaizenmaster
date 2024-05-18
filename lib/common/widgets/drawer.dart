import 'package:kaizenmaster/common/widgets/list_tile.dart';
import 'package:flutter/material.dart';

class CommonDrawer extends StatelessWidget {
  final void Function()? onTapprofile;
  final void Function()? onTapSignOut;
  const CommonDrawer(
      {super.key, required this.onTapSignOut, required this.onTapprofile});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              CommonListTile(
                icon: Icons.home,
                name: "H O M E",
                onTap: () => Navigator.pop(context),
              ),
              CommonListTile(
                icon: Icons.person,
                name: "P R O F I L E",
                onTap: onTapprofile,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CommonListTile(
              icon: Icons.logout,
              name: "L O G O U T",
              onTap: onTapSignOut,
            ),
          )
        ],
      ),
    );
  }
}
