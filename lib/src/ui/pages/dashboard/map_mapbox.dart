import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:sea_demo01/src/controller/allship_controller.dart';
import 'package:sea_demo01/src/controller/user_controller.dart';
import 'package:sea_demo01/src/model/pin_pill_info.dart';
import 'package:sea_demo01/src/model/shipuser_model.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:sea_demo01/src/ui/compoment/map_pin_pill.dart';
import 'package:sea_demo01/src/ui/themes/path_files.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapBoxPage extends StatefulWidget {
  const MapBoxPage({Key? key}) : super(key: key);

  @override
  _MapBoxPageState createState() => _MapBoxPageState();
}

class _MapBoxPageState extends State<MapBoxPage> {
  InfoUserController infoUserController = Get.put(InfoUserController());
  AllShipController allShipController = Get.put(AllShipController());
  //AllShip _allShip = new AllShip();
  TextEditingController _searchControler = new TextEditingController();
  List<AllShipByUserId> arrayAPI = [];
  List<Marker> _markers = [];
  List<latLng.LatLng> polylineCoordinates = [];
  double pinPillPosition = -120;
  FilePath filePath = new FilePath();
  PinInformation currentlySelectedPin = PinInformation(
    pinPath: 'assets/icons/driving_pin.png',
    avatarPath: 'assets/images/friend1.jpg',
    location: latLng.LatLng(0, 0),
    vehicalNumber: 'Start Location',
    labelColor: Colors.grey,
    address: '',
    status: '',
    timeSave: '',
  );
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
                    searchMapPins();
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
                searchMapPins();
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
          ? Stack(
              children: <Widget>[
                FlutterMap(
                  options: MapOptions(
                    center: latLng.LatLng(10.7553411, 106.4150405),
                    zoom: 6,
                    onTap: (ctx, latLng.LatLng location) {
                      setState(() {
                        pinPillPosition = -120;
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      });
                    },
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate: dotenv.env['URL_MAPBOX'] ??
                            'MAPBOX not found'.toString(),
                        additionalOptions: {
                          'accessToken': dotenv.env['TOKEN_MAPBOX'] ??
                              'MAPBOX not found'.toString(),
                          'id': dotenv.env['ID_MAPBOX'] ??
                              'MAPBOX not found'.toString(),
                        }),
                    MarkerLayerOptions(markers: _markers),
                  ],
                ),
                MapPinPillComponent(
                    pinPillPosition: pinPillPosition,
                    currentlySelectedPin: currentlySelectedPin),
              ],
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
                    onTap: () {
                      _searchControler.text = foodList[index];
                      foodListSearch = [];
                      searchMapPins();
                    },
                  ),
                );
              }),
    );
  }

  @override
  void initState() {
    super.initState();
    getMarker();
  }
  
  void getMarker(){
    arrayAPI = allShipController.allShipByUserIdList;
    setState(() {
      setMapPins();
    });
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

  void setMapPins() async {
    _markers.clear();
    String _pinPath, _avatarPath, _address, _status;
    String? _urlMarker = '';
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
      AssetImage assetImage = AssetImage(_urlMarker);
      Marker resultMarker = Marker(
        width: 70.0,
        height: 70.0,
        point: latLng.LatLng(
            arrayAPI[i].latitude, arrayAPI[i].longitude),
        builder: (ctx) => Container(
            child: FlatButton(
          onPressed: () {
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
                location: latLng.LatLng(arrayAPI[i].latitude,
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
          child: Image(image: assetImage),
        )),
      );
      _markers.add(resultMarker);
    }
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _searchControler.dispose();
    super.dispose();
  }
}
