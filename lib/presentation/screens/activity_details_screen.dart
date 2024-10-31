import 'package:diary_app/domain/entities/activity.dart';
import 'package:flutter/material.dart';

class ActivityDetailsScreen extends StatelessWidget {
  final Activity activities;
  const ActivityDetailsScreen({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Detalles de la Cita"),
      ),
      body: _ActivityDetailView(
          activities: activities, textStyle: textStyle),
    );
  }
}

class _ActivityDetailView extends StatelessWidget {
  const _ActivityDetailView({
    required this.activities,
    required this.textStyle,
  });

  final Activity activities;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  activities.title,
                  style: textStyle.titleLarge,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Icon(Icons.text_snippet_rounded),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      activities.subtitle,
                      style: textStyle.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      activities.patientName,
                      style: textStyle.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    const Icon(Icons.date_range_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      activities.formattedmonth,
                      style: textStyle.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      activities.time,
                      style: textStyle.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 400,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Observaciones:",
                    style: textStyle.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    activities.description,
                    style: textStyle.bodyLarge,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          FilledButton.tonal(
              onPressed: () {},
              child: const SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_hospital),
                    SizedBox(
                      width: 5,
                    ),
                    Text("HCE del Paciente")
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
