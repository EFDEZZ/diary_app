import 'package:diary_app/common/db/database.dart';
import 'package:diary_app/domain/entities/activity.dart';

class ActivityMapper{
  static Activity activityDbToActivity(ActivityDB activityDb) => Activity(
    time: activityDb.time, 
    date: activityDb.date, 
    title: activityDb.title, 
    subtitle: activityDb.subtitle, 
    id: activityDb.id, 
    patientName: activityDb.patientName, 
    description: activityDb.description, 
    area: activityDb.area, 
    consultType: activityDb.consultType
    );
}
