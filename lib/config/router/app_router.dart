import 'package:diary_app/presentation/screens/screens.dart';
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
    // GoRoute(
    //   path: '/activity/:link',
    //   builder: (context, state) {
    //     final link = state.pathParameters['link']!;
    //     final activity = activities.firstWhere((appt) => appt.link == link);
    //     return ActivityDetailsScreen(activities: activity,);
    //   },
    // ),
  ],
);
