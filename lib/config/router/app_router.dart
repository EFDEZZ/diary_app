import 'package:diary_app/domain/entities/activity.dart';
import 'package:diary_app/presentation/screens/activity_details_screen.dart';
import 'package:diary_app/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:diary_app/common/db/database.dart'; // Importa tu base de datos

final AppDatabase database = AppDatabase(); // Crea una instancia de la base de datos

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(database: database), // Pasa la instancia de la base de datos
    ),
    GoRoute(
      path: '/activity/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return FutureBuilder<ActivityDB?>(
          future: database.activityDao.getActivityById(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No se encontró la actividad.'));
            } else {
              final activity = Activity.fromDb(snapshot.data!);
              return ActivityDetailsScreen(activities: activity);
            }
          },
        );
      },
    ),
  ],
);
