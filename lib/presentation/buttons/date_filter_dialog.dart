import 'package:flutter/material.dart';
import 'custom_date_range_picker.dart'; // Asegúrate de importar el CustomDateRangePicker

class DateFilterDialog extends StatefulWidget {
  final String currentFilter;
  final DateTimeRange? selectedDateRange;
  final ValueChanged<String> onFilterSelected;
  final ValueChanged<DateTimeRange?> onDateRangeSelected;

  const DateFilterDialog({
    super.key,
    required this.currentFilter,
    required this.selectedDateRange,
    required this.onFilterSelected,
    required this.onDateRangeSelected,
  });

  @override
  DateFilterDialogState createState() => DateFilterDialogState();
}

class DateFilterDialogState extends State<DateFilterDialog> {
  late String temporaryFilter; // Estado temporal del filtro
  DateTimeRange? temporaryDateRange; // Estado temporal para el rango de fechas

  @override
  void initState() {
    super.initState();
    temporaryFilter = widget.currentFilter; // Inicializa con el filtro actual
    temporaryDateRange = widget.selectedDateRange; // Inicializa con el rango actual
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Selecciona el filtro',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFilterOption('Hoy'),
          const Divider(),
          _buildFilterOption('Semana'),
          const Divider(),
          ListTile(
            title: const Text('Rango de fechas'),
            leading: Radio<String>(
              value: 'Rango de fechas',
              groupValue: temporaryFilter,
              onChanged: (value) async {
                final pickedRange = await CustomDateRangePicker.show(
                  context: context,
                  initialDateRange: temporaryDateRange,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2101),
                );
                if (pickedRange != null) {
                  setState(() {
                    temporaryFilter = 'Rango de fechas';
                    temporaryDateRange = pickedRange;
                  });
                }
              },
            ),
            trailing: temporaryDateRange != null
                ? Text(
                    '${temporaryDateRange!.start.day}/${temporaryDateRange!.start.month} - ${temporaryDateRange!.end.day}/${temporaryDateRange!.end.month}',
                  )
                : null,
            onTap: () async {
              final pickedRange = await CustomDateRangePicker.show(
                context: context,
                initialDateRange: temporaryDateRange,
                firstDate: DateTime(2020),
                lastDate: DateTime(2101),
              );
              if (pickedRange != null) {
                setState(() {
                  temporaryFilter = 'Rango de fechas';
                  temporaryDateRange = pickedRange;
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Cierra el diálogo sin aplicar cambios
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onFilterSelected(temporaryFilter); // Aplica el filtro
            if (temporaryFilter == 'Rango de fechas') {
              widget.onDateRangeSelected(temporaryDateRange); // Aplica el rango de fechas
            }
            Navigator.pop(context); // Cierra el diálogo
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }

  Widget _buildFilterOption(String label) {
    return ListTile(
      title: Text(label),
      leading: Radio<String>(
        value: label,
        groupValue: temporaryFilter,
        onChanged: (value) {
          setState(() {
            temporaryFilter = value!;
          });
        },
      ),
      onTap: () {
        setState(() {
          temporaryFilter = label;
        });
      },
    );
  }
}
