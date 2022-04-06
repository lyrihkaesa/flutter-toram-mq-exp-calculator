import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toram_mq_calc/calc/calc_mq.dart';
import 'package:toram_mq_calc/model/toram_mq.dart';
import 'package:toram_mq_calc/screen/detail_mq_calc_screen.dart';

class CalcScreen extends StatefulWidget {
  CalcScreen({Key? key}) : super(key: key);

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  TextEditingController levelCharacterFlat = TextEditingController(text: "50");
  TextEditingController levelCharacterPerc = TextEditingController(text: "0");

  int startSelectedEpisode = 1;
  int endSelectedEpisode = toramMqList.length;

  var _calcExpMq = CalculateExpMq();

  void fungsiSetState() async {
    setState(() {
      _calcExpMq.levelCharFlat = levelCharacterFlat.text == ""
          ? 1
          : double.parse(levelCharacterFlat.text);
      _calcExpMq.levelCharPerc = levelCharacterPerc.text == ""
          ? 1
          : double.parse(levelCharacterPerc.text);
      _calcExpMq.startEps = startSelectedEpisode;
      _calcExpMq.endEps = endSelectedEpisode;
      _calcExpMq.calculate();
    });
  }

  final List<Tab> _myTab = [
    Tab(
      text: 'Indonesia',
    ),
    Tab(
      text: 'English',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: _myTab.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kalkulator Misi Cerita',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'By: Kaesa Lyrih',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            tabs: _myTab,
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        fungsiSetState();
                      },
                      child: SizedBox(
                        height: 100,
                        child: Card(
                          color: Colors.pink,
                          child: Align(
                            // alignment: Alignment.centerLeft,
                            child: Text(
                              "Level ${_calcExpMq.resLvlCharFlat.toInt()} (${_calcExpMq.resLvlCharPerc.toInt()}%) ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Level Karakter",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 8,
                              child: TextField(
                                controller: levelCharacterFlat,
                                decoration: InputDecoration(
                                  labelText: "Flat",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  fungsiSetState();
                                  // levelCharacterFlat.text = value;
                                },
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Flexible(
                              flex: 4,
                              child: TextField(
                                controller: levelCharacterPerc,
                                decoration: InputDecoration(
                                  labelText: "Persen %",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  if (value == "") {
                                  } else if (int.parse(value) > 99) {
                                    levelCharacterPerc.text = "99";
                                    final val = TextSelection.collapsed(
                                      offset: levelCharacterPerc.text.length,
                                    );
                                    levelCharacterPerc.selection = val;
                                  }
                                  fungsiSetState();
                                  // levelCharacterFlat.text = value;
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Mulai Episode Misi Cerita",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11))),
                          isExpanded: true,
                          hint: Text("Episode Awal"),
                          value: startSelectedEpisode,
                          items: toramMqList.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.chapter.toStringAsFixed(0) +
                                  "." +
                                  value.episode.toStringAsFixed(0) +
                                  " : " +
                                  value.episodeid),
                              value: value.episode,
                            );
                          }).toList(),
                          onChanged: (int? val) {
                            startSelectedEpisode = val!;
                            fungsiSetState();
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Selesai Episode Misi Cerita",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11))),
                          isExpanded: true,
                          hint: Text("Episode Awal"),
                          value: endSelectedEpisode,
                          items: toramMqList.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.chapter.toStringAsFixed(0) +
                                  "." +
                                  value.episode.toStringAsFixed(0) +
                                  " : " +
                                  value.episodeid),
                              value: value.episode,
                            );
                          }).toList(),
                          onChanged: (int? val) {
                            endSelectedEpisode = val!;
                            fungsiSetState();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        fungsiSetState();
                      },
                      child: SizedBox(
                        height: 100,
                        child: Card(
                          color: Colors.pink,
                          child: Align(
                            // alignment: Alignment.centerLeft,
                            child: Text(
                              "Level ${_calcExpMq.resLvlCharFlat.toInt()} (${_calcExpMq.resLvlCharPerc.toInt()}%) ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            'Character Level',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 8,
                              child: TextField(
                                controller: levelCharacterFlat,
                                decoration: InputDecoration(
                                  labelText: "Flat",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  fungsiSetState();
                                  // levelCharacterFlat.text = value;
                                },
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Flexible(
                              flex: 4,
                              child: TextField(
                                controller: levelCharacterPerc,
                                decoration: InputDecoration(
                                  labelText: "Percent %",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  if (value == "") {
                                  } else if (int.parse(value) > 99) {
                                    levelCharacterPerc.text = "99";
                                    final val = TextSelection.collapsed(
                                      offset: levelCharacterPerc.text.length,
                                    );
                                    levelCharacterPerc.selection = val;
                                  }
                                  fungsiSetState();
                                  // levelCharacterFlat.text = value;
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Start Story Mission Episode",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11))),
                          isExpanded: true,
                          hint: Text("Episode Awal"),
                          value: startSelectedEpisode,
                          items: toramMqList.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.chapter.toStringAsFixed(0) +
                                  "." +
                                  value.episode.toStringAsFixed(0) +
                                  " : " +
                                  value.episodeen),
                              value: value.episode,
                            );
                          }).toList(),
                          onChanged: (int? val) {
                            startSelectedEpisode = val!;
                            fungsiSetState();
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Complete Story Mission Episode",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11))),
                          isExpanded: true,
                          hint: Text("Episode Awal"),
                          value: endSelectedEpisode,
                          items: toramMqList.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.chapter.toStringAsFixed(0) +
                                  "." +
                                  value.episode.toStringAsFixed(0) +
                                  " : " +
                                  value.episodeen),
                              value: value.episode,
                            );
                          }).toList(),
                          onChanged: (int? val) {
                            endSelectedEpisode = val!;
                            fungsiSetState();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            fungsiSetState();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailMqCalcScreen(
                    calculateExpMq: _calcExpMq,
                  );
                },
              ),
            );
          },
          child: Text("Detail Info"),
        ),
      ),
    );
  }
}
