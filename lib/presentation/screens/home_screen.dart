import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:diary_app/common/db/database.dart';
import 'package:diary_app/presentation/buttons/buttons.dart';
import 'package:diary_app/domain/entities/activity.dart';
import 'package:diary_app/infrastructure/mappers/activity_mapper.dart'; 


class HomeScreen extends StatefulWidget {
  final AppDatabase database;

  const HomeScreen({super.key, required this.database});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'Hoy'; // Filtro inicial
  DateTimeRange? selectedDateRange; // Rango de fechas seleccionado

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DateFilterDialog(
          currentFilter: selectedFilter,
          selectedDateRange: selectedDateRange,
          onFilterSelected: (filter) {
            setState(() {
              selectedFilter = filter;
            });
          },
          onDateRangeSelected: (dateRange) {
            setState(() {
              selectedDateRange = dateRange;
              selectedFilter = 'Rango de fechas'; // Cambia a "Rango de fechas"
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planificación de $selectedFilter"),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range_outlined),
            onPressed: _showFilterDialog, // Muestra el diálogo de filtro
          ),
          const FilterButton(),
        ],
      ),
      body: _HomeView(
        database: widget.database,
        filter: selectedFilter,
        dateRange: selectedDateRange,
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  final AppDatabase database;
  final String filter;
  final DateTimeRange? dateRange;

  const _HomeView({
    required this.database,
    required this.filter,
    required this.dateRange,
  });

  @override
  Widget build(BuildContext context) {
    Future<List<ActivityDB>> future;

    if (filter == 'Hoy') {
      future = database.activityDao.getAllActivitiesToday();
    } else if (filter == 'Semana') {
      future = database.activityDao.getAllActivitiesThisWeek();
    } else if (filter == 'Rango de fechas' && dateRange != null) {
      future = database.activityDao.getActivitiesInRange(dateRange!.start, dateRange!.end);
    } else {
      future = Future.value([]); // No hay actividades para mostrar
    }

    return FutureBuilder<List<ActivityDB>>(
      future: future,
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

  final Activity activity;

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
