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
  String get formattedmonth => DateFormat('EEE, M/d/y', 'es_ES').format(date);

  factory Activity.fromDb(Activity dbActivity) {
    return Activity(
      id: dbActivity.id,
      title: dbActivity.title,
      subtitle: dbActivity.subtitle,
      patientName: dbActivity.patientName,
      description: dbActivity.description,
      date: dbActivity.date,
      time: dbActivity.time,
      area: dbActivity.area,
      consultType: dbActivity.consultType,
    );
  }
}


// // Codigo provisional (Solo para design)

// List<Activity> activities = [
//   Activity(
//   title: 'Consulta General',
//   subtitle: 'Chequeo Anual',
//   date: DateTime.parse("2024-02-27"),
//   time: '09:00 AM',
//   patientName: 'María González',
//   description: 'Revisión general y chequeo anual',
//   id: 'link1',

// ),

// Activity(
//   title: 'Consulta Pediátrica',
//   subtitle: 'Revisión de Rutina',
//   date: DateTime(2024, 10, 6,),
//   time: '10:30 AM',
//   patientName: 'Juan Pérez',
//   description: 'Revisión de rutina y vacunas',
//   id: 'link2',
  
// ),

// Activity(
//   title: 'Consulta Cardiológica',
//   subtitle: 'Evaluación de Presión',
//   date: DateTime(2024, 10, 7),
//   time: '11:00 AM',
//   patientName: 'Carlos Ramírez',
//   description: 'Evaluación de presión arterial y electrocardiograma',
//   id: 'link3',
  
// ),

// Activity(
//   title: 'Consulta Dermatológica',
//   subtitle: 'Examen de Lunares',
//   date: DateTime(2024, 10, 8),
//   time: '01:00 PM',
//   patientName: 'Ana López',
//   description: 'Examen de lunares y manchas en la piel',
//   id: 'link4',
  
// ),

// Activity(
//   title: 'Consulta Oftalmológica',
//   subtitle: 'Revisión de la Vista',
//   date: DateTime(2024, 10, 9),
//   time: '02:30 PM',
//   patientName: 'Luis Fernández',
//   description: 'Mollit do pariatur ullamco cillum eu id proident esse anim pariatur excepteur eiusmod laboris aliquip. Cupidatat laboris sunt ipsum enim laborum est duis velit aliquip amet sint ullamco dolor cupidatat. Eiusmod pariatur dolor Lorem et consectetur aliquip est aute qui veniam pariatur. Ullamco duis incididunt tempor ea in quis do voluptate aute velit. Lorem id consectetur sint dolore id et deserunt.Mollit do pariatur ullamco cillum eu id proident esse anim pariatur excepteur eiusmod laboris aliquip. Cupidatat laboris sunt ipsum enim laborum est duis velit aliquip amet sint ullamco dolor cupidatat. Eiusmod pariatur dolor Lorem et consectetur aliquip est aute qui veniam pariatur. Ullamco duis incididunt tempor ea in quis do voluptate aute velit. Lorem id consectetur sint dolore id et deserunt.',
//   id: 'link5',
  
// ),

// ];
