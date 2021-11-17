import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:sea_demo01/src/model/pin_pill_info.dart';
import 'package:sea_demo01/src/model/shipuser_model.dart';
import 'package:sea_demo01/src/repositories/all_ship.dart';
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
  AllShip _allShip = new AllShip();
  TextEditingController _searchControler = new TextEditingController();
  List<Marker> _markers = [];
  List<latLng.LatLng> polylineCoordinates = [];
  double pinPillPosition = -120;
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
                  searchMapPins();
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
            /*TextFormField(
                style: const TextStyle(fontSize: 20, color: Colors.black),
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (Value) {
                  searchMapPins();
                },
                controller: _searchControler,
                decoration: const InputDecoration(
                  hintText: 'Biển số tàu cần tìm...',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),*/
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
                          _allShip.arrayAPI = _allShip.allShipByUserId;
                          setMapPins();
                          handleTap();
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
                          handleTap();
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
                          handleTap();
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
                          handleTap();
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
                          handleTap();
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
                                      clearData();
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
            ? Stack(
                children: <Widget>[
                  FlutterMap(
                    options: MapOptions(
                      center: latLng.LatLng(10.7553411, 106.4150405),
                      zoom: 6,
                      onTap: (context, latLng.LatLng location) {
                        setState(() {
                          pinPillPosition = -120;
                          handleKeybroad();
                        });
                      },
                    ),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:"https://api.mapbox.com/styles/v1/dinhh/ckw1i5xfp45bl14mphg4cpbh9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGluaGgiLCJhIjoiY2t3MWkxYXFpODE2eDJvczFzaXgyaTZ6ZiJ9.DURDM6H_MOLt3C4YY9zufw",
                          additionalOptions: {
                            'accessToken':
                                'pk.eyJ1IjoiZGluaGgiLCJhIjoiY2t3MWkxYXFpODE2eDJvczFzaXgyaTZ6ZiJ9.DURDM6H_MOLt3C4YY9zufw',
                            'id': 'mapbox.mapbox-streets-v8'
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
                      onTap: (){
                        _searchControler.text = foodList[index];
                        foodListSearch = [];
                        searchMapPins();
                      },
                    ),
                  );
                }
              ),
      ),
      onWillPop: () async => false,
    );
  }

  @override
  void initState() {
    super.initState();
    getMarker();
  }

  void handleTap() {
    Navigator.pop(context);
  }
  void handleKeybroad() {
    FocusScopeNode currentFocus = FocusScope.of(context);
     if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
  }

  void clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    exit(0);
  }

  void getMarker() async {
    await _allShip.getAllShipByUserId();
    _allShip.arrayAPI = _allShip.allShipByUserId;
    setState(() {
      setMapPins();
    });
  }

  void searchMapPins() async {
    _allShip.arrayAPI = _allShip.allShipByUserId;
    List<AllShipByUserId> shipByUserId = [];
    for (int i = 0; i < _allShip.arrayAPI.length; i++) {
      if (_allShip.arrayAPI[i].tentau == _searchControler.text.toUpperCase()) {
        shipByUserId.add(_allShip.arrayAPI[i]);
      }
    }
    if (shipByUserId.length > 0) {
      _allShip.arrayAPI = shipByUserId;
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
      });
    }
  }

  void setMapPins() async {
    _markers.clear();
    String _pinPath, _avatarPath, _address, _status;
    FilePath filePath = new FilePath();
    String? _urlMarker = '';
    late Color _labelColor;
    for (int i = 0; i < _allShip.arrayAPI.length; i++) {
      if (_allShip.arrayAPI[i].statusID == 3) {
        _urlMarker = filePath.icon+'driving_boat_greens.png';
      } else if (_allShip.arrayAPI[i].statusID == 2) {
        _urlMarker = filePath.icon+'driving_boat_red.png';
      } else if (_allShip.arrayAPI[i].statusID > 3) {
        _urlMarker = filePath.icon+'driving_boat_black.png';
      } else if (_allShip.arrayAPI[i].latitude == 0 &&
          _allShip.arrayAPI[i].longitude == 0) {
        _urlMarker = filePath.icon+'destination_map_marker.png';
      } else {
        _urlMarker = filePath.icon+'destination_map_red.png';
      }
      AssetImage assetImage = AssetImage(_urlMarker);
      Marker resultMarker = Marker(
        width: 70.0,
        height: 70.0,
        point: latLng.LatLng(
            _allShip.arrayAPI[i].latitude, _allShip.arrayAPI[i].longitude),
        builder: (ctx) => Container(
            child: FlatButton(
          onPressed: () {
            setState(() {
              if (_allShip.arrayAPI[i].statusID == 3) {
                _pinPath = filePath.icon+"driving_boat_greens.png";
                _avatarPath = filePath.image+"friend1.jpg";
                _labelColor = Colors.greenAccent;
                _status = 'Đang hoạt động';
              } else if (_allShip.arrayAPI[i].statusID == 2) {
                _pinPath = filePath.icon+"driving_boat_red.png";
                _avatarPath = filePath.image+"friend1.jpg";
                _labelColor = Colors.redAccent;
                _status = 'Mất tính hiệu';
              } else if (_allShip.arrayAPI[i].statusID > 3) {
                _pinPath = filePath.icon+"driving_boat_black.png";
                _avatarPath = filePath.image+"friend1.jpg";
                _labelColor = Colors.black;
                _status = 'Dừng';
              } else if (_allShip.arrayAPI[i].latitude == 0 &&
                  _allShip.arrayAPI[i].longitude == 0) {
                _pinPath = filePath.icon+"destination_map_marker.png";
                _avatarPath = filePath.image+"friend1.jpg";
                _labelColor = Colors.red;
                _status = 'Mất tính hiệu GPS';
              } else {
                _pinPath = filePath.icon+"destination_map_red.png";
                _avatarPath = filePath.image+"friend2.jpg";
                _labelColor = Colors.purple;
                _status = 'Chưa kích hoạt';
              }
              currentlySelectedPin = PinInformation(
                vehicalNumber: _allShip.arrayAPI[i].tentau,
                location: latLng.LatLng(_allShip.arrayAPI[i].latitude,
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
