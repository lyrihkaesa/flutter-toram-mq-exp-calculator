import 'package:toram_mq_calc/model/toram_mq.dart';

class CalculateExpMq {
  double resLvlCharFlat = 0;
  double resLvlCharPerc = 0;
  double levelCharFlat = 0;
  double levelCharPerc = 0;
  int startEps = 1;
  int endEps = toramMqList.length;
  double tempExpEpsMqA = 0;
  double tempExpEpsMqB = 0;
  double tempExpEpsMqC = 0;
  double maxExp = 0;
  double tempExpEpsMq = 0;
  var expBabA = [];
  var expBabB = [];
  var babid = [];
  var baben = [];

  CalculateExpMq();

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

  void calculate() {
    resetExp();
    var start = toramMqList[startEps.toInt() - 1];
    var end = toramMqList[endEps.toInt() - 1];
    var countR = drop(array: toramMqList, n: (start.episode.toInt() - 1));

    for (var i = 0; i < (start.episode - 1); i++) {
      tempExpEpsMqA += toramMqList[i].exp;
    }

    for (var i = end.episode.toInt(); i < toramMqList.length; i++) {
      tempExpEpsMqC += toramMqList[i].exp;
    }

    var lol = [];
    var nameid = [];
    var nameen = [];
    expBabA = [];

    for (var i = 0; i < 11; i++) {
      lol.add(0);
      expBabA.add(0);
      nameid.add('');
      nameen.add('');
    }

    // print(expBabA);

    for (var i = 0; i < toramMqList.length; i++) {
      switch (toramMqList[i].chapter) {
        case 1:
          {
            nameid[0] = toramMqList[i].chapterid;
            nameen[0] = toramMqList[i].chapteren;
            lol[0] += toramMqList[i].exp;
          }
          break;
        case 2:
          {
            nameid[1] = toramMqList[i].chapterid;
            nameen[1] = toramMqList[i].chapteren;
            lol[1] += toramMqList[i].exp;
          }
          break;
        case 3:
          {
            nameid[2] = toramMqList[i].chapterid;
            nameen[2] = toramMqList[i].chapteren;
            lol[2] += toramMqList[i].exp;
          }
          break;
        case 4:
          {
            nameid[3] = toramMqList[i].chapterid;
            nameen[3] = toramMqList[i].chapteren;
            lol[3] += toramMqList[i].exp;
          }
          break;
        case 5:
          {
            nameid[4] = toramMqList[i].chapterid;
            nameen[4] = toramMqList[i].chapteren;
            lol[4] += toramMqList[i].exp;
          }
          break;
        case 6:
          {
            nameid[5] = toramMqList[i].chapterid;
            nameen[5] = toramMqList[i].chapteren;
            lol[5] += toramMqList[i].exp;
          }
          break;
        case 7:
          {
            nameid[6] = toramMqList[i].chapterid;
            nameen[6] = toramMqList[i].chapteren;
            lol[6] += toramMqList[i].exp;
          }
          break;
        case 8:
          {
            nameid[7] = toramMqList[i].chapterid;
            nameen[7] = toramMqList[i].chapteren;
            lol[7] += toramMqList[i].exp;
          }
          break;
        case 9:
          {
            nameid[8] = toramMqList[i].chapterid;
            nameen[8] = toramMqList[i].chapteren;
            lol[8] += toramMqList[i].exp;
          }
          break;
        case 10:
          {
            nameid[9] = toramMqList[i].chapterid;
            nameen[9] = toramMqList[i].chapteren;
            lol[9] += toramMqList[i].exp;
          }
          break;
        case 11:
          {
            nameid[10] = toramMqList[i].chapterid;
            nameen[10] = toramMqList[i].chapteren;
            lol[10] += toramMqList[i].exp;
          }
          break;
        case 12:
          {
            nameid[11] = toramMqList[i].chapterid;
            nameen[11] = toramMqList[i].chapteren;
            lol[11] += toramMqList[i].exp;
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
