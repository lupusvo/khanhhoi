String icon = 'assets/icons/';
String image = 'assets/images/';
class FilePath{
  String boatGreens = icon+'driving_boat_greens.png';
  String boatRed = icon+'driving_boat_red.png';
  String boatYellow = icon+'driving_boat_yellow.png';
  String boatBlack = icon+'driving_boat_black.png';
  String boatNoActive = icon+'destination_map_marker.png';
  String personOne = image+'friend1.jpg';
  String personTwo = image+'friend2.jpg';
}

String url = "https://i-sea.khanhhoi.net/api/";
class LinkAPI{
  String getAllShip = url+"Ship/getAllship/";
  String getInfoUer = url+"user/getInfobyUsername/";
}