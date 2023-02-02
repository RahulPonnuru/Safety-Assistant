import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safety_assistant/location.dart';
import 'package:safety_assistant/sms_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('sendSms');

  Future<Null> sendSms() async {
    print("SendSMS");
    try {
      final String result =
          await platform.invokeMethod('send', <String, dynamic>{
        "phone": "+919359875192",
        "msg":
            "ALERT!\nI met with an accident at <map link> please help me out!"
      }); //Replace a 'X' with 10 digit phone number
      print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Center(
          child: Column(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                currentAccountPicture: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Color(0xFF778899),
                  backgroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/90468365?v=4"),
                ),
                accountName: Text(
                  "Pavan Bhadane",
                  style: TextStyle(color: Colors.black, fontSize: 19),
                ),
                accountEmail: Text(
                  "Pavan49719@gmail.com",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Add SoS numbers')),
              ElevatedButton(
                  onPressed: () {}, child: Text('Check Device Status')),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon_button(
                icon: Icons.call,
                titleText: "SoS",
                func: () async {
                  Coord coord = Coord();
                  await getPermission();
                  coord = await getCurrentLocation();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SmsScreen(
                        coord: coord,
                        title: 'sms',
                      ),
                    ),
                  );
                },
              ),
              icon_button(
                icon: Icons.medical_services,
                titleText: "Medical Help",
                func: () async {
                  Coord coord = Coord();
                  await getPermission();
                  coord = await getCurrentLocation();
                  launch(
                    "https://www.google.com/maps/search/hospitals+near+me/@${coord.latitude},${coord.longitude}",
                    forceWebView: true,
                    enableJavaScript: true,
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon_button(
                icon: Icons.fire_extinguisher,
                titleText: "Fire Extinguisher",
                func: () async {
                  Coord coord = Coord();
                  await getPermission();
                  coord = await getCurrentLocation();
                  launch(
                    "https://www.google.com/maps/search/fire+brigade+near+me/@${coord.latitude},${coord.longitude}",
                    forceWebView: true,
                    enableJavaScript: true,
                  );
                },
              ),
              icon_button(
                icon: Icons.local_police,
                titleText: "Police",
                func: () async {
                  Coord coord = Coord();
                  await getPermission();
                  coord = await getCurrentLocation();
                  launch(
                    "https://www.google.com/maps/search/police+near+me/@${coord.latitude},${coord.longitude}",
                    forceWebView: true,
                    enableJavaScript: true,
                  );
                },
              ),
            ],
          ),
          icon_button(
            icon: Icons.add_road,
            titleText: "Road Assistant",
            func: () async {
              Coord coord = Coord();
              await getPermission();
              coord = await getCurrentLocation();
              launch(
                "https://www.google.com/maps/search/tow+service+near+me/@${coord.latitude},${coord.longitude}",
                forceWebView: true,
                enableJavaScript: true,
              );
            },
          ),
        ],
      ),
    );
  }
}

class icon_button extends StatelessWidget {
  IconData icon;
  String titleText;
  Function() func;
  icon_button(
      {required this.icon, required this.titleText, required this.func});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Material(
            color: Colors.blue, // Button color
            child: InkWell(
              splashColor: Colors.red, // Splash color
              onTap: func,
              child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Icon(
                    icon,
                    size: 90,
                  )),
            ),
          ),
        ),
        Text(
          titleText,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
