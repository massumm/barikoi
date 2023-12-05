import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Application',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});





  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 late MaplibreMapController mapController;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Application'),
      ),
      body: MaplibreMap(
        onMapCreated: (controller) {
          mapController = controller;
           mapController.onst = _updateMapStyle;
          // _getCurrentLocation();
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(23.8103, 90.4125), // Default to Dhaka, Bangladesh
          zoom: 14.0,
        ),
        onMapClick: (point, latLng) {
          // Handle map click events
        },
      ),
    );
  }
 void _updateMapStyle() {
   mapController.setStyleUrl(
       'https://map.barikoi.com/styles/barikoi-bangla/style.json?key=$barikoiApiKey');
 }

 void _getCurrentLocation() async {
   LocationOptions locationOptions = LocationOptions(30.0);
   //LocationData locationData = await barikoiMapsFlutter.getLocation(locationOptions);
   if (locationData != null) {
     mapController.animateCamera(CameraUpdate.newLatLng(LatLng(
       locationData.latitude,
       locationData.longitude,
     )));
     //_loadNearbyBanks(locationData.latitude, locationData.longitude);
   }
 }
 void _loadNearbyBanks(double latitude, double longitude) async {

   List<BarikoiPlace> nearbyBanks = await barikoiMapsFlutter.getNearbyPlaces(
     latitude,
     longitude,
     "bank",
   );

   nearbyBanks.forEach((place) {
     mapController.addSymbol(SymbolOptions(
       geometry: LatLng(place!.latitude, place.longitude),
       iconImage: 'bank-icon', // Add your custom bank icon image
       textField: place.name,
     ));
   });
 }
}

