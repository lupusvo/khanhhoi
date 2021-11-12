import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinInformation {
  String pinPath;
  String avatarPath;
  LatLng location;
  String vehicalNumber;
  String timeSave;
  String address;
  String status;
  Color labelColor;

  PinInformation(
      {required this.pinPath,
      required this.avatarPath,
      required this.location,
      required this.vehicalNumber,
      required this.timeSave,
      required this.address,
      required this.status,
      required this.labelColor});
}
