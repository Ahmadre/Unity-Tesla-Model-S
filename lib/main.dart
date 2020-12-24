import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity/flutter_unity.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UnityViewPage(),
    );
  }
}

class UnityViewPage extends StatefulWidget {
  @override
  _UnityViewPageState createState() => _UnityViewPageState();
}

class _UnityViewPageState extends State<UnityViewPage> {
  UnityViewController unityViewController;
  Color backgroundColor = Colors.white;
  Color contrastColor = Colors.black54;

  double speed = 0;
  double rotation = 0;

  String actualModel = 'Model S';

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          actualModel,
          style: TextStyle(color: contrastColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_4, color: contrastColor),
            onPressed: () {
              if (backgroundColor == Colors.white) {
                backgroundColor = Colors.black;
                contrastColor = Colors.white;
              } else {
                backgroundColor = Colors.white;
                contrastColor = Colors.black54;
              }
              String colorString = '${backgroundColor.red},${backgroundColor.blue},${backgroundColor.green}';
              unityViewController.send('MainCamera', 'SetBackgroundColor', colorString);
              Future.delayed(const Duration(milliseconds: 50), () {
                setState(() {});
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 1280 / 720,
              child: UnityView(
                onCreated: onUnityViewCreated,
                onReattached: onUnityViewReattached,
                onMessage: onUnityViewMessage,
              ),
            ),
          ),
          Card(
            color: backgroundColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text('Rotation'),
                ),
                Slider.adaptive(
                  min: 0,
                  max: 100,
                  value: rotation,
                  onChanged: (val) {
                    setState(() {
                      rotation = val;
                    });
                    unityViewController.send(
                      actualModel.replaceAll(' ', ''),
                      'SetRotationSpeed',
                      '${val.toInt()}',
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Divider(),
                ),
                Text('Speed'),
                Slider.adaptive(
                  min: 0,
                  max: 400,
                  value: speed,
                  onChanged: (val) {
                    setState(() {
                      speed = val;
                    });
                    unityViewController.send(
                      actualModel.replaceAll(' ', ''),
                      'SetCarSpeed',
                      '${val.toInt()}',
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onUnityViewCreated(UnityViewController controller) {
    debugPrint('onUnityViewCreated');

    setState(() {
      unityViewController = controller;
    });

    controller.send(
      'Init',
      'loadModel',
      actualModel.replaceAll(' ', '').toLowerCase(),
    );
  }

  void onUnityViewReattached(UnityViewController controller) {
    debugPrint('onUnityViewReattached');

    setState(() {
      unityViewController = controller;
    });
  }

  void onUnityViewMessage(UnityViewController controller, String message) {
    debugPrint('onUnityViewMessage');

    debugPrint(message);
  }
}
