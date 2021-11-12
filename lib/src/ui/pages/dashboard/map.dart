import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:sea_demo01/src/repositories/all_ship.dart';
import 'package:sea_demo01/src/repositories/search_model.dart';

import 'device_list_page.dart';
import 'map_google.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final controller = FloatingSearchBarController();
  int _index = 0;
  Widget appBarTitle = Text('Giám sát');
  Icon actionIcon = Icon(Icons.search);
  Choice _selectedChoice = choices[0];
  // marker
  final _allShip = new AllShip();
  MapGoogle mapGoogle = new MapGoogle();
  @override
  void initState() {
    super.initState();
    _allShip.getAllShipByUserId();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold (
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Nhập biển số xe',
              hintStyle: TextStyle(color: Colors.grey),
              icon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
            ),
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
               PopupMenuItem(
                child: FlatButton(
                  height: 50.0,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      mapGoogle.createState().setMapPins();
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.directions_boat, color: Colors.blue,),
                      Text("   Tất cả xe ("+_allShip.allShipByUserId.length.toString()+")",style: const TextStyle(color: Colors.blue,fontSize: 16),)
                    ],
                  )),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                child: FlatButton(
                  height: 50.0,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      mapGoogle.createState().setMapPins();
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.directions_boat, color: Colors.green,),
                      //_allShip.allShipByUserId.where((AllShipByUserId) => AllShipByUserId.statusID == 3).length.toString()
                      Text("   Đang chạy ("+_allShip.runingShipByUserId.length.toString()+")",style: const TextStyle(color: Colors.green,fontSize: 16),)
                    ],
                  )),
              ),
              PopupMenuItem(
                child: FlatButton(
                  height: 50.0,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      mapGoogle.createState().setMapPins();
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.directions_boat, color: Colors.black,),
                      Text("   Dừng ("+_allShip.allShipByUserId.where((AllShipByUserId) => AllShipByUserId.statusID > 3).length.toString()+")",style: const TextStyle(color: Colors.black,fontSize: 16),)
                    ],
                  )),
              ),
              PopupMenuItem(
                child: FlatButton(
                  height: 50.0,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      mapGoogle.createState().setMapPins();
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.directions_boat, color: Colors.red,),
                      Text("   Mất kết nối ("+_allShip.allShipByUserId.where((AllShipByUserId) => AllShipByUserId.statusID == 2).length.toString()+")",style: const TextStyle(color: Colors.red,fontSize: 16),)
                    ],
                  )),
              ),
              PopupMenuItem(
                child: FlatButton(
                  height: 50.0,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      mapGoogle.createState().setMapPins();
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.directions_boat, color: Colors.yellow,),
                      Text("   Mất GPS ("+_allShip.allShipByUserId.where((AllShipByUserId) => AllShipByUserId.latitude == 0 && AllShipByUserId.longitude == 0).length.toString()+")",style: const TextStyle(color: Colors.yellow,fontSize: 16),)
                    ],
                  )),
              ),
            ],
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: Container(
          width: 200,
        ),
      ),
      body: MapGoogle(),
    );
  }
  
  Widget buildSearchBar() {
    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.place),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Consumer<SearchModel>(
      builder: (context, model, _) => FloatingSearchBar(
        automaticallyImplyBackButton: false,
        controller: controller,
        clearQueryOnClose: true,
        hint: 'חיפוש...',
        iconColor: Colors.grey,
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOutCubic,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        actions: actions,
        progress: model.isLoading,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: model.onQueryChanged,
        scrollPadding: EdgeInsets.zero,
        transition: CircularFloatingSearchBarTransition(spacing: 16),
        isScrollControlled: true,
        builder: (context, _) => buildExpandableBody(model),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: const [
              Map(),
              SomeScrollableContent(),
              FloatingSearchAppBarExample(),
            ],
          ),
        ),
        // buildBottomNavigationBar(),
      ],
    );
  }

  Widget buildExpandableBody(SearchModel model) {
    return ListView.builder(
      itemCount: 200,
      itemBuilder: (context, index) {
        print('build $index');

        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            '$index',
          ),
        );
      },
    );
  }

  void choiceAction(Choice choice, BuildContext context) {
    setState(() {
      if (choice.title == 'Boat') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeviceListPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.directions_car),
  const Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const Choice(title: 'Boat', icon: Icons.directions_boat),
  const Choice(title: 'Bus', icon: Icons.directions_bus),
  const Choice(title: 'Train', icon: Icons.directions_railway),
  const Choice(title: 'Walk', icon: Icons.directions_walk),
];

class SomeScrollableContent extends StatelessWidget {
  const SomeScrollableContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBarScrollNotifier(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        itemCount: 100,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}

class FloatingSearchAppBarExample extends StatelessWidget {
  const FloatingSearchAppBarExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingSearchAppBar(
      title: const Text('Title'),
      transitionDuration: const Duration(milliseconds: 800),
      color: Colors.greenAccent.shade100,
      colorOnScroll: Colors.greenAccent.shade200,
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: 100,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}

class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        buildMap(),
      ],
    );
  }

  Widget buildMap() {
    return const MapGoogle();
  }
}
