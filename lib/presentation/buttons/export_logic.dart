import 'dart:io';
import 'package:diary_app/common/db/database.dart';
import 'package:diary_app/domain/entities/activity.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../infrastructure/mappers/activity_mapper.dart';

class ExportLogic {
  final AppDatabase database;

  ExportLogic(this.database);

  /// Solicitar permisos de almacenamiento
  Future<bool> _requestStoragePermission() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  /// Obtener actividades filtradas según el filtro seleccionado
  Future<List<Activity>> getFilteredActivities({
    required String selectedFilter,
    DateTimeRange? selectedDateRange,
  }) async {
    try {
      List<ActivityDB> activitiesDB = [];

      if (selectedFilter == 'Hoy') {
        activitiesDB = await database.activityDao.getAllActivitiesToday();
      } else if (selectedFilter == 'Semana') {
        activitiesDB = await database.activityDao.getAllActivitiesThisWeek();
      } else if (selectedFilter == 'Rango de fechas' &&
          selectedDateRange != null) {
        activitiesDB = await database.activityDao.getActivitiesInRange(
          selectedDateRange.start,
          selectedDateRange.end,
        );
      }

      return activitiesDB
          .map((dbActivity) => ActivityMapper.activityDbToActivity(dbActivity))
          .toList();
    } catch (e) {
      print("Error al obtener actividades filtradas: $e");
      return [];
    }
  }

  /// Exportar actividades a un archivo .vcf en la carpeta Descargas
  Future<String?> exportToVcf(List<Activity> activities) async {
    // Solicitar permisos de almacenamiento
    if (!await _requestStoragePermission()) {
      print("Permiso de almacenamiento no concedido.");
      return null;
    }

    try {
      // Directorio de Descargas
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final filePath = '${directory.path}/planificacion.vcf';
      final file = File(filePath);

      final sink = file.openWrite();

      // Escribir el contenido del archivo .vcf
      sink.writeln('BEGIN:VCALENDAR');
      sink.writeln('VERSION:2.0');
      for (var activity in activities) {
        final startDate = activity.date; // Fecha de inicio
        final endDate =
            startDate.add(const Duration(hours: 1)); // Duración predeterminada

        sink.writeln('BEGIN:VEVENT');
        sink.writeln('SUMMARY:${activity.title}');
        sink.writeln('DESCRIPTION:${activity.description}');
        sink.writeln(
            'DTSTART:${_formatDateTime(startDate)}'); // Usar la nueva lógica
        sink.writeln(
            'DTEND:${_formatDateTime(endDate)}'); // Usar la nueva lógica
        sink.writeln('LOCATION:${activity.area}');
        sink.writeln('STATUS:CONFIRMED');
        sink.writeln('END:VEVENT');
      }

      sink.writeln('END:VCALENDAR');

      await sink.flush();
      await sink.close();

      print("Archivo exportado en: $filePath");
      return filePath;
    } catch (e) {
      print("Error al exportar archivo .vcf: $e");
      return null;
    }
  }

  /// Formatear fecha para vCard (ejemplo: 20231120T100000Z)
  String _formatDateTime(DateTime dateTime) {
    // Utilizar la hora local directamente
    return '${dateTime.year}${_pad(dateTime.month)}${_pad(dateTime.day)}T${_pad(dateTime.hour)}${_pad(dateTime.minute)}00';
  }

  String _pad(int number) {
    return number.toString().padLeft(2, '0');
  }
}
