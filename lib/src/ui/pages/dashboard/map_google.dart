import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:sea_demo01/src/controller/allship_controller.dart';
import 'package:sea_demo01/src/controller/user_controller.dart';
import 'package:sea_demo01/src/model/shipuser_model.dart';
import 'package:sea_demo01/src/model/pin_pill_info.dart';
import 'package:sea_demo01/src/repositories/search_model.dart';
import 'package:sea_demo01/src/ui/compoment/map_pin_pill.dart';
import 'package:sea_demo01/src/ui/pages/dashboard/map_mapbox.dart';
import 'package:sea_demo01/src/ui/themes/path_files.dart';
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
  InfoUserController infoUserController = Get.put(InfoUserController());
  AllShipController allShipController = Get.put(AllShipController());
  Completer<GoogleMapController> _controller = Completer();
  List<AllShipByUserId> arrayAPI = [];
  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  MapBoxPage _mapBoxPage = new MapBoxPage();
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey =
      dotenv.env['KEY_APIGOOGLE'] ?? 'MAP GOOGLE not found'.toString();
  double pinPillPosition = -120;
  PinInformation currentlySelectedPin =
      MapBoxPage().createState().currentlySelectedPin;
  CameraPosition initialLocation = const CameraPosition(
      zoom: 5.5, bearing: 0, tilt: 0, target: LatLng(10.7553411, 106.4150405));
  TextEditingController _searchControler = new TextEditingController();
  //search
  List<String> foodList = [];
  List<String>? foodListSearch = [];
  final FocusNode _textFocusNode = FocusNode();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                })),
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
                foodList = allShipController.shipList;
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
                        arrayAPI = allShipController.allShipByUserIdList;
                        setMapPins();
                        Navigator.pop(context);
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
                              arrayAPI.length.toString() +
                              ")",
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 16),
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
                        arrayAPI = allShipController.runingShipByUserId;
                        setMapPins();
                        Navigator.pop(context);
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
                              allShipController.allShipByUserIdList
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
                        arrayAPI = allShipController.pauseShipByUserId;
                        setMapPins();
                        Navigator.pop(context);
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
                              allShipController.allShipByUserIdList
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
                        arrayAPI = allShipController.disShipByUserId;
                        setMapPins();
                        Navigator.pop(context);
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
                              allShipController.allShipByUserIdList
                                  .where((AllShipByUserId) =>
                                      AllShipByUserId.statusID == 2)
                                  .length
                                  .toString() +
                              ")",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
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
                        arrayAPI = allShipController.gpsShipByUserId;
                        setMapPins();
                        Navigator.pop(context);
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
                              allShipController.allShipByUserIdList
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
      body: foodListSearch!.isEmpty
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
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    //_mapBoxPage.createState().handleKeybroad();
                  });
                },
              ),
              MapPinPillComponent(
              pinPillPosition: pinPillPosition,
              currentlySelectedPin: currentlySelectedPin),
            ])
          :ListView.builder(
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
                    onTap: () {
                      setState(() {
                        _searchControler.text = foodList[index];
                        foodListSearch = [];
                        searchMapPins();
                      });
                    },
                  ),
                );
              }),
    );
  }

  void searchMapPins() async {
    arrayAPI = allShipController.allShipByUserIdList;
    List<AllShipByUserId> shipByUserId = [];
    for (int i = 0; i < arrayAPI.length; i++) {
      if (arrayAPI[i].tentau == _searchControler.text.toUpperCase()) {
        shipByUserId.add(arrayAPI[i]);
      }
    }
    if (shipByUserId.length > 0) {
      arrayAPI = shipByUserId;
      SmartDialog.showLoading(
        backDismiss: false,
        msg: "đang tải",
      );
      await Future.delayed(const Duration(seconds: 1));
      SmartDialog.dismiss();
      setState(() {
        _searchControler.text = "";
        pinPillPosition = -120;
        setMapPins();
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      });
    }
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

  void onMapCreated(controller){
    _controller.complete(controller);
    getMarker();
  }

  void getMarker() {
    arrayAPI = allShipController.allShipByUserIdList;
    setState(() {
      setMapPins();
    });
  }

  void setMapPins() async {
    _markers.clear();
    FilePath filePath = new FilePath();
    String _pinPath, _avatarPath, _address, _status;
    String _urlMarker = '';
    late Color _labelColor;
    for (int i = 0; i < arrayAPI.length; i++) {
      if (arrayAPI[i].statusID == 3) {
        _urlMarker = filePath.boatGreens;
      } else if (arrayAPI[i].statusID == 2) {
        _urlMarker = filePath.boatRed;
      } else if (arrayAPI[i].statusID > 3) {
        _urlMarker = filePath.boatBlack;
      } else if (arrayAPI[i].latitude == 0 &&
          arrayAPI[i].longitude == 0) {
        _urlMarker = filePath.boatYellow;
      } else {
        _urlMarker = filePath.boatNoActive;
      }
      Marker resultMarker = Marker(
          markerId: MarkerId(arrayAPI[i].imei),
          position: LatLng(
              arrayAPI[i].latitude, arrayAPI[i].longitude),
          onTap: () {
            setState(() {
              if (arrayAPI[i].statusID == 3) {
                _pinPath = filePath.boatGreens;
                _avatarPath = filePath.personOne;
                _labelColor = Colors.greenAccent;
                _status = 'Đang hoạt động';
              } else if (arrayAPI[i].statusID == 2) {
                _pinPath = filePath.boatRed;
                _avatarPath = filePath.personOne;
                _labelColor = Colors.redAccent;
                _status = 'Mất tính hiệu';
              } else if (arrayAPI[i].statusID > 3) {
                _pinPath = filePath.boatBlack;
                _avatarPath = filePath.personOne;
                _labelColor = Colors.black;
                _status = 'Dừng';
              } else if (arrayAPI[i].latitude == 0 &&
                  arrayAPI[i].longitude == 0) {
                _pinPath = filePath.boatYellow;
                _avatarPath = filePath.personOne;
                _labelColor = Colors.red;
                _status = 'Mất tính hiệu GPS';
              } else {
                _pinPath = filePath.boatNoActive;
                _avatarPath = filePath.personTwo;
                _labelColor = Colors.purple;
                _status = 'Chưa kích hoạt';
              }
              currentlySelectedPin = PinInformation(
                vehicalNumber: arrayAPI[i].tentau,
                location: LatLng(arrayAPI[i].latitude,
                    arrayAPI[i].longitude),
                pinPath: _pinPath,
                avatarPath: _avatarPath,
                labelColor: _labelColor,
                address: "",
                status: _status,
                timeSave: arrayAPI[i].dateSave.replaceAll('T', ' | '),
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
