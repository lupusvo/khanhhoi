import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'pages/alters/index.dart';
import 'pages/dashboard/map.dart';
import 'pages/menu/index.dart';
import 'pages/reports/index.dart';
import 'pages/user/profile_page.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  _ScreenMainState createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int currentTab = 2;
  final List<Widget> screens = [
    const AlterPage(),
    const ReportPage(),
    const MapPage(),
    const ProfilePage(),
    const MenuPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color(0xFF009688),
        items: [
          TabItem(icon: Icons.notifications, title: 'Thông báo'),
          TabItem(icon: Icons.article, title: 'Báo cáo'),
          TabItem(icon: Icons.map, title: 'Giám sát'),
          TabItem(icon: Icons.people, title: 'Cá nhân'),
          TabItem(icon: Icons.more_horiz, title: 'Menu'),
        ],
        initialActiveIndex: currentTab, //optional, default as 0
        onTap: (int i) {
          setState(() {
            currentTab = i;
          });
        },
      ),
      body: screens[currentTab],
    );
  }
}
