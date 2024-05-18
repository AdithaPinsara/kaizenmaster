import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaizenmaster/common/widgets/button.dart';
import 'package:kaizenmaster/common/widgets/common_dropdown.dart';
import 'package:kaizenmaster/common/widgets/common_textfield.dart';
import 'package:kaizenmaster/common/widgets/evidence_selector.dart';

class IncidentReportPage extends StatefulWidget {
  final String? id;
  final bool? viewMode;
  const IncidentReportPage({super.key, this.id, this.viewMode});

  @override
  State<IncidentReportPage> createState() => _IncidentReportPageState();
}

class _IncidentReportPageState extends State<IncidentReportPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  int? category = null;
  int? subCategory = null;
  int? location = null;

  final categorylist = [
    const DropdownMenuItem(
      value: 1,
      child: Text('Category 1'),
    ),
    const DropdownMenuItem(
      value: 2,
      child: Text('Category 2'),
    ),
    const DropdownMenuItem(
      value: 3,
      child: Text('Category 3'),
    ),
  ];

  void onChangecat(int? catId) {
    category = catId;
  }

  void onChangesubcat(int? subcatId) {
    subCategory = subcatId;
  }

  void onChangeloc(int? locId) {
    location = locId;
  }

  void clear() {
    category = null;
    subCategory = null;
    location = null;
    setState(() {
      titleController.clear();
      descriptionController.clear();
    });
  }

  void postMessage() {
    FirebaseFirestore.instance.collection("incidents").add({
      "Title": titleController.text,
      "Description": descriptionController.text,
      "Category": category,
      "SubCategory": subCategory,
      "Location": location,
      "TimeStamp": Timestamp.now(),
    });
    clear();
  }

  @override
  void initState() async {
    if (widget.viewMode != null && widget.viewMode!) {
      final commentDocs = await FirebaseFirestore.instance
          .collection('incidents')
          .doc(widget.id!)
          .get();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Incident Reporting",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CommonTextField(
                      controller: titleController,
                      hintText: "Title",
                      obscureText: false,
                      readOnly: false,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CommonTextField(
                      controller: descriptionController,
                      hintText: "Description",
                      obscureText: false,
                      readOnly: false,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CommonDropDown(
                      hintText: "Select a category",
                      dropdownMenuItems: categorylist,
                      value: category,
                      onChanged: onChangecat,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CommonDropDown(
                      hintText: "Select a sub category",
                      dropdownMenuItems: categorylist,
                      value: subCategory,
                      onChanged: onChangesubcat,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CommonDropDown(
                      hintText: "Location",
                      dropdownMenuItems: categorylist,
                      value: location,
                      onChanged: onChangeloc,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Visibility(
                      visible: false,
                      child: CommonTextField(
                        controller: titleController,
                        hintText: "Date & Time",
                        obscureText: false,
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const EvidenceSelector(),
                    const SizedBox(
                      height: 12,
                    ),
                    Visibility(
                      visible: false,
                      child: CommonDropDown(
                        hintText: "Status",
                        dropdownMenuItems: categorylist,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Visibility(
                      visible: false,
                      child: CommonDropDown(
                        hintText: "Asigned to",
                        dropdownMenuItems: categorylist,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Visibility(
                      visible: false,
                      child: CommonTextField(
                        controller: titleController,
                        hintText: "Reported by",
                        obscureText: false,
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      name: "Clear",
                      ontap: clear,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: CommonButton(
                      name: "Save",
                      ontap: postMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
