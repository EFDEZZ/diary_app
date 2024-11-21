import 'package:diary_app/widgets/widgets.dart';
import 'package:flutter/material.dart';


class DateFilterButton extends StatelessWidget {
  final String currentFilter;
  final DateTimeRange? selectedDateRange;
  final ValueChanged<String> onFilterSelected;
  final ValueChanged<DateTimeRange?> onDateRangeSelected;

  const DateFilterButton({
    super.key,
    required this.currentFilter,
    required this.selectedDateRange,
    required this.onFilterSelected,
    required this.onDateRangeSelected,
  });

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecciona el filtro',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.today, color: Colors.blue),
                title: const Text('Hoy'),
                onTap: () {
                  Navigator.pop(context);
                  onFilterSelected('Hoy');
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_view_week, color: Colors.orange),
                title: const Text('Semana'),
                onTap: () {
                  Navigator.pop(context);
                  onFilterSelected('Semana');
                },
              ),
              ListTile(
                leading: const Icon(Icons.date_range, color: Colors.green),
                title: const Text('Rango de fechas'),
                trailing: selectedDateRange != null
                    ? Text(
                        '${selectedDateRange!.start.day}/${selectedDateRange!.start.month} - ${selectedDateRange!.end.day}/${selectedDateRange!.end.month}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.black54,
                            ),
                      )
                    : null,
                onTap: () async {
                  final pickedRange = await CustomDateRangePicker.show(
                    context: context,
                    initialDateRange: selectedDateRange,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101),
                  );
                  if (pickedRange != null) {
                    Navigator.pop(context);
                    onFilterSelected('Rango de fechas');
                    onDateRangeSelected(pickedRange);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_list, size: 20, color: Colors.black54),
      tooltip: 'Filtrar actividades',
      onPressed: () {
        _showFilterOptions(context);
      },
    );
  }
}
