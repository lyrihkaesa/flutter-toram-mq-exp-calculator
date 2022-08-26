import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toram_mq_calc/calc/calc_mq.dart';
import 'package:toram_mq_calc/screen/detail_mq_calc_screen.dart';

import '../model/toram_mq.dart';

class CalcScreen extends StatefulWidget {
  CalcScreen({Key? key}) : super(key: key);

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  TextEditingController levelCharacterFlat = TextEditingController(text: "50");
  TextEditingController levelCharacterPerc = TextEditingController(text: "0");

  List<ToramMQModel> listMQ = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/list-mq.json');
    final data = await json.decode(response);
    setState(() {
      var lMQ =
          data['listMQ'].map((data) => ToramMQModel.fromJson(data)).toList();
      listMQ = List<ToramMQModel>.from(lMQ);
      endSelectedEpisode = listMQ.length;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
    fungsiSetState();
  }

  int startSelectedEpisode = 1;
  int endSelectedEpisode = -1;

  final CalculateExpMq _calcExpMq = CalculateExpMq();

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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxWidth <= 360 ? 16 : 20,
                      ),
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
                  fontSize: constraints.maxWidth <= 360 ? 16 : 18,
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
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: () {
                              fungsiSetState();
                            },
                            child: Card(
                              color: Colors.pink,
                              child: Align(
                                // alignment: Alignment.centerLeft,
                                child: Text(
                                  "Level ${_calcExpMq.resLvlCharFlat.toInt()} (${_calcExpMq.resLvlCharPerc.toInt()}%) ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        constraints.maxWidth <= 360 ? 24 : 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Container(
                              margin: constraints.maxHeight <= 600
                                  ? EdgeInsets.fromLTRB(0, 0, 0, 10)
                                  : EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: constraints.maxHeight <= 600
                                        ? EdgeInsets.fromLTRB(0, 0, 0, 5)
                                        : EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                          style: TextStyle(fontSize: 12),
                                          controller: levelCharacterFlat,
                                          decoration: InputDecoration(
                                            labelText: "Flat",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
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
                                          style: TextStyle(fontSize: 12),
                                          decoration: InputDecoration(
                                            labelText: "Persen %",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          onChanged: (value) {
                                            if (value == "") {
                                            } else if (int.parse(value) > 99) {
                                              levelCharacterPerc.text = "99";
                                              final val =
                                                  TextSelection.collapsed(
                                                offset: levelCharacterPerc
                                                    .text.length,
                                              );
                                              levelCharacterPerc.selection =
                                                  val;
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
                              margin: constraints.maxHeight <= 600
                                  ? EdgeInsets.fromLTRB(0, 0, 0, 10)
                                  : EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: constraints.maxHeight <= 600
                                        ? EdgeInsets.fromLTRB(0, 0, 0, 5)
                                        : EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                        borderRadius: BorderRadius.circular(11),
                                        // gapPadding: 0,
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    ),
                                    isExpanded: true,
                                    hint: Text("Episode Awal"),
                                    value: startSelectedEpisode,
                                    items: listMQ.map((value) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          value.chapter.toStringAsFixed(0) +
                                              "." +
                                              value.episode.toStringAsFixed(0) +
                                              " : " +
                                              value.episodeid,
                                          style: TextStyle(fontSize: 12),
                                        ),
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
                              margin: constraints.maxHeight <= 600
                                  ? EdgeInsets.fromLTRB(0, 0, 0, 10)
                                  : EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: constraints.maxHeight <= 600
                                        ? EdgeInsets.fromLTRB(0, 0, 0, 10)
                                        : EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    ),
                                    isExpanded: true,
                                    hint: Text("Episode Akhir"),
                                    value: endSelectedEpisode,
                                    items: listMQ.map((value) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          value.chapter.toStringAsFixed(0) +
                                              "." +
                                              value.episode.toStringAsFixed(0) +
                                              " : " +
                                              value.episodeid,
                                          style: TextStyle(fontSize: 12),
                                        ),
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
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: () {
                              fungsiSetState();
                            },
                            child: Card(
                              color: Colors.pink,
                              child: Align(
                                // alignment: Alignment.centerLeft,
                                child: Text(
                                  "Level ${_calcExpMq.resLvlCharFlat.toInt()} (${_calcExpMq.resLvlCharPerc.toInt()}%) ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        constraints.maxWidth <= 360 ? 24 : 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Container(
                              margin: constraints.maxHeight <= 600
                                  ? EdgeInsets.fromLTRB(0, 0, 0, 10)
                                  : EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: constraints.maxHeight <= 600
                                        ? EdgeInsets.fromLTRB(0, 0, 0, 5)
                                        : EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Text(
                                      "Character Level",
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
                                          style: TextStyle(fontSize: 12),
                                          controller: levelCharacterFlat,
                                          decoration: InputDecoration(
                                            labelText: "Flat",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
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
                                          style: TextStyle(fontSize: 12),
                                          decoration: InputDecoration(
                                            labelText: "Persen %",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          onChanged: (value) {
                                            if (value == "") {
                                            } else if (int.parse(value) > 99) {
                                              levelCharacterPerc.text = "99";
                                              final val =
                                                  TextSelection.collapsed(
                                                offset: levelCharacterPerc
                                                    .text.length,
                                              );
                                              levelCharacterPerc.selection =
                                                  val;
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
                              margin: constraints.maxHeight <= 600
                                  ? EdgeInsets.fromLTRB(0, 0, 0, 10)
                                  : EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: constraints.maxHeight <= 600
                                        ? EdgeInsets.fromLTRB(0, 0, 0, 5)
                                        : EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                        borderRadius: BorderRadius.circular(11),
                                        // gapPadding: 0,
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    ),
                                    isExpanded: true,
                                    hint: Text("Start Episode"),
                                    value: startSelectedEpisode,
                                    items: listMQ.map((value) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          value.chapter.toStringAsFixed(0) +
                                              "." +
                                              value.episode.toStringAsFixed(0) +
                                              " : " +
                                              value.episodeen,
                                          style: TextStyle(fontSize: 12),
                                        ),
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
                              margin: constraints.maxHeight <= 600
                                  ? EdgeInsets.fromLTRB(0, 0, 0, 10)
                                  : EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: constraints.maxHeight <= 600
                                        ? EdgeInsets.fromLTRB(0, 0, 0, 10)
                                        : EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    ),
                                    isExpanded: true,
                                    hint: Text("Last Episode"),
                                    value: endSelectedEpisode,
                                    items: listMQ.map((value) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          value.chapter.toStringAsFixed(0) +
                                              "." +
                                              value.episode.toStringAsFixed(0) +
                                              " : " +
                                              value.episodeen,
                                          style: TextStyle(fontSize: 12),
                                        ),
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
      },
    );
  }

  @override
  void dispose() {
    levelCharacterFlat.dispose();
    levelCharacterPerc.dispose();
    super.dispose();
  }
}
