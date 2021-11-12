import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:sea_demo01/src/ui/pages/alters/index.dart';
import 'package:sea_demo01/src/ui/pages/dashboard/map.dart';
import 'package:sea_demo01/src/ui/pages/menu/index.dart';
import 'package:sea_demo01/src/ui/pages/reports/index.dart';
import 'package:sea_demo01/src/ui/pages/user/index.dart';

class NavigatorCompoment extends StatefulWidget {
  const NavigatorCompoment({Key? key}) : super(key: key);

  @override
  _NavigatorCompomentState createState() => _NavigatorCompomentState();
}

class _NavigatorCompomentState extends State<NavigatorCompoment> {
  int currentTab = 0;
  final List<Widget> screens = [
    const AlterPage(),
    const ReportPage(),
    const MapPage(),
    const ProfilePage(),
    const MenuPage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const MapPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConvexAppBar(
        items: [
          TabItem(icon: Icons.notifications, title: 'Thông báo'),
          TabItem(icon: Icons.article, title: 'Báo cáo'),
          TabItem(icon: Icons.map, title: 'Giám sát'),
          TabItem(icon: Icons.people, title: 'Cá nhân'),
          TabItem(icon: Icons.more_horiz, title: 'Menu'),
        ],
        initialActiveIndex: 2, //optional, default as 0
        onTap: (int i) {
          setState(() {
            currentTab = i;
          });
        },
      ),
    );
  }
}
