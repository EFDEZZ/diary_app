import 'package:diary_app/domain/entities/activity.dart';
import 'package:flutter/material.dart';

class ActivityDetailsScreen extends StatelessWidget {
  final Activity activities;

  const ActivityDetailsScreen({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 151, 200, 153),
        title:  const Text("Detalles de la Cita", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: _ActivityDetailView(
        activities: activities,
        textStyle: textStyle,
        colors: colors,
      ),
    );
  }
}

class _ActivityDetailView extends StatelessWidget {
  final Activity activities;
  final TextTheme textStyle;
  final ColorScheme colors;

  const _ActivityDetailView({
    required this.activities,
    required this.textStyle,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoCard(
            title: activities.title,
            details: [
              _DetailRow(
                icon: Icons.text_snippet_rounded,
                label: activities.subtitle,
                color: colors.primary,
              ),
              _DetailRow(
                icon: Icons.person,
                label: activities.patientName,
                color: colors.primary,
              ),
              _DetailRow(
                icon: Icons.date_range_outlined,
                label: activities.formattedmonth,
                color: colors.primary,
              ),
              _DetailRow(
                icon: Icons.timer_outlined,
                label: activities.time,
                color: colors.primary,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _DescriptionCard(
            title: "Observaciones:",
            description: activities.description,
            textStyle: textStyle,
          ),
          const SizedBox(height: 20),
          Center(
            child: FilledButton.tonal(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_hospital),
                  SizedBox(width: 5),
                  Text("HCE del Paciente"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> details;

  const _InfoCard({
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textStyle.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            ...details,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: textStyle.bodyLarge,
              maxLines: 2, 
              overflow: TextOverflow.ellipsis, 
            ),
          ),
        ],
      ),
    );
  }
}


class _DescriptionCard extends StatelessWidget {
  final String title;
  final String description;
  final TextTheme textStyle;

  const _DescriptionCard({
    required this.title,
    required this.description,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textStyle.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
              width: double.infinity,
              ),
            Text(description, style: textStyle.bodyLarge),
          ],
        ),
      ),
    );
  }
}
