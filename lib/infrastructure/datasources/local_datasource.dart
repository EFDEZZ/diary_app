import 'package:diary_app/domain/datasources/activities_datasource.dart';
import 'package:diary_app/domain/entities/activity.dart';
import 'package:diary_app/domain/entities/electronic_medical_record.dart';

class LocalDatasource extends ActivitiesDatasource{
  @override
  Future<ElectronicMedicalRecord> accessPatientHCE(int patientId) {
    // TODO: implement accessPatientHCE
    throw UnimplementedError();
  }

  @override
  Future<String> exportPlanningToVCF() {
    // TODO: implement exportPlanningToVCF
    throw UnimplementedError();
  }

  @override
  Future<List<Activity>> filterPlanning({String? area, String? consultationType, DateTime? date}) {
    // TODO: implement filterPlanning
    throw UnimplementedError();
  }

  @override
  Future<List<Activity>> listActivitiesByDateRange(DateTime startDate, DateTime endDate) {
    // TODO: implement listActivitiesByDateRange
    throw UnimplementedError();
  }

  @override
  Future<List<Activity>> listDailyActivities() {
    // TODO: implement listDailyActivities
    throw UnimplementedError();
  }

  @override
  Future<List<Activity>> listWeeklyActivities() {
    // TODO: implement listWeeklyActivities
    throw UnimplementedError();
  }

  @override
  Future<Activity> viewActivityDetails(int activityId) {
    // TODO: implement viewActivityDetails
    throw UnimplementedError();
  }

}