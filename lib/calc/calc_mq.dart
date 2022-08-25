import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:toram_mq_calc/model/toram_mq.dart';

class CalculateExpMq {
  List<ToramMQModel> listMQ = [];
  double resLvlCharFlat = 0;
  double resLvlCharPerc = 0;
  double levelCharFlat = 0;
  double levelCharPerc = 0;
  int startEps = 1;
  int endEps = 1;
  double tempExpEpsMqA = 0;
  double tempExpEpsMqB = 0;
  double tempExpEpsMqC = 0;
  double maxExp = 0;
  double tempExpEpsMq = 0;
  var expBabA = [];
  var expBabB = [];
  var babid = [];
  var baben = [];

  CalculateExpMq() {
    readJson();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/list-mq.json');
    final data = await json.decode(response);
    var lMQ =
        data['listMQ'].map((data) => ToramMQModel.fromJson(data)).toList();
    listMQ = List<ToramMQModel>.from(lMQ);
  }

  List drop({required List array, required int n}) {
    List result = [];
    if (n > array.length || n < 0) {
      return [];
    }
    result = array.sublist(n, array.length);
    return result;
  }

  List dropRight({required List array, required int n}) {
    List result = [];
    if (n > array.length || n < 0) {
      return [];
    }
    result = array.sublist(0, array.length - n);
    return result;
  }

  void calculate() async {
    await readJson();
    resetExp();
    endEps = endEps == -1 ? listMQ.length : endEps;
    var start = listMQ[startEps.toInt() - 1];
    var end = listMQ[endEps.toInt() - 1];
    var countR = drop(array: listMQ, n: (start.episode.toInt() - 1));

    for (var i = 0; i < (start.episode - 1); i++) {
      tempExpEpsMqA += listMQ[i].exp;
    }

    for (var i = end.episode.toInt(); i < listMQ.length; i++) {
      tempExpEpsMqC += listMQ[i].exp;
    }

    var lol = [];
    var nameid = [];
    var nameen = [];
    expBabA = [];

    for (var i = 0; i < 12; i++) {
      lol.add(0);
      expBabA.add(0);
      nameid.add('');
      nameen.add('');
    }

    // print(expBabA);

    for (var i = 0; i < listMQ.length; i++) {
      switch (listMQ[i].chapter) {
        case 1:
          {
            nameid[0] = listMQ[i].chapterid;
            nameen[0] = listMQ[i].chapteren;
            lol[0] += listMQ[i].exp;
          }
          break;
        case 2:
          {
            nameid[1] = listMQ[i].chapterid;
            nameen[1] = listMQ[i].chapteren;
            lol[1] += listMQ[i].exp;
          }
          break;
        case 3:
          {
            nameid[2] = listMQ[i].chapterid;
            nameen[2] = listMQ[i].chapteren;
            lol[2] += listMQ[i].exp;
          }
          break;
        case 4:
          {
            nameid[3] = listMQ[i].chapterid;
            nameen[3] = listMQ[i].chapteren;
            lol[3] += listMQ[i].exp;
          }
          break;
        case 5:
          {
            nameid[4] = listMQ[i].chapterid;
            nameen[4] = listMQ[i].chapteren;
            lol[4] += listMQ[i].exp;
          }
          break;
        case 6:
          {
            nameid[5] = listMQ[i].chapterid;
            nameen[5] = listMQ[i].chapteren;
            lol[5] += listMQ[i].exp;
          }
          break;
        case 7:
          {
            nameid[6] = listMQ[i].chapterid;
            nameen[6] = listMQ[i].chapteren;
            lol[6] += listMQ[i].exp;
          }
          break;
        case 8:
          {
            nameid[7] = listMQ[i].chapterid;
            nameen[7] = listMQ[i].chapteren;
            lol[7] += listMQ[i].exp;
          }
          break;
        case 9:
          {
            nameid[8] = listMQ[i].chapterid;
            nameen[8] = listMQ[i].chapteren;
            lol[8] += listMQ[i].exp;
          }
          break;
        case 10:
          {
            nameid[9] = listMQ[i].chapterid;
            nameen[9] = listMQ[i].chapteren;
            lol[9] += listMQ[i].exp;
          }
          break;
        case 11:
          {
            nameid[10] = listMQ[i].chapterid;
            nameen[10] = listMQ[i].chapteren;
            lol[10] += listMQ[i].exp;
          }
          break;
        case 12:
          {
            nameid[11] = listMQ[i].chapterid;
            nameen[11] = listMQ[i].chapteren;
            lol[11] += listMQ[i].exp;
          }
          break;

        default:
          break;
      }
    }

    expBabB = lol;
    babid = nameid;
    baben = nameen;

    if (start.episode == end.episode) {
      tempExpEpsMq += start.exp;
    } else {
      for (var epsmq in countR) {
        tempExpEpsMq += epsmq.exp;

        switch (epsmq.chapter) {
          case 1:
            expBabA[0] += epsmq.exp;
            break;
          case 2:
            expBabA[1] += epsmq.exp;
            break;
          case 3:
            expBabA[2] += epsmq.exp;
            break;
          case 4:
            expBabA[3] += epsmq.exp;
            break;
          case 5:
            expBabA[4] += epsmq.exp;
            break;
          case 6:
            expBabA[5] += epsmq.exp;
            break;
          case 7:
            expBabA[6] += epsmq.exp;
            break;
          case 8:
            expBabA[7] += epsmq.exp;
            break;
          case 9:
            expBabA[8] += epsmq.exp;
            break;
          case 10:
            expBabA[9] += epsmq.exp;
            break;
          case 11:
            expBabA[10] += epsmq.exp;
            break;
          case 12:
            expBabA[11] += epsmq.exp;
            break;

          default:
            break;
        }

        if (epsmq.episode == end.episode) {
          break;
        }
      }
    }
    tempExpEpsMqB = tempExpEpsMq;
    maxExp = tempExpEpsMqA + tempExpEpsMqB + tempExpEpsMqC;
    levelUp();
  }

  void levelUp() {
    var level = levelCharFlat;
    var exp =
        ((level / 2) * (level * level * level * 0.0500000007450581) + level * 2)
            .floor();
    var left = ((100 - levelCharPerc) / 100 * exp).floor();

    var need = 0;

    while (tempExpEpsMq > 0) {
      need = left;
      while (tempExpEpsMq > need) {
        tempExpEpsMq -= need;
        level++;
        exp = ((level / 2) * (level * level * level * 0.0500000007450581) +
                level * 2)
            .floor();
        need = exp;
      }

      need = tempExpEpsMq.toInt();
      tempExpEpsMq -= need;
    }

    resLvlCharFlat = level;
    resLvlCharPerc = (need / exp * 100).floor().toDouble();
  }

  void resetExp() {
    tempExpEpsMqA = 0;
    tempExpEpsMqB = 0;
    tempExpEpsMqC = 0;
    maxExp = 0;
    tempExpEpsMq = 0;
  }
}
