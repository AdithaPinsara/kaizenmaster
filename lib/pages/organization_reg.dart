import 'package:flutter/material.dart';
import 'package:kaizenmaster/common/widgets/common_textfield.dart';

class OrganizationRegistration extends StatefulWidget {
  const OrganizationRegistration({super.key});

  @override
  State<OrganizationRegistration> createState() =>
      _OrganizationRegistrationState();
}

class _OrganizationRegistrationState extends State<OrganizationRegistration> {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organization Registration"),
      ),
      body: Container(
        child: Column(
          children: [
            CommonTextField(
              controller: nameController,
              hintText: "Enter Organization Name",
              obscureText: false,
              readOnly: false,
            ),
            SizedBox(
              height: 12,
            ),
            Text("Customize your organization with organization page"),
          ],
        ),
      ),
    );
  }
}
