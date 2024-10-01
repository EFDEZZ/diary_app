import 'package:diary_app/config/router/app_router.dart';
import 'package:diary_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const DiaryApp());

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
