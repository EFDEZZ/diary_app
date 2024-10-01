
import 'package:diary_app/domain/entities/appointment.dart';
import 'package:diary_app/presentation/screens/appointment_details_screen.dart';
import 'package:diary_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      ),
    GoRoute(
      path: '/appointment/:link',
      builder: (context, state) {
        final link = state.pathParameters['link']!;
        final appointment = appointments.firstWhere((appt) => appt.link == link);
        return AppointmentDetailsScreen(appointment: appointment,);
      },
      ),
  ]
  );