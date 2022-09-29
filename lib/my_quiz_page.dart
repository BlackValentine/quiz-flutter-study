import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class TileInfo {
  String title;
  Color color;
  TileInfo({required this.title, required this.color});
}

List<TileInfo> tileInfoList = [
  TileInfo(title: "Red", color: Colors.red),
  TileInfo(title: "Blue", color: Colors.blue),
  TileInfo(title: "Green", color: Colors.green),
  TileInfo(title: "Orange", color: Colors.orange),
];

int score = 0;

class MyQuizPage extends StatefulWidget {
  MyQuizPage({Key? key}) : super(key: key);

  @override
  State<MyQuizPage> createState() => _MyQuizPageState();
}

class _MyQuizPageState extends State<MyQuizPage> {
  int currentPage = 0;
  List<bool?> boolToShow = List.generate(6, (index) => Random().nextBool());
  List<bool?> boolCheckList = List.generate(6, (index) => false);
  List<bool?> boolCompare = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    bool everyThingIsFine = true;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Quiz'),
      ),
      body: currentPage == 0
          ? Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: const AssetImage('images/background.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.2), BlendMode.modulate))),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: const Text('Select the red square',
                          style: TextStyle(fontSize: 25.0))),
                  const Spacer(),
                  ...List.generate(
                      tileInfoList.length,
                      (index) => Container(
                            color: tileInfoList[index].color,
                            child: _customListTile(
                                title: tileInfoList[index].title,
                                color: tileInfoList[index].color),
                          )),
                  const Spacer(),
                ],
              ),
            )
          : currentPage == 1
              ? Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: const Text('Check only YES Tile',
                              style: TextStyle(fontSize: 25.0))),
                      const Spacer(),
                      ...List.generate(boolCheckList.length, (index) {
                        for (int i = 0; i < boolCheckList.length; i++) {
                          if (boolCheckList[i] != boolToShow[i]) {
                            setState(() {
                              everyThingIsFine = false;
                              boolCompare[i] = false;
                            });
                          } else {
                            boolCompare[i] = true;
                          }
                        }
                        return CheckboxListTile(
                          tileColor: boolCompare[index] == false
                              ? Colors.red
                              : Colors.green,
                          value: boolCheckList[index],
                          onChanged: (valueBool) {
                            setState(() {
                              boolCheckList[index] = valueBool;
                            });
                          },
                          title: Text(boolToShow[index] == true ? "Yes" : "No"),
                        );
                      }),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              if (everyThingIsFine) {
                                score = score + 1;
                              }
                              currentPage = currentPage + 1;
                            });
                          },
                          child: const Text('Finish')),
                      const Spacer(),
                    ],
                  ),
                )
              : Container(
                  child: Center(
                    child: Text("Score: $score"),
                  ),
                ),
    );
  }

  Widget _customListTile({
    required String title,
    required Color color,
  }) =>
      ListTile(
        title: Text(title),
        tileColor: color,
        onTap: () {
          if (color == Colors.red) {
            score = 1;
          } else {
            score = 0;
          }
          setState(() {
            currentPage = currentPage + 1;
          });
        },
      );
}
