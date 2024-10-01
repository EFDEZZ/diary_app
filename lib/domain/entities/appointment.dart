import 'package:flutter/material.dart';

class Appointment {
  final String title;
  final String subtitle;
  final String link;
  final String patientName;
  final String description;
  final String date;
  final IconData icon;

  Appointment({
    required this.date, 
    required this.title,
    required this.subtitle,
    required this.link,
    required this.patientName,
    required this.description,
    required this.icon
      });
}

// Codigo provisional (Solo para design)

List<Appointment> appointments = [
  Appointment(
      title: 'title',
      subtitle: 'subtitle',
      link: 'link1',
      date: '27/01/2024',
      patientName: 'patientName',
      description: 'description',
      icon: Icons.assignment_outlined),
  Appointment(
      title: 'title',
      subtitle: 'subtitle',
      link: 'link2',
      date: '27/01/2024',
      patientName: 'patientName',
      description: 'description',
      icon: Icons.assignment_outlined),
  Appointment(
      title: 'title',
      subtitle: 'subtitle',
      link: 'link3',
      date: '27/01/2024',
      patientName: 'patientName',
      description: 'description',
      icon: Icons.assignment_outlined),
  Appointment(
      title: 'title',
      subtitle: 'subtitle',
      link: 'link4',
      date: '27/01/2024',
      patientName: 'patientName',
      description: 'description',
      icon: Icons.assignment_outlined),
];
