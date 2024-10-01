import 'package:diary_app/domain/entities/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final Appointment  appointment;
  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(appointment.title),
            Text(appointment.patientName),
            Text(appointment.date),
            Text(appointment.description),
          ],
        ),
      ),
    );
  }
}
