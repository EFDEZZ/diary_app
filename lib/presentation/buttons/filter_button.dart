import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedOption = 'Ordenar por Fecha';

    return IconButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona una opción'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children:[

                  RadioListTile<String>(
                    title: const Text('Ordenar por Fecha'),
                    value: 'Ordenar por Fecha',
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Ordenar por áreas'),
                    value: 'Ordenar por áreas',
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),

                  RadioListTile<String>(
                    title: const Text('Ordenar por consultas'),
                    value: 'Ordenar por consultas',
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),

                ],
              );
            },
          ),

          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          
        );
      },
    );
  },
  icon: const Icon(Icons.filter_list_rounded),
);

  }
}