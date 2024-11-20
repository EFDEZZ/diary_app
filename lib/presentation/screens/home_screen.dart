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
  String selectedFilter = 'Hoy';
  DateTimeRange? selectedDateRange;
  late   ExportLogic exportLogic;

  @override
  void initState() {
    super.initState();
    exportLogic = ExportLogic(widget.database);
  }
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
              selectedFilter = 'Rango de fechas'; 
            });
          },
        );
      },
    );
  }
  void _exportActivities() async {
  try {
    // Obtener las actividades filtradas
    final activities = await exportLogic.getFilteredActivities(
      selectedFilter: selectedFilter,
      selectedDateRange: selectedDateRange,
    );

    // Exportar a .vcf
    final filePath = await exportLogic.exportToVcf(activities);

    if (!mounted) return; // Asegúrate de que el widget sigue montado

    if (filePath != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo exportado a: $filePath')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al exportar el archivo.')),
      );
    }
  } catch (e) {
    if (!mounted) return; // Verifica que el widget sigue montado

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


@override
Widget build(BuildContext context) {

  return Scaffold(
    appBar: AppBar(
      elevation: 4,
      backgroundColor: const Color.fromARGB(255, 151, 200, 153),
      title: Row(
        children: [
          const Icon(Icons.calendar_month_outlined, color: Colors.black87),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              selectedFilter,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              overflow: TextOverflow.ellipsis,
              maxLines: 1, 
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: "Filtrar actividades",
          icon: const Icon(Icons.filter_list_outlined, color: Colors.black87,),
          onPressed: _showFilterDialog,
        ),
        IconButton(
          tooltip: "Exportar actividades",
          icon: const Icon(Icons.download_for_offline_outlined, color: Colors.black87),
          onPressed: _exportActivities,
        ),
      ],
    ),
    body: _HomeView(
      database: widget.database,
      filter: selectedFilter,
      dateRange: selectedDateRange,
      exportLogic: exportLogic,
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
    required this.dateRange, required ExportLogic exportLogic,
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            context.push('/activity/${activity.id}');
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: colors.primary.withOpacity(0.2),
                  radius: 24, 
                  child: Icon(Icons.event, color: colors.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        style: textStyle.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        activity.subtitle,
                        style: textStyle.bodyMedium?.copyWith(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Paciente: ${activity.patientName}",
                        style: textStyle.bodySmall?.copyWith(color: colors.secondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      activity.time,
                      style: textStyle.bodySmall?.copyWith(color: const Color.fromARGB(255, 94, 94, 94)),
                    ),
                    const SizedBox(height: 8),
                    Icon(Icons.arrow_forward_ios_rounded, color: colors.primary, size: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

