// date_filter_dialog.dart
import 'package:flutter/material.dart';

class DateFilterDialog extends StatelessWidget {
  final String currentFilter;
  final DateTimeRange? selectedDateRange;
  final ValueChanged<String> onFilterSelected;
  final ValueChanged<DateTimeRange?> onDateRangeSelected;

  const DateFilterDialog({super.key, 
    required this.currentFilter,
    required this.selectedDateRange,
    required this.onFilterSelected,
    required this.onDateRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecciona el filtro'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Hoy'),
            leading: Radio<String>(
              value: 'Hoy',
              groupValue: currentFilter,
              onChanged: (value) {
                onFilterSelected(value!); // Cambia el filtro a "Hoy"
                Navigator.pop(context);
              },
            ),
          ),
          ListTile(
            title: const Text('Semana'),
            leading: Radio<String>(
              value: 'Semana',
              groupValue: currentFilter,
              onChanged: (value) {
                onFilterSelected(value!); // Cambia el filtro a "Semana"
                Navigator.pop(context);
              },
            ),
          ),
          ListTile(
            title: const Text('Rango de fechas'),
            leading: Radio<String>(
              value: 'Rango de fechas',
              groupValue: currentFilter,
              onChanged: (value) async {
                onFilterSelected(value!); // Cambia el filtro a "Rango de fechas"
                Navigator.pop(context);
                // Abre el selector de fechas
                final pickedRange = await showDateRangePicker(
                  context: context,
                  initialDateRange: selectedDateRange,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2101),
                );
                if (pickedRange != null) {
                  onDateRangeSelected(pickedRange); // Selección de fechas
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
