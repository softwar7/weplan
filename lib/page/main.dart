import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_timetable/flutter_timetable.dart';

class Time {
  final DateTime start;
  final DateTime end;

  Time(this.start, this.end);
  factory Time.random() {
    var now = DateTime.now();
    var randomHour = Random().nextInt(168);
    var randomDuration = Duration(
      hours: randomHour,
    );
    var randomTime = now.add(randomDuration);
    return Time(randomTime, randomTime.add(const Duration(hours: 1)));
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final controller = TimetableController(
    timelineWidth: 70,
    initialColumns: 7,
  );

  var times = [
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
    Time.random(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      drawer: NavigationDrawer(
        children: [
          DrawerHeader(
            child: Container(
              child: const Column(
                children: [
                  Text(
                    'WePlan',
                    style: TextStyle(
                      fontSize: 30,
                      // color: Colors.white,
                    ),
                  ),
                  Text('Hello World'),
                ],
              ),
            ),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.room),
            label: Text('Room'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.tv),
            label: Text('Home'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.boy),
            label: Text('Home'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      body: Timetable(
        controller: controller,
        nowIndicatorColor: Colors.red,
        cellBuilder: (datetime) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0.1),
            ),
          );
        },
        itemBuilder: (item) => Container(
          decoration: BoxDecoration(
            color: Color(Random().nextInt(0xffffffff)),
            // color: Colors.pink,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              item.data ?? '',
            ),
          ),
        ),
        items: times.map((time) {
          return TimetableItem(
            time.start,
            time.end,
            data: 'Random',
          );
        }).toList(),
      ),
    );
  }
}
