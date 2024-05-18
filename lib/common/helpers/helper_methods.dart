import 'package:cloud_firestore/cloud_firestore.dart';

String formatdate(Timestamp timestamp) {
  DateTime date = timestamp.toDate();

  String year = date.year.toString();
  String month = date.month.toString();
  String day = date.day.toString();

  String formattedDAte = '$day/$month/$year';

  return formattedDAte;
}
