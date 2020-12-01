import 'package:flutter/material.dart';

const TWO_PI = 3.14 * 2;
int max = 11;
int _count = 0;

int percentage = ((_count / max) * 100).ceil();

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final size = 200.0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contagem de pessoas'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: size,
                height: size,
                child: TweenAnimationBuilder(
                    tween: Tween(begin: 0.0, end: (_count * 1) / max),
                    duration: Duration(seconds: 4),
                    builder: (context, value, child) {
                      // percentage to show in Center Text

                      return Container(
                        width: size,
                        height: size,
                        child: Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return SweepGradient(
                                        startAngle: 0.0,
                                        endAngle: TWO_PI,
                                        stops: [
                                          value,
                                          value
                                        ], // value from Tween Animation Builder
                                        // 0.0 , 0.5 , 0.5 , 1.0
                                        center: Alignment.center,
                                        colors: [Colors.blue, Colors.black12])
                                    .createShader(rect);
                              },
                              child: Container(
                                width: size,
                                height: size,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: size - 40,
                                height: size - 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    "$_count",
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              new Container(
                child: new Center(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new FloatingActionButton(
                        onPressed: add,
                        child: new Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      new FloatingActionButton(
                        onPressed: minus,
                        child: new Icon(
                          Icons.remove,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                child: new Center(
                  child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text("$percentage%",
                            style: new TextStyle(fontSize: 30.0))
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void add() {
    setState(() {
      _count++;
      porcento();
    });
  }

  void minus() {
    setState(() {
      if (_count != 0) _count--;
      porcento();
    });
  }

  void porcento() {
    setState(() {
      percentage = ((_count / max) * 100).ceil();
    });
  }
}
