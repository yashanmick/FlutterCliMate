import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    //implement initState
    super.initState();
    getLocation();
    print('this line of code is triggered');
    // getData();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    http.Response res = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=439d4b804bc8187953eb36d2a8c26a02');
    //print(res.statusCode);
    if (res.statusCode == 200) {
      String data = res.body;
      //print(data);

      // var longitude = jsonDecode(data)['coord']['lon'];
      // print(longitude);

      // var weatherDescription = jsonDecode(data)['weather'][0]['description'];
      // print(weatherDescription);

      var decodedData = jsonDecode(data);

      double tempreture = decodedData['main']['temp'];
      print(tempreture);

      int condition = decodedData['weather'][0]['id'];
      print(condition);

      String city = decodedData['name'];
      print(city);
    } else {
      print(res.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
