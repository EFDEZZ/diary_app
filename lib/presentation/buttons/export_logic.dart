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
      return [];
    }
  }

/// Exportar actividades a un archivo .vcf en la carpeta Descargas
Future<String?> exportToVcf(List<Activity> activities) async {
  // Solicitar permisos de almacenamiento
  if (!await _requestStoragePermission()) {
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
    sink.writeln('TZID:America/Havana');

    for (var activity in activities) {
      // Combinar fecha de actividad con la hora almacenada en `time`
      final startDate = _combineDateAndTime(activity.date, activity.time);
      final endDate = startDate.add(const Duration(hours: 1)); // Duración predeterminada

      sink.writeln('BEGIN:VEVENT');
      sink.writeln('SUMMARY:${activity.title}');
      sink.writeln('DESCRIPTION:${activity.description}');
      sink.writeln('DTSTART;TZID=America/Havana:${_formatDateTime(startDate)}');
      sink.writeln('DTEND;TZID=America/Havana:${_formatDateTime(endDate)}');
      sink.writeln('LOCATION:${activity.area}');
      sink.writeln('STATUS:CONFIRMED');
      sink.writeln('END:VEVENT');
    }

    sink.writeln('END:VCALENDAR');

    await sink.flush();
    await sink.close();

    return filePath;
  } catch (e) {
    return null;
  }
}

/// Combina la fecha y la hora almacenadas como `String` para formar un objeto DateTime
DateTime _combineDateAndTime(DateTime date, String time) {
  try {
    final timeParts = time.split(' '); // Divide "10:00 AM" en ["10:00", "AM"]
    final hourMinute = timeParts[0].split(':'); // Divide "10:00" en ["10", "00"]
    int hour = int.parse(hourMinute[0]);
    final minute = int.parse(hourMinute[1]);

    // Ajusta la hora según AM/PM
    if (timeParts[1].toUpperCase() == 'PM' && hour != 12) {
      hour += 12;
    } else if (timeParts[1].toUpperCase() == 'AM' && hour == 12) {
      hour = 0;
    }

    // Combina la fecha y la hora
    return DateTime(date.year, date.month, date.day, hour, minute);
  } catch (e) {
    return date; // Devuelve solo la fecha si hay error
  }
}

/// Formatear fecha para vCard (ejemplo: 20241115T100000)
String _formatDateTime(DateTime dateTime) {
  return '${dateTime.year}${_pad(dateTime.month)}${_pad(dateTime.day)}T${_pad(dateTime.hour)}${_pad(dateTime.minute)}00';
}

String _pad(int number) {
  return number.toString().padLeft(2, '0');
}


}
