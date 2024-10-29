import 'package:diary_app/domain/entities/appointment.dart';
import 'package:diary_app/presentation/buttons/buttons.dart';
import 'package:diary_app/presentation/buttons/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Planificación de hoy"),
        actions: const  [
          CalendarButton(),
          FilterButton(),

        ],
      ),
      body: 
          const _HomeView(),

    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();
  
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return _CustomListTile(appointment: appointment);
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    
    return ListTile(
      leading: Icon(appointment.icon, color: colors.primary,),
      trailing: SizedBox(
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(appointment.time, style: textStyle.titleMedium,),
            Icon(Icons.arrow_forward_ios_rounded, color: colors.primary,)
          ],
        ),
      ),
      title: Text(appointment.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appointment.subtitle),
          Text(appointment.patientName),
        ],
      ),
      onTap: (){
        context.push('/appointment/${appointment.link}');
      },  
    );
  }
}