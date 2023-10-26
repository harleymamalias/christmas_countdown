import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Snow extends StatefulWidget {
  const Snow({Key? key});

  @override
  State<Snow> createState() => _SnowState();
}

class _SnowState extends State<Snow> {
  List<SnowModel> listSnow = [];
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      var data = SnowModel(
        size: (Random().nextInt(16) + 4).toDouble(),
        top: -10,
        left: Random().nextDouble() * MediaQuery.of(context).size.width * 0.95,
        duration: Random().nextInt(8) + 4,
      );
      setState(() {
        listSnow.add(data);
      });
      Future.delayed(Duration(milliseconds: 30), () {
        setState(() {
          listSnow.last.top = MediaQuery.of(context).size.height;
        });
      });
      if (timer.tick > 10) {
        var max = 4;
        var min = listSnow.length - 5;
        var randomIndex = Random().nextInt(max) + min;

        listSnow[randomIndex].left = listSnow[randomIndex].left! +
            (listSnow[randomIndex].left! >
                    MediaQuery.of(context).size.width * 0.5
                ? -50.0
                : 50.0);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: listSnow.map((element) {
        return AnimatedPositioned(
          top: element.top,
          left: element.left,
          duration: Duration(seconds: element.duration!),
          curve: Curves.linear,
          child: Container(
            width: element.size,
            height: element.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SnowModel {
  double? size;
  double? top;
  double? left;
  int? duration;

  SnowModel({this.size, this.top, this.left, this.duration});

  SnowModel.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    top = json['top'];
    left = json['left'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['top'] = this.top;
    data['left'] = this.left;
    data['duration'] = this.duration;
    return data;
  }
}
