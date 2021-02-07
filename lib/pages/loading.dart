import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:world_time/services/world_time.dart'; //Allows us to convert json string to json map

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'Loading...';
  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await instance.getTime();

    // Goto Homepage
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'is_day_time': instance.isDayTime,
      }
    );
    setState(() {
      time = instance.time;
    });
  }

  @override
  void initState() {
    super.initState();
    print('initState() --> Running');

    setupWorldTime();

    print('initState() --> Complete');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitFadingCube(
            color: Colors.blue,
            size: 100,
          )
      ),
    );
  }
}
