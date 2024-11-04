import 'dart:io';
import 'package:diary_app/infrastructure/datasources/local/entities/activity_db.dart';
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

  Future<List<ActivityDB>> getAllActivities() => select(activityDb).get();

  Future<ActivityDB?> getActivityById(String id) {
    return (select(activityDb)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}



Future<void> insertHospitalActivities(AppDatabase db) async {
  await db.into(db.activityDb).insert(ActivityDbCompanion(
    id: const Value("1"),
    title: const Value("Consulta de Emergencia"),
    subtitle: const Value("Evaluación inicial"),
    patientName: const Value("Juan Pérez"),
    description: const Value("Atención de emergencia por dolor abdominal agudo."),
    date: Value(DateTime(2023, 4, 10)),
    time: const Value("10:00 AM"),
    area: const Value("Emergencias"),
    consultType: const Value("Presencial"),
  ));
  await db.into(db.activityDb).insert(ActivityDbCompanion(
    id: const Value("2"),
    title: const Value("Consulta Cardiológica"),
    subtitle: const Value("Chequeo rutinario"),
    patientName: const Value("María López"),
    description: const Value("Chequeo de salud cardíaca y monitoreo de presión arterial."),
    date: Value(DateTime(2023, 4, 11)),
    time: const Value("11:00 AM"),
    area: const Value("Cardiología"),
    consultType: const Value("Presencial"),
  ));
  await db.into(db.activityDb).insert(ActivityDbCompanion(
    id: const Value("3"),
    title: const Value("Consulta Neurológica"),
    subtitle: const Value("Evaluación de migraña"),
    patientName: const Value("Carlos Martínez"),
    description: const Value("Evaluación y tratamiento de migrañas frecuentes."),
    date: Value(DateTime(2023, 4, 12)),
    time: const Value("9:00 AM"),
    area: const Value("Neurología"),
    consultType: const Value("Presencial"),
  ));
  await db.into(db.activityDb).insert(ActivityDbCompanion(
    id: const Value("4"),
    title: const Value("Consulta Oncológica"),
    subtitle: const Value("Revisión de tratamiento"),
    patientName: const Value("Ana García"),
    description: const Value("Seguimiento de tratamiento oncológico y evaluación de progreso."),
    date: Value(DateTime(2023, 4, 13)),
    time: const Value("2:00 PM"),
    area: const Value("Oncología"),
    consultType: const Value("Presencial"),
  ));
  await db.into(db.activityDb).insert(ActivityDbCompanion(
    id: const Value("5"),
    title: const Value("Consulta Ginecológica"),
    subtitle: const Value("Control prenatal"),
    patientName: const Value("Luis Rodríguez"),
    description: const Value("Consulta de control prenatal y revisión de salud materna."),
    date: Value(DateTime(2023, 4, 14)),
    time: const Value("3:00 PM"),
    area: const Value("Ginecología"),
    consultType: const Value("Presencial"),
  ));
  await db.into(db.activityDb).insert(ActivityDbCompanion(
    id: const Value("6"),
    title: const Value("Consulta Pediátrica"),
    subtitle: const Value("Chequeo de desarrollo"),
    patientName: const Value("Isabel Fernández"),
    description: const Value("Evaluación y seguimiento del desarrollo infantil."),
    date: Value(DateTime(2023, 4, 15)),
    time: const Value("11:30 AM"),
    area: const Value("Pediatría"),
    consultType: const Value("Presencial"),
  ));
}
