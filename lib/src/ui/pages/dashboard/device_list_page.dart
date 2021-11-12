import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:sea_demo01/src/ui/pages/alters/index.dart';
import 'package:sea_demo01/src/ui/pages/menu/index.dart';
import 'package:sea_demo01/src/ui/pages/reports/index.dart';
import 'package:sea_demo01/src/ui/pages/user/index.dart';

import 'index.dart';

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({Key? key}) : super(key: key);

  @override
  _DeviceListPageState createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
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
