import 'package:flutter/material.dart';

class CustomDateRangePicker extends StatefulWidget {
  final DateTimeRange? initialDateRange;
  final DateTime firstDate;
  final DateTime lastDate;

  const CustomDateRangePicker({
    super.key,
    required this.initialDateRange,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<CustomDateRangePicker> createState() => _CustomDateRangePickerState();

  static Future<DateTimeRange?> show({
    required BuildContext context,
    DateTimeRange? initialDateRange,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    return showDialog<DateTimeRange>(
      context: context,
      builder: (context) => CustomDateRangePicker(
        initialDateRange: initialDateRange,
        firstDate: firstDate,
        lastDate: lastDate,
      ),
    );
  }
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  late DateTimeRange temporaryRange;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    temporaryRange = widget.initialDateRange ??
        DateTimeRange(
          start: DateTime(today.year, today.month, today.day),
          end: DateTime(today.year, today.month, today.day + 1),
        );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Selecciona un rango de fechas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _DateSelector(
                  label: 'Desde',
                  date: temporaryRange.start,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: temporaryRange.start,
                      firstDate: widget.firstDate,
                      lastDate: widget.lastDate,
                    );
                    if (picked != null) {
                      setState(() {
                        if (picked.isAfter(temporaryRange.end)) {
                          temporaryRange = DateTimeRange(
                            start: picked,
                            end: picked,
                          );
                        } else {
                          temporaryRange = DateTimeRange(
                            start: picked,
                            end: temporaryRange.end,
                          );
                        }
                      });
                    }
                  },
                ),
                _DateSelector(
                  label: 'Hasta',
                  date: temporaryRange.end,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: temporaryRange.end,
                      firstDate: widget.firstDate,
                      lastDate: widget.lastDate,
                    );
                    if (picked != null) {
                      setState(() {
                        if (picked.isBefore(temporaryRange.start)) {
                          temporaryRange = DateTimeRange(
                            start: picked,
                            end: picked,
                          );
                        } else {
                          temporaryRange = DateTimeRange(
                            start: temporaryRange.start,
                            end: picked,
                          );
                        }
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cierra el diálogo sin devolver nada
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context, temporaryRange); // Devuelve el rango seleccionado
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DateSelector extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;

  const _DateSelector({
    required this.label,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
