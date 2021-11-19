import 'package:get/state_manager.dart';
import 'package:sea_demo01/src/Services/cqapi.dart';
import 'package:sea_demo01/src/model/shipuser_model.dart';

class AllShipController extends GetxController {
  var isLoading = true.obs;
  var allShipByUserIdList = <AllShipByUserId>[].obs;
  List<String> shipList = [];
  List<AllShipByUserId> runingShipByUserId = [];
  List<AllShipByUserId> pauseShipByUserId = [];
  List<AllShipByUserId> disShipByUserId = [];
  List<AllShipByUserId> gpsShipByUserId = [];

  @override
  void onInit() {
    fetchAllShipByUser();
    super.onInit();
  }

  void fetchAllShipByUser() async {
    try {
      isLoading(true);
      var allShip = await CQAPI.getAllShipByUserId();
      if (allShip != null) {
        allShipByUserIdList.value = allShip;
        
        for(int i = 0;i < allShip.length;i++){
          shipList.add(allShip[i].tentau);
          if(allShip[i].statusID == 3){
            runingShipByUserId.add(allShip[i]);
          }
          if(allShip[i].statusID > 3){
            pauseShipByUserId.add(allShip[i]);
          }
          if(allShip[i].statusID == 2){
            disShipByUserId.add(allShip[i]);
          }
          if(allShip[i].latitude == 0 && allShip[i].longitude == 0){
            gpsShipByUserId.add(allShip[i]);
          }
        }
      }
    } finally {
      isLoading(false);
    }
  }
}