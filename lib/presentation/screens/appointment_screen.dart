import 'package:diary_app/domain/entities/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget {
  final Appointment  appointment;
  const AppointmentScreen({super.key, required this.appointment});

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
