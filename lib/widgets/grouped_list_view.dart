import 'package:diary_app/domain/entities/activity.dart';
import 'package:diary_app/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

Widget groupedListView(
    BuildContext context,
    List<Activity> activities,
    String Function(Activity) groupBy,
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
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 1.0,
                  color: Colors.teal.shade300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  child: Text(
                    key,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 1.0,
                  color: Colors.teal.shade300,
                ),
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
