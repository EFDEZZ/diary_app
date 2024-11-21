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
        elevation: 4,
        backgroundColor: const Color.fromARGB(255, 151, 200, 153),
        title: const Row(
          children: [
            Icon(Icons.event_note, color: Color.fromARGB(255, 17, 17, 17)),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                "Detalles de la Cita",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                icon: Icons.person,
                label: "Paciente: ${activities.patientName}",
                color: colors.primary,
              ),
              _DetailRow(
                icon: Icons.text_snippet_rounded,
                label: activities.subtitle,
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
              _DetailRow(
                icon: Icons.local_hospital_outlined,
                label: "Área: ${activities.area}",
                color: colors.secondary,
              ),
              _DetailRow(
                icon: Icons.check_circle_outline,
                label: "Tipo de Consulta: ${activities.consultType}",
                color: colors.secondary,
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
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.local_hospital, color: Colors.white),
              label: const Text("Ver HCE del Paciente", style: TextStyle(color: Colors.white, fontSize: 18),),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 121, 169, 123),
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyle.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 50, 75, 60),
              ),
            ),
            const SizedBox(height: 16),
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
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: textStyle.bodyLarge?.copyWith(
                color: const Color.fromARGB(255, 50, 75, 60),
                fontWeight: FontWeight.w500,
              ),
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyle.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 50, 75, 60),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: textStyle.bodyLarge?.copyWith(
                color: const Color.fromARGB(255, 80, 80, 80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
