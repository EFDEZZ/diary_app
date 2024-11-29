import 'dart:io';
import 'dart:math';
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

  // Comprobar si la base de datos ya tiene actividades
  Future<bool> hasActivities() async {
    final count = await (select(activityDb)..limit(1)).get();
    return count.isNotEmpty;
  }

  // Insertar actividades solo si la base de datos está vacía
  Future<void> insertInitialActivities(List<ActivityDbCompanion> activities) async {
    final hasData = await hasActivities();
    if (!hasData) {
      for (final activity in activities) {
        await into(activityDb).insert(activity);
      }
    } 
  }

  //Obtener Actividades del dia actual
Future<List<ActivityDB>> getAllActivitiesToday() {
  final today = DateTime.now();
  final startOfDay = DateTime(today.year, today.month, today.day);
  final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

  return (select(activityDb)
        ..where((activity) =>
            activity.date.isBetweenValues(startOfDay, endOfDay))
        ..orderBy([
          // Usar SQL personalizado para convertir y ordenar por tiempo (AM/PM)
          (activity) => OrderingTerm(
                expression: const CustomExpression<String>(
                  """
                  CASE
                    WHEN SUBSTR(time, -2) = 'AM' AND SUBSTR(time, 1, 2) = '12' THEN '00:' || SUBSTR(time, 4, 2)
                    WHEN SUBSTR(time, -2) = 'AM' THEN SUBSTR('0' || SUBSTR(time, 1, INSTR(time, ':') - 1), -2) || ':' || SUBSTR(time, INSTR(time, ':') + 1, 2)
                    WHEN SUBSTR(time, -2) = 'PM' AND SUBSTR(time, 1, 2) = '12' THEN '12:' || SUBSTR(time, 4, 2)
                    ELSE CAST((CAST(SUBSTR(time, 1, INSTR(time, ':') - 1) AS INTEGER) + 12) AS TEXT) || ':' || SUBSTR(time, INSTR(time, ':') + 1, 2)
                  END
                  """
                ),
                mode: OrderingMode.asc,
              ),
        ]))
      .get();
}


  //Obtener actividades de la semana 
Future<List<ActivityDB>> getAllActivitiesThisWeek() async {
  final now = DateTime.now();
  final monday = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));

  final sunday = monday.add(const Duration(days: 6));

  return (select(activityDb)
        ..where((tbl) => tbl.date.isBetweenValues(monday, sunday))
        ..orderBy([
          // Ordenar primero por día (campo date)
          (tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.asc),
          // Ordenar luego por hora (campo time convertido a 24 horas)
          (tbl) => OrderingTerm(
                expression: const CustomExpression<String>(
                  """
                  CASE
                    WHEN SUBSTR(time, -2) = 'AM' AND SUBSTR(time, 1, 2) = '12' THEN '00:' || SUBSTR(time, 4, 2)
                    WHEN SUBSTR(time, -2) = 'AM' THEN SUBSTR('0' || SUBSTR(time, 1, INSTR(time, ':') - 1), -2) || ':' || SUBSTR(time, INSTR(time, ':') + 1, 2)
                    WHEN SUBSTR(time, -2) = 'PM' AND SUBSTR(time, 1, 2) = '12' THEN '12:' || SUBSTR(time, 4, 2)
                    ELSE CAST((CAST(SUBSTR(time, 1, INSTR(time, ':') - 1) AS INTEGER) + 12) AS TEXT) || ':' || SUBSTR(time, INSTR(time, ':') + 1, 2)
                  END
                  """
                ),
                mode: OrderingMode.asc,
              ),
        ]))
      .get();
}


  //Obtener actividades en un rango de fecha
Future<List<ActivityDB>> getActivitiesInRange(DateTime start, DateTime end) {
  return (select(activityDb)
        ..where((tbl) => tbl.date.isBetweenValues(start, end))
        ..orderBy([
          // Primero ordenar por fecha (campo date)
          (tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.asc),
          // Luego ordenar por hora (campo time convertido a un formato adecuado)
          (tbl) => OrderingTerm(
                expression: const CustomExpression<String>(
                  """
                  CASE
                    WHEN SUBSTR(time, -2) = 'AM' AND SUBSTR(time, 1, 2) = '12' THEN '00:' || SUBSTR(time, 4, 2)
                    WHEN SUBSTR(time, -2) = 'AM' THEN SUBSTR('0' || SUBSTR(time, 1, INSTR(time, ':') - 1), -2) || ':' || SUBSTR(time, INSTR(time, ':') + 1, 2)
                    WHEN SUBSTR(time, -2) = 'PM' AND SUBSTR(time, 1, 2) = '12' THEN '12:' || SUBSTR(time, 4, 2)
                    ELSE CAST((CAST(SUBSTR(time, 1, INSTR(time, ':') - 1) AS INTEGER) + 12) AS TEXT) || ':' || SUBSTR(time, INSTR(time, ':') + 1, 2)
                  END
                  """
                ),
                mode: OrderingMode.asc,
              ),
        ]))
      .get();
}


  //Obtener detalles de una actividad
  Future<ActivityDB?> getActivityById(String id) {
    return (select(activityDb)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}








//Insertar datosssssssssssss
Future<void> insertHospitalActivities(AppDatabase db) async {
  final activities = <ActivityDbCompanion>[];
  int activityId = 1;
  final DateTime startDate = DateTime(2024, 11, 15);
  final DateTime endDate = DateTime(2024, 12, 10);
  final int daysCount = endDate.difference(startDate).inDays + 1;

  final List<String> titles = [
    "Consulta Médica",
    "Consulta Cardiológica",
    "Consulta Neurológica",
    "Chequeo General",
    "Consulta Pediátrica",
    "Control Prenatal",
  ];

  final List<String> areas = [
    "Medicina General",
    "Cardiología",
    "Neurología",
    "Pediatría",
    "Ginecología",
    "Dermatología",
  ];

  final List<String> consultTypes = ["Presencial", "Virtual"];
  final Random random = Random();

  // Horarios disponibles para cada día (de 8:00 AM a 5:00 PM, intervalos de 1 hora)
  final List<String> availableTimes = [
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
  ];

  for (int i = 0; i < daysCount; i++) {
    final date = startDate.add(Duration(days: i));
    final List<String> timesForDay = List.from(availableTimes); // Copia de horarios disponibles para el día

    for (int j = 0; j < 5; j++) {
      if (timesForDay.isEmpty) {
        break; // No hay más horarios disponibles para el día
      }

      // Seleccionar un horario aleatorio del listado disponible
      final int timeIndex = random.nextInt(timesForDay.length);
      final String time = timesForDay.removeAt(timeIndex); // Remover el horario seleccionado para evitar repeticiones

      final titleIndex = random.nextInt(titles.length);
      final areaIndex = random.nextInt(areas.length);
      final consultTypeIndex = random.nextInt(consultTypes.length);

      final activity = ActivityDbCompanion(
        id: Value(activityId.toString()),
        title: Value("${titles[titleIndex]} $activityId"),
        subtitle: Value("Seguimiento ${titles[titleIndex]} $activityId"),
        patientName: Value("Paciente ${activityId + random.nextInt(100)}"),
        description: Value(
          "Descripción detallada de la ${titles[titleIndex]} realizada para el paciente con ID $activityId. Incluye detalles específicos para la fecha $date."),
        date: Value(date),
        time: Value(time),
        area: Value(areas[areaIndex]),
        consultType: Value(consultTypes[consultTypeIndex]),
      );

      activities.add(activity);
      activityId++;
    }
  }

  await db.activityDao.insertInitialActivities(activities);
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
