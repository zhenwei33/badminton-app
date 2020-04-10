import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map1/shared/constant.dart';

class GeolocationService {
  String url = 'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric';

  Position position;
  GeolocationService();

  Future calculateDistance(double latitude, double longtitude) async {
    if (position == null) {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }
    final String origin = '&origins=${position.latitude},${position.longitude}';
    final String destination = '&destinations=${latitude},${longtitude}';

    print(url + origin + destination);
    Dio dio = new Dio();
    try{
      Response response = await dio.get(url + origin + destination + '&key=' + googleMapApiKey);
      Map<String,dynamic> json = response.data;
      return json['rows'][0]['elements'][0];
    }catch(exception){
      print(exception);
    }
    return null;
  }
}
