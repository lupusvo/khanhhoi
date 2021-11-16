import 'dart:ui';

class PinInformation {
  String pinPath;
  String avatarPath;
  var location;
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
