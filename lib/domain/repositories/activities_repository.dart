import 'package:diary_app/domain/entities/activity.dart';
import 'package:diary_app/domain/entities/electronic_medical_record.dart';

abstract class ActivitiesRepository{

  Future<List<Activity>> listDailyActivities();
  Future<List<Activity>> listWeeklyActivities();
  Future<List<Activity>> listActivitiesByDateRange(DateTime startDate, DateTime endDate);
  Future<List<Activity>> filterPlanning({String? area, String? consultationType, DateTime? date});
  Future<Activity> viewActivityDetails(int activityId);
  Future<ElectronicMedicalRecord> accessPatientHCE(int patientId);
  Future<String> exportPlanningToVCF();

}