import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:diary_app/common/db/database.dart';
import 'package:diary_app/presentation/buttons/buttons.dart';
import 'package:diary_app/presentation/buttons/filter_button.dart';
import 'package:diary_app/domain/entities/activity.dart';
import 'package:diary_app/infrastructure/mappers/activity_mapper.dart'; 

class HomeScreen extends StatefulWidget {
  final AppDatabase database;

  const HomeScreen({super.key, required this.database});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planificación de hoy"),
        actions: const [
          CalendarButton(),
          FilterButton(),
        ],
      ),
      body: _HomeView(database: widget.database),
    );
  }
}

class _HomeView extends StatelessWidget {
  final AppDatabase database;

  const _HomeView({required this.database});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ActivityDB>>(
      future: database.activityDao.getAllActivities(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay actividades disponibles'));
        } else {
          final activities = snapshot.data!
              .map((dbData) => ActivityMapper.activityDbToActivity(dbData))
              .toList();
          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return _CustomListTile(activity: activity);
            },
          );
        }
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.activity,
  });

  final Activity activity; // Uso de la clase Activity

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return ListTile(
      leading: Icon(Icons.calendar_today, color: colors.primary),
      trailing: SizedBox(
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(activity.time, style: textStyle.titleMedium),
            Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
          ],
        ),
      ),
      title: Text(activity.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(activity.subtitle),
          Text(activity.patientName),
        ],
      ),
      onTap: () {
        context.push('/activity/${activity.id}');
      },
    );
  }
}
