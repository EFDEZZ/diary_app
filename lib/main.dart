import 'package:diary_app/common/db/database.dart';
import 'package:diary_app/config/router/app_router.dart';
import 'package:diary_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null);
  final database = AppDatabase();
  await insertHospitalActivities(database);
  runApp(const DiaryApp());
}


class DiaryApp extends StatelessWidget {
  const DiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
    );
  }
}

