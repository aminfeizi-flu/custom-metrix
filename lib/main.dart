import 'package:metrix_plugin/Metrix.dart';
import 'package:metrix_plugin/MetrixAttribution.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String sessionNum = "";
  String sessionId = "";
  String userId = "";
  String deeplink = "";
  MetrixAttribution? attribution;

  @override
  void initState() {
    super.initState();

    setState(() {
      sessionNum = "";
      sessionId = "";
      userId = "";
      deeplink = "";
      attribution = null;
    });

    Metrix.setPushToken('pushToken');

    Metrix.addUserAttributes({
      "name": "hisName"
    });

    Metrix.getAttributionData().then((value) => {
      this.setState(() {
        attribution = value;
      })
    });

    Metrix.shouldLaunchDeeplink = true;
    Metrix.getDeeplinkResponse().then((value) => {
      this.setState(() {
        deeplink = value;
      })
    });

    Metrix.getUserId().listen((value) => {
      this.setState(() {
        userId = value;
      })
    });

    Metrix.getSessionId().listen((id) => {
      this.setState(() {
        sessionId = id;
      })
    });

    Metrix.getSessionNumber().listen((sessionNumber) => {
      this.setState(() {
        sessionNum = sessionNumber.toString();
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Metrix plugin example app'),
          ),
          body: Center(child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.all(20),
                child: Text('Session number is: $sessionNum')
            ),
            Container(
                margin: EdgeInsets.all(20),
                child: Text('Session id is: $sessionId')
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: FlatButton(
                child: Text('SendEvent'),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  Metrix.newEvent('lbuoa', {
                    "name": "hisName"
                  });
                  Metrix.newEvent('lbuoa');
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: FlatButton(
                child: Text('SendRevenue'),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  Metrix.newRevenue('ykwyp', 2500.5);
                  Metrix.newRevenue('ykwyp', 2500.5, currency: 0);
                  Metrix.newRevenue('ykwyp', 2500.5, currency: 0, orderId: "someId");
                  Metrix.newRevenue('ykwyp', 2500.5, orderId: "someId");
                },
              ),
            ),
            Container(
                margin: EdgeInsets.all(20),
                child: Text('UserId is: $userId')
            ),
            Container(
                margin: EdgeInsets.all(20),
                child: Text('Deeplink is: $deeplink')
            ),
            Container(
                margin: EdgeInsets.all(20),
                child: Text('User attribution status: ${attribution?.attributionStatus ?? ""}')
            ),
          ]))
      ),
    );
  }
}