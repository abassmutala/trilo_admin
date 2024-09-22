import 'package:flutter/material.dart';
import 'package:trilo_admin/views/dashboard/home.dart';
import 'package:trilo_admin/views/dashboard/view_stores.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 2;

  final List<Map<String, dynamic>> bottomNavItems = [
    {
      "icon": Icons.home_outlined,
      "title": "Home",
      "widget": const Home(),
    },
    {
      "icon": Icons.calendar_month_outlined,
      "title": "Calendar",
      "widget": const Home(),
    },
    {
      "icon": Icons.store_outlined,
      "title": "Stores",
      "widget": const ViewStores(),
    },
    {
      "icon": Icons.home_outlined,
      "title": "Home",
      "widget": const Home(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomNavItems[_currentIndex]["widget"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (idx) {
          setState(() {
            _currentIndex = idx;
          });
        },
        items: bottomNavItems
            .map(
              (e) => BottomNavigationBarItem(
                  icon: Icon(e["icon"]), label: e["title"]),
            )
            .toList(),
      ),
    );
  }
}
