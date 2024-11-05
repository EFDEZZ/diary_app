import 'package:diary_app/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:diary_app/common/db/database.dart';
import 'package:diary_app/infrastructure/mappers/activity_mapper.dart'; 

final AppDatabase database = AppDatabase(); 

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(database: database), 
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
              final activity = ActivityMapper.activityDbToActivity(snapshot.data!);
              return ActivityDetailsScreen(activities: activity);
            }
          },
        );
      },
    ),
  ],
);
