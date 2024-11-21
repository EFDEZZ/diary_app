import 'package:diary_app/presentation/buttons/date_filter_button.dart';
import 'package:diary_app/presentation/buttons/export_button.dart'; // Importación del nuevo ExportLogic
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
  String selectedOrder = 'Ninguno'; // Orden predeterminado
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
              // Usar el botón de ordenamiento
              OrderButton(
                currentOrder: selectedOrder,
                onOrderChanged: (String newOrder) {
                  setState(() {
                    selectedOrder = newOrder;
                  });
                },
              ),
              const SizedBox(width: 6),
              // Nuevo botón para seleccionar filtros
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
              // Botón para exportar actividades, utilizando el nuevo ExportLogic como botón
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

          // Ordenar según el criterio seleccionado
          if (orderBy == 'Tipo de Consulta') {
            activities.sort((a, b) {
              int typeCompare = a.consultType.compareTo(b.consultType);
              if (typeCompare != 0) return typeCompare;

              int dateCompare = a.date.compareTo(b.date);
              if (dateCompare != 0) return dateCompare;

              return _compareTime(a.time, b.time);
            });
          } else if (orderBy == 'Área') {
            activities.sort((a, b) {
              int areaCompare = a.area.compareTo(b.area);
              if (areaCompare != 0) return areaCompare;

              int dateCompare = a.date.compareTo(b.date);
              if (dateCompare != 0) return dateCompare;

              return _compareTime(a.time, b.time);
            });
          } else {
            activities.sort((a, b) {
              int dateCompare = a.date.compareTo(b.date);
              if (dateCompare != 0) return dateCompare;

              return _compareTime(a.time, b.time);
            });
          }

          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return CustomListTile(activity: activity);
            },
          );
        }
      },
    );
  }

  int _compareTime(String timeA, String timeB) {
    final timeFormat = DateFormat('hh:mm a');
    DateTime dateTimeA = timeFormat.parse(timeA);
    DateTime dateTimeB = timeFormat.parse(timeB);
    return dateTimeA.compareTo(dateTimeB);
  }
}
