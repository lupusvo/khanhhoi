import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sea_demo01/src/model/shipuser_model.dart';
import 'package:sea_demo01/src/repositories/all_ship.dart';
import 'package:sea_demo01/src/repositories/pin_pill_info.dart';
import 'package:sea_demo01/src/ui/compoment/map_pin_pill.dart';

class MapGoogle extends StatefulWidget {
  const MapGoogle({Key? key}) : super(key: key);

  @override
  _MapGoogleState createState() => _MapGoogleState();
}

const double CAMERA_ZOOM = 6;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 0;
const LatLng SOURCE_LOCATION = LatLng(10.88790, 106.71819);
const LatLng DEST_LOCATION = LatLng(10.01450, 105.77900);

class _MapGoogleState extends State<MapGoogle> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  final _allShip = new AllShip();
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = 'AIzaSyDO5GoIsghz2hD3oi3CuhDxNgKuN3Gz7KE';
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  double pinPillPosition = -120;
  PinInformation currentlySelectedPin = PinInformation(
    pinPath: 'assets/icons/driving_pin.png',
    avatarPath: 'assets/images/friend1.jpg',
    location: LatLng(0, 0),
    vehicalNumber: 'Start Location',
    labelColor: Colors.grey,
    address: '',
    status: '',
    timeSave: '',
  );
  late PinInformation sourcePinInfo;
  late PinInformation destinationPinInfo;

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: LatLng(16.20088017579864, 105.80583502701335));

    return Scaffold(
        body: Stack(children: <Widget>[
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
          });
        },
      ),
      MapPinPillComponent(
          pinPillPosition: pinPillPosition,
          currentlySelectedPin: currentlySelectedPin)
    ]));
  }

  setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
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
    }
  }

   void onMapCreated(controller){
    //controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    setMapPins();
    setPolylines();

  }
  void setMapPins() async{
    await _allShip.getAllShipByUserId();
      for (int i = 0; i < _allShip.arrayAPI.length; i++) {
        print(_allShip.arrayAPI.length);
        String _pinPath, _avatarPath, _address, _status;
        Color _labelColor;
        Marker resultMarker = Marker (
            markerId: MarkerId(_allShip.arrayAPI[i].imei),
            position: LatLng(_allShip.arrayAPI[i].latitude,
                _allShip.arrayAPI[i].longitude),
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
                } else if (_allShip.arrayAPI[i].speed == 0) {
                  _pinPath = "assets/icons/driving_boat_black.png";
                  _avatarPath = "assets/images/friend1.jpg";
                  _labelColor = Colors.black;
                  _status = 'Dừng';
                } else if (_allShip.arrayAPI[i].latitude == 0 &&
                    _allShip.arrayAPI[i].longitude == 0) {
                  _pinPath = "assets/icons/driving_boat_red.png";
                  _avatarPath = "assets/images/friend1.jpg";
                  _labelColor = Colors.red;
                  _status = 'Mất tính hiệu GPS';
                } else {
                  _pinPath = "assets/icons/destination_map_marker.png";
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
                  address:
                      'Phường 12, Thành phố Vũng Tầu, Bà Rịa - Vũng Tàu, Việt Nam',
                  status: _status,
                  timeSave: _allShip.arrayAPI[i].dateSave,
                );
                pinPillPosition = 0;
              });
            },
            icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(devicePixelRatio: 2.5),
                'assets/icons/driving_boat_blue.png'));
        // Add it to Set
        _markers.add(resultMarker);      
      }
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
