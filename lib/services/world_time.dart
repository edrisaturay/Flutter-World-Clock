import 'package:http/http.dart';
import 'dart:convert'; //Allows us to convert json string to json map
import 'package:intl/intl.dart';

class WorldTime {
  // Location name for the UI
  String location;
  // Time in that location
  String time;
  // URL to an asset flag icon
  String flag;
  // Location URL for API Endpoint
  String url;
  // True or False if it's day time
  bool isDayTime;

  // Constructor
  WorldTime({this.location, this.flag, this.url});

  // Get the current time from the API
  Future<void> getTime() async {
    try {
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map responseData = jsonDecode(response.body);
      // Get properties from data
      String dateTime = responseData['datetime'];
      String offset = responseData['utc_offset'].substring(1, 3);
      // Create a DataTime Object
      DateTime now = DateTime.parse(dateTime);
      // Add the offset
      now = now.add(Duration(hours: int.parse(offset)));
      // Set the time property
      this.isDayTime = (now.hour > 6 && now.hour < 20 ) ? true : false;
      this.time = DateFormat.jm().format(now);
    } catch (e) {
      print('Exception $e');
      time = 'Failed...';
    }
  }
}

