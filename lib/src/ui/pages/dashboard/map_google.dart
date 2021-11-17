import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:sea_demo01/src/repositories/all_ship.dart';
import 'package:sea_demo01/src/model/pin_pill_info.dart';
import 'package:sea_demo01/src/repositories/search_model.dart';
import 'package:sea_demo01/src/ui/compoment/map_pin_pill.dart';
import 'package:sea_demo01/src/ui/pages/dashboard/map_mapbox.dart';
import 'device_list_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final fsbController = FloatingSearchBarController();
  int _index = 0;
  Widget appBarTitle = Text('Giám sát');
  Icon actionIcon = Icon(Icons.search);
  Choice _selectedChoice = choices[0];
  // marker
  AllShip _allShip = new AllShip();
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  MapBoxPage _mapBoxPage = new  MapBoxPage();
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = 'AIzaSyDO5GoIsghz2hD3oi3CuhDxNgKuN3Gz7KE';
  double pinPillPosition = -120;
  PinInformation currentlySelectedPin = MapBoxPage().createState().currentlySelectedPin;
  CameraPosition initialLocation = const CameraPosition(
      zoom: 5.5,
      bearing: 0,
      tilt: 0,
      target: LatLng(10.7553411,106.4150405));
  TextEditingController _searchControler = new TextEditingController();
  //search
  List<String> foodList = [];
  List<String>? foodListSearch =[];
  final FocusNode _textFocusNode = FocusNode();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Visibility(
            visible: isVisible,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                setState(() {
                  isVisible = false;
                  _searchControler.text = "";
                  foodListSearch = [];
                  _mapBoxPage.createState().searchMapPins();
                });
              })
          ),
          title: Container(
            width: 300,
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextField(
              controller: _searchControler,
              focusNode: _textFocusNode,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Biển số tàu cần tìm...',
                  contentPadding: EdgeInsets.all(8)),
              onChanged: (value) {
                setState(() {
                  foodList = _allShip.shipList;
                  
                  foodListSearch = foodList
                      .where((element) => element.contains(value.toLowerCase()))
                      .toList();
                  if (_searchControler.text.isNotEmpty &&
                      foodListSearch!.length == 0) {
                        isVisible = true;
                        print('foodListSearch length ${foodListSearch!.length}');
                  }
                });
              },
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  foodListSearch = [];
                  _mapBoxPage.createState().searchMapPins();
                });
              },
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  child: FlatButton(
                      height: 50.0,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          pinPillPosition = -120;
                          _allShip.arrayAPI = _allShip.allShipByUserId;
                          setMapPins();
                          _mapBoxPage.createState().handleTap();
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.directions_boat,
                            color: Colors.blue,
                          ),
                          Text(
                            "   Tất cả xe (" +
                                _allShip.allShipByUserId.length.toString() +
                                ")",
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 16),
                          )
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
                          pinPillPosition = -120;
                          _allShip.arrayAPI = _allShip.runingShipByUserId;
                          setMapPins();
                          _mapBoxPage.createState().handleTap();
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.directions_boat,
                            color: Colors.green,
                          ),
                          Text(
                            "   Đang chạy (" +
                                _allShip.allShipByUserId
                                    .where((AllShipByUserId) =>
                                        AllShipByUserId.statusID == 3)
                                    .length
                                    .toString() +
                                ")",
                            style: const TextStyle(
                                color: Colors.green, fontSize: 16),
                          )
                        ],
                      )),
                ),
                PopupMenuItem(
                  child: FlatButton(
                      height: 50.0,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          pinPillPosition = -120;
                          _allShip.arrayAPI = _allShip.pauseShipByUserId;
                          setMapPins();
                          _mapBoxPage.createState().handleTap();
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.directions_boat,
                            color: Colors.black,
                          ),
                          Text(
                            "   Dừng (" +
                                _allShip.allShipByUserId
                                    .where((AllShipByUserId) =>
                                        AllShipByUserId.statusID > 3)
                                    .length
                                    .toString() +
                                ")",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          )
                        ],
                      )),
                ),
                PopupMenuItem(
                  child: FlatButton(
                      height: 50.0,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          pinPillPosition = -120;
                          _allShip.arrayAPI = _allShip.disShipByUserId;
                          setMapPins();
                          _mapBoxPage.createState().handleTap();
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.directions_boat,
                            color: Colors.red,
                          ),
                          Text(
                            "   Mất kết nối (" +
                                _allShip.allShipByUserId
                                    .where((AllShipByUserId) =>
                                        AllShipByUserId.statusID == 2)
                                    .length
                                    .toString() +
                                ")",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          )
                        ],
                      )),
                ),
                PopupMenuItem(
                  child: FlatButton(
                      height: 50.0,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          pinPillPosition = -120;
                          _allShip.arrayAPI = _allShip.gpsShipByUserId;
                          setMapPins();
                          _mapBoxPage.createState().handleTap();
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.directions_boat,
                            color: Colors.yellow,
                          ),
                          Text(
                            "   Mất GPS (" +
                                _allShip.allShipByUserId
                                    .where((AllShipByUserId) =>
                                        AllShipByUserId.latitude == 0 &&
                                        AllShipByUserId.longitude == 0)
                                    .length
                                    .toString() +
                                ")",
                            style: const TextStyle(
                                color: Colors.yellow, fontSize: 16),
                          )
                        ],
                      )),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  child: FlatButton(
                      height: 50.0,
                      color: Colors.white,
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("Đăng xuất",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                content: const Text(
                                    "Bạn có chắc chắn muốn đăng xuất không?"),
                                actions: [
                                  FlatButton(
                                    child: const Text("Không",
                                        style: TextStyle(color: Colors.blue)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    child: const Text("Có",
                                        style: TextStyle(color: Colors.blue)),
                                    onPressed: () {
                                      _mapBoxPage.createState().clearData();
                                    },
                                  )
                                ],
                                elevation: 24.0,
                              )),
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.blueGrey,
                          ),
                          Text(
                            "Thoát",
                            style: const TextStyle(
                                color: Colors.blueGrey, fontSize: 16),
                          )
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
        body: foodListSearch!.length == 0
            ? Stack(children: <Widget>[
                GoogleMap(
                  myLocationEnabled: true,
                  compassEnabled: true,
                  tiltGesturesEnabled: false,
                  onMapCreated: onMapCreated,
                  markers: _markers,
                  polylines: _polylines,
                  mapType: MapType.normal,
                  initialCameraPosition: initialLocation,
                  onTap: (LatLng location) {
                    setState(() {
                      pinPillPosition = -120;
                      _mapBoxPage.createState().handleKeybroad();
                    });
                  },
                ),
                MapPinPillComponent(
                    pinPillPosition: pinPillPosition,
                    currentlySelectedPin: currentlySelectedPin),
              ]
            )
            : ListView.builder(
                itemCount: _searchControler.text.isNotEmpty
                    ? foodListSearch!.length
                    : foodList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(Icons.directions_boat),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(_searchControler.text.isNotEmpty
                              ? foodListSearch![index]
                              : foodList[index]),
                        ],
                      ),
                      onTap: (){
                        _searchControler.text = foodList[index];
                        foodListSearch = [];
                        _mapBoxPage.createState().searchMapPins();
                      },
                    ),
                  );
                }
              ),
      ),
      onWillPop: () async => false,
    );
  }

  setPolylines() async {
    /*PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
        PointLatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        Polyline polyline = Polyline(
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates);
        _polylines.add(polyline);
      });
    }*/
  }

  void onMapCreated(controller) {
    _controller.complete(controller);
    getMarker();
  }

  void getMarker() async {
    await _allShip.getAllShipByUserId();
    _allShip.arrayAPI = _allShip.allShipByUserId;
    setState(() {
      setMapPins();
    });
  }

  void setMapPins() async {
    _markers.clear();
    String _pinPath, _avatarPath, _address, _status;
    String _urlMarker = '';
    late Color _labelColor;
    for (int i = 0; i < _allShip.arrayAPI.length; i++) {
      if (_allShip.arrayAPI[i].statusID == 3) {
        _urlMarker = 'assets/icons/driving_boat_greens.png';
      } else if (_allShip.arrayAPI[i].statusID == 2) {
        _urlMarker = 'assets/icons/driving_boat_red.png';
      } else if (_allShip.arrayAPI[i].statusID > 3) {
        _urlMarker = 'assets/icons/driving_boat_black.png';
      } else if (_allShip.arrayAPI[i].latitude == 0 &&
          _allShip.arrayAPI[i].longitude == 0) {
        _urlMarker = "assets/icons/destination_map_marker.png";
      } else {
        _urlMarker = "assets/icons/destination_map_red.png";
      }
      Marker resultMarker = Marker(
          markerId: MarkerId(_allShip.arrayAPI[i].imei),
          position: LatLng(
              _allShip.arrayAPI[i].latitude, _allShip.arrayAPI[i].longitude),
          onTap: () {
            setState(() {
              if (_allShip.arrayAPI[i].statusID == 3) {
                _pinPath = "assets/icons/driving_boat_greens.png";
                _avatarPath = "assets/images/friend1.jpg";
                _labelColor = Colors.greenAccent;
                _status = 'Đang hoạt động';
              } else if (_allShip.arrayAPI[i].statusID == 2) {
                _pinPath = "assets/icons/driving_boat_red.png";
                _avatarPath = "assets/images/friend1.jpg";
                _labelColor = Colors.redAccent;
                _status = 'Mất tính hiệu';
              } else if (_allShip.arrayAPI[i].statusID > 3) {
                _pinPath = "assets/icons/driving_boat_black.png";
                _avatarPath = "assets/images/friend1.jpg";
                _labelColor = Colors.black;
                _status = 'Dừng';
              } else if (_allShip.arrayAPI[i].latitude == 0 &&
                  _allShip.arrayAPI[i].longitude == 0) {
                _pinPath = "assets/icons/destination_map_marker.png";
                _avatarPath = "assets/images/friend1.jpg";
                _labelColor = Colors.red;
                _status = 'Mất tính hiệu GPS';
              } else {
                _pinPath = "assets/icons/destination_map_red.png";
                _avatarPath = "assets/images/friend2.jpg";
                _labelColor = Colors.purple;
                _status = 'Chưa kích hoạt';
              }
              currentlySelectedPin = PinInformation(
                vehicalNumber: _allShip.arrayAPI[i].tentau,
                location: LatLng(_allShip.arrayAPI[i].latitude,
                    _allShip.arrayAPI[i].longitude),
                pinPath: _pinPath,
                avatarPath: _avatarPath,
                labelColor: _labelColor,
                address: "",
                status: _status,
                timeSave: _allShip.arrayAPI[i].dateSave.replaceAll('T', ' | '),
              );
              pinPillPosition = 0;
            });
          },
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(devicePixelRatio: 2.5), _urlMarker));
      // Add it to Set
      _markers.add(resultMarker);
    }
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
        controller: fsbController,
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
    fsbController.dispose();
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