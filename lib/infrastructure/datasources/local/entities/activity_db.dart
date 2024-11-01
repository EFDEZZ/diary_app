
import 'package:drift/drift.dart';


@DataClassName('Activity')
class ActivityDb extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get subtitle => text()();
  TextColumn get patientName => text()();
  TextColumn get description => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get time => text()();
  TextColumn get area => text()();
  TextColumn get consultType => text()();

  @override
  Set<Column> get primaryKey => {id};
}


