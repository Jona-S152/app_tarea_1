import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 39, 191, 218)),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'Login screen'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final firstNameController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstNameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Form(
            child: Column(
              children: [
                // TextFormField(
                //   decoration: const InputDecoration(
                //     labelText: 'Email'
                //   ),
                //   controller: firstNameController,
                // ),
                // const SizedBox(height: 16,),
                // TextFormField(
                //   obscureText: true,
                //   decoration: InputDecoration(
                //     labelText: 'Password',
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10.0)
                //     )
                //   ),
                // ),
                const SizedBox(height: 16,),
                ElevatedButton(onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MapPage())
                  );
                }, child: const Text('Ver mapa'))
              ],
            ),
          )
        ),
      ),
    );
  }
}


class MapPage extends StatelessWidget {
  
  final String userName = 'maps_page'; 

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerButton(),
      appBar: AppBar(
        title: Text(userName),
        
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.satellite,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            top: 50.0,
            left: 10.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100)
              ),
            ),
          )
        ],
      )
    );
  }
}
