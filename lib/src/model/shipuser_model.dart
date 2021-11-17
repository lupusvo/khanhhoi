import 'package:flutter/cupertino.dart';

class AllShipByUserId {
  late String imei;
  late String imeiExt;
  late String dateExpDevice;
  var dateCreateDV;
  late int idShip;
  late String tentau;
  var cohieu;
  late String hohieu;
  late String imo;
  late int noidangky;
  late int cangdangky;
  late int cangcaphu;
  late int nghechinh;
  var ngaydangky;
  var ngayhethandangky;
  var tongtaitrong;
  var chieudailonnhat;
  var chieuronglonnhat;
  var monnuoc;
  late int congsuat;
  var mauvotau;
  late int sothuyenvien;
  var ngaysanxuat;
  var ngayhethan;
  late int loaitau;
  var dungtichhamca;
  late int vantocdanhbat;
  late int vantochanhtrinh;
  late int deviceid;
  late String dateCreate;
  late bool isActive;
  late String madinhdanh;
  var idBoss;
  late bool isTruth;
  late double latitude;
  late double longitude;
  late int speed;
  late String dateSave;
  late int binVal1;
  late int statusID;
  late int statusStr;
  late bool inzones;
  late bool qcvn;
  late int timeSendTCTS;
  late bool registered;

  AllShipByUserId({
      required this.imei,
      required this.imeiExt,
      required this.dateExpDevice,
      required this.dateCreateDV,
      required this.idShip,
      required this.tentau,
      required this.cohieu,
      required this.hohieu,
      required this.imo,
      required this.noidangky,
      required this.cangdangky,
      required this.cangcaphu,
      required this.nghechinh,
      required this.ngaydangky,
      required this.ngayhethandangky,
      required this.tongtaitrong,
      required this.chieudailonnhat,
      required this.chieuronglonnhat,
      required this.monnuoc,
      required this.congsuat,
      required this.mauvotau,
      required this.sothuyenvien,
      required this.ngaysanxuat,
      required this.ngayhethan,
      required this.loaitau,
      required this.dungtichhamca,
      required this.vantocdanhbat,
      required this.vantochanhtrinh,
      required this.deviceid,
      required this.dateCreate,
      required this.isActive,
      required this.madinhdanh,
      required this.idBoss,
      required this.isTruth,
      required this.latitude,
      required this.longitude,
      required this.speed,
      required this.dateSave,
      required this.binVal1,
      required this.statusID,
      required this.statusStr,
      required this.inzones,
      required this.qcvn,
      required this.timeSendTCTS,
      required this.registered});

  AllShipByUserId.fromJson(Map<String, dynamic> json) {
    imei = json['imei'];
    imeiExt = json['imeiExt'];
    dateExpDevice = json['dateExpDevice'];
    dateCreateDV = json['dateCreateDV'];
    idShip = json['idShip'];
    tentau = json['tentau'];
    cohieu = json['cohieu'];
    hohieu = json['hohieu'];
    imo = json['imo'];
    noidangky = json['noidangky'];
    cangdangky = json['cangdangky'];
    cangcaphu = json['cangcaphu'];
    nghechinh = json['nghechinh'];
    ngaydangky = json['ngaydangky'];
    ngayhethandangky = json['ngayhethandangky'];
    tongtaitrong = json['tongtaitrong'];
    chieudailonnhat = json['chieudailonnhat'];
    chieuronglonnhat = json['chieuronglonnhat'];
    monnuoc = json['monnuoc'];
    congsuat = json['congsuat'];
    mauvotau = json['mauvotau'];
    sothuyenvien = json['sothuyenvien'];
    ngaysanxuat = json['ngaysanxuat'];
    ngayhethan = json['ngayhethan'];
    loaitau = json['loaitau'];
    dungtichhamca = json['dungtichhamca'];
    vantocdanhbat = json['vantocdanhbat'];
    vantochanhtrinh = json['vantochanhtrinh'];
    deviceid = json['deviceid'];
    dateCreate = json['date_create'];
    isActive = json['isActive'];
    madinhdanh = json['madinhdanh'];
    idBoss = json['id_boss'];
    isTruth = json['isTruth'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    speed = json['speed'];
    dateSave = json['dateSave'];
    binVal1 = json['bin_val1'];
    statusID = json['statusID'];
    statusStr = json['statusStr'];
    inzones = json['inzones'];
    qcvn = json['qcvn'];
    timeSendTCTS = json['time_send_TCTS'];
    registered = json['registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imei'] = this.imei;
    data['imeiExt'] = this.imeiExt;
    data['dateExpDevice'] = this.dateExpDevice;
    data['dateCreateDV'] = this.dateCreateDV;
    data['idShip'] = this.idShip;
    data['tentau'] = this.tentau;
    data['cohieu'] = this.cohieu;
    data['hohieu'] = this.hohieu;
    data['imo'] = this.imo;
    data['noidangky'] = this.noidangky;
    data['cangdangky'] = this.cangdangky;
    data['cangcaphu'] = this.cangcaphu;
    data['nghechinh'] = this.nghechinh;
    data['ngaydangky'] = this.ngaydangky;
    data['ngayhethandangky'] = this.ngayhethandangky;
    data['tongtaitrong'] = this.tongtaitrong;
    data['chieudailonnhat'] = this.chieudailonnhat;
    data['chieuronglonnhat'] = this.chieuronglonnhat;
    data['monnuoc'] = this.monnuoc;
    data['congsuat'] = this.congsuat;
    data['mauvotau'] = this.mauvotau;
    data['sothuyenvien'] = this.sothuyenvien;
    data['ngaysanxuat'] = this.ngaysanxuat;
    data['ngayhethan'] = this.ngayhethan;
    data['loaitau'] = this.loaitau;
    data['dungtichhamca'] = this.dungtichhamca;
    data['vantocdanhbat'] = this.vantocdanhbat;
    data['vantochanhtrinh'] = this.vantochanhtrinh;
    data['deviceid'] = this.deviceid;
    data['date_create'] = this.dateCreate;
    data['isActive'] = this.isActive;
    data['madinhdanh'] = this.madinhdanh;
    data['id_boss'] = this.idBoss;
    data['isTruth'] = this.isTruth;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['speed'] = this.speed;
    data['dateSave'] = this.dateSave;
    data['bin_val1'] = this.binVal1;
    data['statusID'] = this.statusID;
    data['statusStr'] = this.statusStr;
    data['inzones'] = this.inzones;
    data['qcvn'] = this.qcvn;
    data['time_send_TCTS'] = this.timeSendTCTS;
    data['registered'] = this.registered;
    return data;
  }
}