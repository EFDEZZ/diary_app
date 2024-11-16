import 'package:intl/intl.dart';

class Activity {
  final String id;
  final String title;
  final String subtitle;
  final String patientName;
  final String description;
  final DateTime date;
  final String time;
  final String area;
  final String consultType;

  Activity({
    required this.time,
    required this.date,
    required this.title,
    required this.subtitle,
    required this.id,
    required this.patientName,
    required this.description,
    required this.area,
    required this.consultType,
  });

  String get formattedDate => DateFormat('dd-MM-yyyy').format(date);
  String get formattedmonth => DateFormat('EEE, d/M/y', 'es_ES').format(date);

}
