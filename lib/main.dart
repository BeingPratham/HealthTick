// import 'dart:html';
import 'dart:math';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation
import 'package:flutter/material.dart';
import 'package:alarmplayer/alarmplayer.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Mindful Meal timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const defaultDuration = Duration(minutes: 1, seconds: 10);
    Alarmplayer alarmplayer = Alarmplayer();
    bool playing = false;
    AudioCache audiocache = AudioCache();
    bool stopped = false;
    void switchPlaying() {
      playing = !playing;
      setState(() {});
    }

    bool Svalue = true;
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 22, 33, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 22, 33, 1),
        title: Text(
          widget.title,
          style: TextStyle(
            color: Color.fromRGBO(139, 137, 150, 1),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 140,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(139, 137, 150, 1),
                  radius: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(139, 137, 150, 1),
                  radius: 10,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Time to eat mindfully",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "It's simple : eat slowly for ten minutes, rest for",
              style: TextStyle(
                  color: Color.fromRGBO(139, 137, 150, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                SizedBox(
                  width: 90,
                ),
                Text(
                  "five, then finish your meal",
                  style: TextStyle(
                      color: Color.fromRGBO(139, 137, 150, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Stack(children: [
              Container(
                height: 260,
                width: 270,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(149, 149, 155, 1),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 115, 0),
                      child: CustomPaint(painter: ClockTicks()),
                    ),
                  ),
                ),

                // color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.all(100),
                child: stopped == false
                    ? SlideCountdown(
                        duration: defaultDuration,
                        onChanged: (value) {
                          if (value.inSeconds == 5) {
                            alarmplayer.Alarm(
                                url: "assets/countdown_tick.mp3",
                                looping: true,
                                volume: 0.5,
                                callback: () {
                                  if (value.inSeconds == 1) {
                                    setState(() {
                                      playing = false;
                                      alarmplayer.StopAlarm();
                                    });
                                  }
                                });
                          } else if (value.inSeconds == 1) {
                            alarmplayer.StopAlarm();
                            setState(() {
                              stopped = false;
                            });
                          }
                        },
                        // padding: defaultPadding,
                        slideDirection: SlideDirection.up,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      )
                    : Text(
                        "DONE!!",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
              )
            ]),
            SizedBox(
              height: 40,
            ),
            CupertinoSwitch(
                value: Svalue,
                onChanged: (value) {
                  setState(() {
                    Svalue = value;
                  });
                }),
            Text(
              "Sound Off",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: 250,
              decoration: BoxDecoration(
                color: Color.fromRGBO(170, 193, 189, 1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color.fromRGBO(115, 147, 129, 1),
                      blurRadius: 2.0,
                      offset: Offset(0, 3))
                ],
              ),
              child: GestureDetector(
                  child: Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: 95,
                    ),
                    Text(
                      "PAUSE",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 19,
                        ),
                        Text(
                          "LET'S STOP I'M FULL NOW",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class ClockTicks extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 0.90;
    var centerY = size.height / 1.0;
    var radius = min(centerX, centerY);
    var dashBrush = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.2;
    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 10;
    for (var i = 0; i < 360; i += 6) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
