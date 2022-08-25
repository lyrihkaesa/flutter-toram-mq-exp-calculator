import 'package:flutter/material.dart';
import 'package:toram_mq_calc/calc/calc_mq.dart';
import 'package:toram_mq_calc/model/toram_mq.dart';

class MqDataScreen extends StatelessWidget {
  final CalculateExpMq calculateExpMq = CalculateExpMq();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daftar Misi Cerita',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'By: Kaesa Lyrih',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth <= 600) {
                return MqDataList(
                  calculateExpMq: calculateExpMq,
                );
              } else if (constraints.maxWidth <= 1200) {
                return MqDataGrid(
                  gridCount: 2,
                  calculateExpMq: calculateExpMq,
                );
              } else {
                return MqDataGrid(
                  gridCount: 3,
                  calculateExpMq: calculateExpMq,
                );
              }
            },
          ),
        );
      },
    );
  }
}

class MqDataGrid extends StatelessWidget {
  final int gridCount;
  final CalculateExpMq calculateExpMq;
  MqDataGrid({required this.gridCount, required this.calculateExpMq});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: GridView.count(
          childAspectRatio: 10 / 6,
          crossAxisCount: gridCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: calculateExpMq.listMQ.map((mq) {
            return InkWell(
              onTap: () {},
              child: Card(
                elevation: 10,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        color: Colors.pink[600],
                        child: Text(
                          '${mq.chapter.toStringAsFixed(0)}.${mq.episode.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(mq.chapterid),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(mq.chapteren),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(mq.episodeid),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(mq.episodeen),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                          mq.exp.toStringAsFixed(0),
                          style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class MqDataList extends StatelessWidget {
  final CalculateExpMq calculateExpMq;
  const MqDataList({Key? key, required this.calculateExpMq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: ((context, index) {
          final ToramMQModel mq =
              calculateExpMq.listMQ.reversed.toList()[index];
          return InkWell(
            onTap: () {},
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '${mq.chapter.toStringAsFixed(0)}.${mq.episode.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(mq.episodeid),
                          Text(mq.episodeen)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        mq.exp.toStringAsFixed(0),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
        itemCount: calculateExpMq.listMQ.length,
        // reverse: true,
      ),
    );
  }
}
