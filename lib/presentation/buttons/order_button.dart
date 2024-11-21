import 'package:flutter/material.dart';

class OrderButton extends StatelessWidget {
  final String currentOrder;
  final ValueChanged<String> onOrderChanged;

  const OrderButton({
    super.key,
    required this.currentOrder,
    required this.onOrderChanged,
  });

  void _showOrderOptions(BuildContext context) {
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
                'Ordenar por',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.clear, color: Colors.black54),
                title: const Text('Ninguno'),
                onTap: () {
                  Navigator.pop(context);
                  onOrderChanged('Ninguno');
                },
              ),
              ListTile(
                leading: const Icon(Icons.category, color: Colors.teal),
                title: const Text('Tipo de Consulta'),
                onTap: () {
                  Navigator.pop(context);
                  onOrderChanged('Tipo de Consulta');
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_city, color: Colors.green),
                title: const Text('Área'),
                onTap: () {
                  Navigator.pop(context);
                  onOrderChanged('Área');
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
      icon: const Icon(Icons.sort, size: 20, color: Color.fromARGB(255, 0, 0, 0)),
      tooltip: 'Ordenar actividades',
      onPressed: () {
        _showOrderOptions(context);
      },
    );
  }
}
