import 'dart:io';
import 'package:diary_app/infrastructure/models/activity_db.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(tables: [ActivityDb], daos: [ActivityDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'my_database.sqlite'));
      return NativeDatabase(file);
    });
  }
}

@DriftAccessor(tables: [ActivityDb])
class ActivityDao extends DatabaseAccessor<AppDatabase> with _$ActivityDaoMixin {
  final AppDatabase db;

  ActivityDao(this.db) : super(db);

  //Obtener Actividades del dia actual
  Future<List<ActivityDB>> getAllActivitiesToday() {
  final today = DateTime.now();
  final startOfDay = DateTime(today.year, today.month, today.day);
  final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

  return (select(activityDb)
        ..where((activity) =>
            activity.date.isBetweenValues(startOfDay, endOfDay)))
      .get();
}

  //Obtener actividades de la semana 
Future<List<ActivityDB>> getAllActivitiesThisWeek() async {

  final now = DateTime.now();
  final monday = now.subtract(Duration(days: now.weekday - DateTime.monday));
  final sunday = monday.add(const Duration(days: 6));

  return (select(activityDb)
        ..where((tbl) => tbl.date.isBetweenValues(monday, sunday)))
      .get();
}

  //Obtener actividades en un rango de fecha
  Future<List<ActivityDB>> getActivitiesInRange(DateTime start, DateTime end) {
  return (select(activityDb)
        ..where((tbl) => tbl.date.isBetweenValues(start, end)))
      .get();
}

