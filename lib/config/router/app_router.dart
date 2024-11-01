
import 'package:diary_app/domain/entities/activity.dart';
import 'package:diary_app/presentation/screens/activity_details_screen.dart';
import 'package:diary_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      ),
    // GoRoute(
    //   path: '/activity/:link',
    //   builder: (context, state) {
    //     final link = state.pathParameters['link']!;
    //     final activity = activities.firstWhere((appt) => appt.link == link);
    //     return ActivityDetailsScreen(activities: activity,);
    //   },
    //   ),
  ]
  );