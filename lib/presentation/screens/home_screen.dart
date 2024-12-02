import 'package:diary_app/presentation/buttons/date_filter_button.dart';
import 'package:diary_app/presentation/buttons/export_button.dart';
import 'package:diary_app/presentation/buttons/order_button.dart';
import 'package:flutter/material.dart';
import 'package:diary_app/common/db/database.dart';
import 'package:diary_app/domain/entities/activity.dart';
import 'package:diary_app/infrastructure/mappers/activity_mapper.dart';
import 'package:intl/intl.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  final AppDatabase database;

  const HomeScreen({super.key, required this.database});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'Hoy';
  String selectedOrder = 'Ninguno';
  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(context),
      body: _HomeView(
        database: widget.database,
        filter: selectedFilter,
        dateRange: selectedDateRange,
        orderBy: selectedOrder,
      ),
    );
  }

  PreferredSizeWidget _buildCustomAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 151, 200, 153),
              Color.fromARGB(255, 100, 150, 100),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Row(
        children: [
          const Icon(
            Icons.calendar_month_outlined,
            color: Color.fromARGB(255, 0, 0, 0),
            size: 30,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              selectedFilter,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              OrderButton(
                currentOrder: selectedOrder,
                onOrderChanged: (String newOrder) {
                  setState(() {
                    selectedOrder = newOrder;
                  });
                },
              ),
              const SizedBox(width: 6),
              DateFilterButton(
                currentFilter: selectedFilter,
                selectedDateRange: selectedDateRange,
                onFilterSelected: (String newFilter) {
                  setState(() {
                    selectedFilter = newFilter;
                  });
                },
                onDateRangeSelected: (DateTimeRange? newRange) {
                  setState(() {
                    selectedDateRange = newRange;
                    if (newRange != null) {
                      selectedFilter = 'Rango de fechas';
                    }
                  });
                },
              ),
              const SizedBox(width: 6),
              ExportButton(
                database: widget.database,
                selectedFilter: selectedFilter,
                selectedDateRange: selectedDateRange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeView extends StatelessWidget {
  final AppDatabase database;
  final String filter;
  final String orderBy;
  final DateTimeRange? dateRange;

  const _HomeView({
    required this.database,
    required this.filter,
    required this.orderBy,
    this.dateRange,
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
          List<Activity> activities = snapshot.data!
              .map((dbData) => ActivityMapper.activityDbToActivity(dbData))
              .toList();

          if (orderBy == 'Tipo de Consulta') {
            return _buildGroupedListView(
              context,
              activities,
              (Activity a) => a.consultType,
              'Tipo de Consulta',
            );
          } else if (orderBy == 'Área') {
            return _buildGroupedListView(
              context,
              activities,
              (Activity a) => a.area,
              'Área',
            );
          } else if (filter == 'Semana' || filter == 'Rango de fechas') {
            return _buildGroupedListView(
              context,
              activities,
              (Activity a) => DateFormat('EEEE', 'es').format(a.date),
              '',
            );
          } else {
            activities.sort((a, b) {
              int dateCompare = a.date.compareTo(b.date);
              if (dateCompare != 0) return dateCompare;
              return _compareTime(a.time, b.time);
            });
            return ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return CustomListTile(activity: activity);
              },
            );
          }
        }
      },
    );
  }

  Widget _buildGroupedListView(
    BuildContext context,
    List<Activity> activities,
    String Function(Activity) groupBy,
    String groupType,
  ) {
    Map<String, List<Activity>> groupedActivities = {};

    for (var activity in activities) {
      final groupKey = groupBy(activity);
      groupedActivities.putIfAbsent(groupKey, () => []).add(activity);
    }

    List<Widget> groupedWidgets = [];
    groupedActivities.forEach((key, activities) {
      groupedWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Divider izquierdo
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: Divider(
                        thickness: 2.0,
                        color: Colors.teal.shade200.withOpacity(0.7),
                        endIndent: 8.0,
                        indent: 4.0,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (groupType.isNotEmpty)
                        Text(
                          groupType,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade900,
                              ),
                        ),
                      const SizedBox(height: 3.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 10.0),
                        child: Text(
                          key,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade700,
                              ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  // Divider derecho
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: Divider(
                        thickness: 2.0,
                        color: Colors.teal.shade200.withOpacity(0.7),
                        indent: 8.0,
                        endIndent: 4.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      for (var activity in activities) {
        groupedWidgets.add(CustomListTile(activity: activity));
      }
    });

    return ListView(children: groupedWidgets);
  }

  int _compareTime(String timeA, String timeB) {
    final timeFormat = DateFormat('hh:mm a');
    DateTime dateTimeA = timeFormat.parse(timeA);
    DateTime dateTimeB = timeFormat.parse(timeB);
    return dateTimeA.compareTo(dateTimeB);
  }
}