  //Obtener detalles de una actividad
  Future<ActivityDB?> getActivityById(String id) {
    return (select(activityDb)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  //Exportar planifiacion a vcf
//   Future<void> exportToVcf(List<ActivityDB> activities) async {
//   final StringBuffer vcfContent = StringBuffer();
//   vcfContent.writeln('BEGIN:VCALENDAR');
//   vcfContent.writeln('VERSION:2.0');

//   for (final activity in activities) {
//     vcfContent.writeln('BEGIN:VEVENT');
//     vcfContent.writeln('SUMMARY:${activity.title}');
//     vcfContent.writeln('DESCRIPTION:${activity.description}');
//     vcfContent.writeln('DTSTART:${_formatDateToVcf(activity.date, activity.time)}');
//     vcfContent.writeln('DTEND:${_formatDateToVcf(activity.date, activity.time, durationMinutes: 60)}');
//     vcfContent.writeln('LOCATION:${activity.area}');
//     vcfContent.writeln('END:VEVENT');
//   }

//   vcfContent.writeln('END:VCALENDAR');

//   // Guardar el archivo en el almacenamiento local
//   final directory = await getApplicationDocumentsDirectory();
//   final filePath = '${directory.path}/planificacion.vcf';
//   final file = File(filePath);
//   await file.writeAsString(vcfContent.toString());

//   // Compartir el archivo utilizando SharePlus
//   Share.shareXFiles([XFile(filePath)], text: 'Planificación en formato .vcf');
// }

// String _formatDateToVcf(DateTime date, String time, {int durationMinutes = 0}) {
//   final DateTime dateTime = DateTime(
//     date.year,
//     date.month,
//     date.day,
//     int.parse(time.split(':')[0]),
//     int.parse(time.split(':')[1]),
//   ).add(Duration(minutes: durationMinutes));

//   return '${dateTime.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').split('.')[0]}Z';
// }
}








//Insertar datosssssssssssss
Future<void> insertHospitalActivities(AppDatabase db) async {
  int activityId = 7;
  final DateTime startDate = DateTime(2024, 11, 15);
  final DateTime endDate = DateTime(2024, 12, 10);
  final int daysCount = endDate.difference(startDate).inDays + 1;

  for (int i = 0; i < daysCount; i++) {
    final date = startDate.add(Duration(days: i));
    for (int j = 0; j < 3; j++) {
      await db.into(db.activityDb).insert(ActivityDbCompanion(
        id: Value(activityId.toString()),
        title: Value("Consulta Médica $activityId"),
        subtitle: Value("Consulta de seguimiento $activityId"),
        patientName: Value("Paciente $activityId"),
        description: Value("Nulla voluptate do excepteur nulla sit duis Lorem exercitation enim qui occaecat. Adipisicing quis ea non aliqua. Aliquip commodo qui ad nulla proident adipisicing irure et anim culpa. Amet reprehenderit ea nisi minim pariatur qui eiusmod reprehenderit.Culpa qui Lorem nulla pariatur eiusmod nostrud et. Id ea officia et et dolor labore adipisicing qui laborum officia adipisicing anim fugiat do. Proident dolor do irure labore. Dolor tempor elit elit adipisicing ea dolore amet elit laborum. Nostrud nostrud adipisicing culpa non elit ex in. Ipsum voluptate nostrud Lorem id. Cupidatat amet culpa enim exercitation aliquip. $activityId."),
        date: Value(date),
        time: const Value("10:00 AM"),
        area: const Value("Medicina General"),
        consultType: const Value("Presencial"),
      ));
      activityId++;
    }
  }
}



// Future<void> insertHospitalActivities(AppDatabase db) async {
//   await db.into(db.activityDb).insert(ActivityDbCompanion(
//     id: const Value("1"),
//     title: const Value("Consulta de Emergencia"),
//     subtitle: const Value("Evaluación inicial"),
//     patientName: const Value("Juan Pérez"),
//     description: const Value("Atención de emergencia por dolor abdominal agudo."),
//     date: Value(DateTime(2023, 4, 10)),
//     time: const Value("10:00 AM"),
//     area: const Value("Emergencias"),
//     consultType: const Value("Presencial"),
//   ));
//   await db.into(db.activityDb).insert(ActivityDbCompanion(
//     id: const Value("2"),
//     title: const Value("Consulta Cardiológica"),
//     subtitle: const Value("Chequeo rutinario"),
//     patientName: const Value("María López"),
//     description: const Value("Chequeo de salud cardíaca y monitoreo de presión arterial."),
//     date: Value(DateTime(2023, 4, 11)),
//     time: const Value("11:00 AM"),
//     area: const Value("Cardiología"),
//     consultType: const Value("Presencial"),
//   ));
//   await db.into(db.activityDb).insert(ActivityDbCompanion(
//     id: const Value("3"),
//     title: const Value("Consulta Neurológica"),
//     subtitle: const Value("Evaluación de migraña"),
//     patientName: const Value("Carlos Martínez"),
//     description: const Value("Evaluación y tratamiento de migrañas frecuentes."),
//     date: Value(DateTime(2023, 4, 12)),
//     time: const Value("9:00 AM"),
//     area: const Value("Neurología"),
//     consultType: const Value("Presencial"),
//   ));
//   await db.into(db.activityDb).insert(ActivityDbCompanion(
//     id: const Value("4"),
//     title: const Value("Consulta Oncológica"),
//     subtitle: const Value("Revisión de tratamiento"),
//     patientName: const Value("Ana García"),
//     description: const Value("Seguimiento de tratamiento oncológico y evaluación de progreso."),
//     date: Value(DateTime(2023, 4, 13)),
//     time: const Value("2:00 PM"),
//     area: const Value("Oncología"),
//     consultType: const Value("Presencial"),
//   ));
//   await db.into(db.activityDb).insert(ActivityDbCompanion(
//     id: const Value("5"),
//     title: const Value("Consulta Ginecológica"),
//     subtitle: const Value("Control prenatal"),
//     patientName: const Value("Luis Rodríguez"),
//     description: const Value("Consulta de control prenatal y revisión de salud materna."),
//     date: Value(DateTime(2023, 4, 14)),
//     time: const Value("3:00 PM"),
//     area: const Value("Ginecología"),
//     consultType: const Value("Presencial"),
//   ));
//   await db.into(db.activityDb).insert(ActivityDbCompanion(
//     id: const Value("6"),
//     title: const Value("Consulta Pediátrica"),
//     subtitle: const Value("Chequeo de desarrollo"),
//     patientName: const Value("Isabel Fernández"),
//     description: const Value("Evaluación y seguimiento del desarrollo infantil."),
//     date: Value(DateTime(2023, 4, 15)),
//     time: const Value("11:30 AM"),
//     area: const Value("Pediatría"),
//     consultType: const Value("Presencial"),
//   ));
// }
