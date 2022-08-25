import 'package:flutter/material.dart';
import 'package:toram_mq_calc/calc/calc_mq.dart';

class DetailMqCalcScreen extends StatelessWidget {
  final CalculateExpMq calculateExpMq;
  DetailMqCalcScreen({Key? key, required this.calculateExpMq})
      : super(key: key);

  List<Widget> getBab() {
    List<Widget> container = [];
    for (var i = calculateExpMq.expBabB.length - 1; i >= 0; i--) {
      var newItem = Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Card(
          color: ((calculateExpMq.expBabA[i] / calculateExpMq.expBabB[i]) * 100)
                      .round() ==
                  0
              ? Colors.grey[500]
              : Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  '${i + 1}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${calculateExpMq.babid[i]}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text('${calculateExpMq.baben[i]}'),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${calculateExpMq.expBabA[i]} / ${calculateExpMq.expBabB[i]}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      'Diperoleh',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${((calculateExpMq.expBabA[i] / calculateExpMq.expBabB[i]) * 100).round()}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${((calculateExpMq.expBabB[i] / calculateExpMq.maxExp) * 100).round()}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ((calculateExpMq.expBabA[i] /
                                            calculateExpMq.expBabB[i]) *
                                        100)
                                    .round() ==
                                0
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      container.add(newItem);
    }
    return container;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                SafeArea(
                  child: Container(
                    color: Colors.pink,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.pinkAccent[700],
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Text(
                          'Detail Kalkulasi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      "Level Karakter",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.pink,
                    elevation: 11,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              'Level ${calculateExpMq.levelCharFlat.toStringAsFixed(0)} (${calculateExpMq.levelCharPerc.toStringAsFixed(0)}%)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              ">",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'Level ${calculateExpMq.resLvlCharFlat.toStringAsFixed(0)} (${calculateExpMq.resLvlCharPerc.toStringAsFixed(0)}%)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      "Episode Misi Cerita",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.pink,
                    elevation: 11,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  '${calculateExpMq.listMQ[calculateExpMq.startEps - 1].chapter}. ${calculateExpMq.listMQ[calculateExpMq.startEps - 1].chapterid}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  ">",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  '${calculateExpMq.listMQ[calculateExpMq.endEps - 1].chapter}. ${calculateExpMq.listMQ[calculateExpMq.endEps - 1].chapterid}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  '${calculateExpMq.listMQ[calculateExpMq.startEps - 1].episode}. ${calculateExpMq.listMQ[calculateExpMq.startEps - 1].episodeid}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  ">",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  '${calculateExpMq.listMQ[calculateExpMq.endEps - 1].episode}. ${calculateExpMq.listMQ[calculateExpMq.endEps - 1].episodeid}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      "Total Exp",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Card(
                    elevation: 11,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.pink,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    child: Text(
                                      'Awal',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                    child: Text(
                                      'Sekarang',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                    child: Text(
                                      'Akhir',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                    child: Text(
                                      'Maksimal',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    child: Text(
                                      '${calculateExpMq.tempExpEpsMqA} (${((calculateExpMq.tempExpEpsMqA / calculateExpMq.maxExp) * 100).toInt()}%)',
                                      style: TextStyle(
                                        color: Colors.pink,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                    child: Text(
                                      '${calculateExpMq.tempExpEpsMqB} (${((calculateExpMq.tempExpEpsMqB / calculateExpMq.maxExp) * 100).toInt()}%)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                    child: Text(
                                      '${calculateExpMq.tempExpEpsMqC} (${((calculateExpMq.tempExpEpsMqC / calculateExpMq.maxExp) * 100).toInt()}%)',
                                      style: TextStyle(
                                        color: Colors.pink,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                    child: Text(
                                      '${calculateExpMq.maxExp} (${((calculateExpMq.maxExp / calculateExpMq.maxExp) * 100).toInt()}%)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      "Exp per Bab (Chapter)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: getBab(),
            )
          ],
        ),
      ),
    );
  }
}
