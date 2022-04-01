import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Final extends StatefulWidget {
  @override
  _FinalState createState() => _FinalState();
}

class _FinalState extends State<Final> {
  var usersref = FirebaseFirestore.instance.collection("quastions");

  List test = [];

  var loading = false;

  getDate() async {
    final prefs = await SharedPreferences.getInstance();
    final b = "${prefs.getString('list')}";
    var d = jsonDecode(b);

    setState(() {
      test = d;
      test.shuffle();
      loading = true;
    });
  }

  List erorr = [];

  result() {
    if (rate + notrate + 1 != 60) {
      return "لم تنهي الإختبار بعد";
    } else {
      if (notrate < 10) {
        return "ناجح";
      } else {
        return "راسب";
      }
    }
  }

  var rate = 0;

  var notrate = 0;

  var dam = 0;

  var m = 0;

  Next() async {
    final prefs = await SharedPreferences.getInstance();
    if (index + 1 == 60) {
      await prefs.setString('num', "${rate}/60");
      await prefs.setString('rate', Evaluation());
      _interstitialAd?.show();
      setState(() {
        m = 1;
      });
    } else {
      if (num == 0) {
        return null;
      }
      if (num == test[index]["true"]) {
        setState(() {
          dam = 1;
          index = index + 1;
          num = 0;
          rate = rate + 1;
        });
      } else {
        setState(() {
          dam = 2;
          trut.add(num);
          erorr.add(index);
          index = index + 1;
          num = 0;
          notrate = notrate + 1;
        });
      }
    }
  }

  var num = 0;

  var index = 0;
  var beta = 0;

  late Timer _timer;
  int _start = 60;
  int _start1 = 60;
  var v = 0;

  // TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    getDate();
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3527427928264280/6712761740',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
    super.initState();
  }

  var usersref1 = FirebaseFirestore.instance.collection("users");

  Evaluation() {
    if (notrate + rate + 1 != 60) {
      return "سيء";
    } else {
      if (notrate == 0) {
        return "ممتاز";
      }
      if (notrate < 4) {
        return "ممتاز";
      }
      if (notrate < 8) {
        return "جيد";
      }
      if (notrate < 10) {
        return "مقبول";
      }
      if (notrate < 15) {
        return "غير جيد";
      }
      return "سيء";
    }
  }

  info() {
    if (notrate + rate + 1 != 60) {
      return "حاول التدرب أكثر لانك بطيئ في الحل ...";
    } else {
      if (notrate == 0) {
        return "مستواك ممتاز , ولا يوجد نصائح";
      }
      if (notrate < 4) {
        return "مستواك ممتاز , ولا يوجد نصائح";
      }
      if (notrate < 8) {
        return "يجب أن تقوم بحل المزيد من الأسئلة لكي يصبح مستواك أفضل";
      }
      if (notrate < 10) {
        return "عليك حل المزيد من الأسئلة ومراجعة الدروس النظرية";
      }
      if (notrate < 15) {
        return "عليك أن تتدرب أكثر فأنت لست جاهز بعد";
      }
    }
    return "مستواك ضعيف , عليك المذاكرة أكثر ...";
  }

  Time() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
            child: Text(
          "لقد انتهى الوقت ...",
          style: TextStyle(
              fontSize: 30, fontFamily: "Abed", color: Colors.redAccent),
          textAlign: TextAlign.center,
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          "النتيجة : ${result()}",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Abed",
          ),
          textAlign: TextAlign.center,
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          "العلامة : ${rate + 1}/60",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Abed",
          ),
          textAlign: TextAlign.center,
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          "التقييم : ${Evaluation()}",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Abed",
          ),
          textAlign: TextAlign.center,
        )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (notrate == 0) {
                } else {
                  setState(() {
                    beta = 1;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(7)),
                child: Text(
                  "الإجابات الخاطئة",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Abed", color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/home");
              },
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(7)),
                child: Text(
                  "الصفحة الرئيسية",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Abed", color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.greenAccent,
            ),
            width: MediaQuery.of(context).size.width - 60,
            child: Container(
              margin: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topRight,
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Text(
                                    '${info()}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      fontFamily: "Abed",
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.lightbulb,
                              color: Colors.white,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Finish() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
            child: Text(
          "... لقد انتهى الإمتحان",
          style:
              TextStyle(fontSize: 30, fontFamily: "Abed", color: Colors.blue),
          textAlign: TextAlign.center,
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          "النتيجة : ${result()}",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Abed",
          ),
          textAlign: TextAlign.center,
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          "العلامة : ${rate}/60",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Abed",
          ),
          textAlign: TextAlign.center,
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          "التقييم : ${Evaluation()}",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Abed",
          ),
          textAlign: TextAlign.center,
        )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (notrate == 0) {
                } else {
                  setState(() {
                    beta = 1;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(7)),
                child: Text(
                  "الإجابات الخاطئة",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Abed", color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/home");
              },
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(7)),
                child: Text(
                  "الصفحة الرئيسية",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Abed", color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.greenAccent,
            ),
            width: MediaQuery.of(context).size.width - 60,
            child: Container(
              margin: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topRight,
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Text(
                                    '${info()}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      fontFamily: "Abed",
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.lightbulb,
                              color: Colors.white,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Erorrs() {
    return ListView.builder(
      itemCount: erorr.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              ListTile(
                trailing: Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: const Text(
                    "الأسئلة الخاطئة",
                    style: TextStyle(fontFamily: "Abed", fontSize: 20),
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_sharp,
                    size: 27,
                  ),
                  onPressed: () {
                    setState(() {
                      beta = 0;
                    });
                  },
                ),
              ),
              test[erorr[index]]["num"] == 4
                  ? Container(
                      color: Color.fromRGBO(245, 245, 245, 30),
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 20,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.end,
                                  children: [
                                    Text(
                                      "السؤال ${index + 1}",
                                      textAlign: TextAlign.end,
                                      style:
                                          const TextStyle(fontFamily: "Abed"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 30, left: 30),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                children: [
                                  Text(
                                    "${test[erorr[index]]["quastion"]}",
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(fontFamily: "Abed"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: test[erorr[index]]["imageurl"] != null
                                ? Container(
                                    margin: EdgeInsets.all(10),
                                    child: Center(
                                        child: CachedNetworkImage(
                                      width: MediaQuery.of(context).size.width -
                                          60,
                                      placeholder: (context, url) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("جاري تحميل الصورة"),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          CircularProgressIndicator()
                                        ],
                                      ),
                                      imageUrl:
                                          "${test[erorr[index]]["imageurl"]}",
                                    )),
                                  )
                                : Container(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: test[erorr[index]]["true"] == 1
                                  ? Colors.green
                                  : trut[index] == 1
                                      ? Colors.red
                                      : Color.fromRGBO(232, 232, 232, 30),
                            ),
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width - 60,
                            child: Container(
                              margin: EdgeInsets.all(12),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Wrap(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    '${test[erorr[index]]["answer1"]}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      fontFamily: "Abed",
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: test[erorr[index]]["true"] ==
                                                    1
                                                ? Icon(Icons.check_circle)
                                                : trut[index] == 1
                                                    ? Icon(Icons.cancel_rounded)
                                                    : Icon(Icons
                                                        .radio_button_off)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: test[erorr[index]]["true"] == 2
                                  ? Colors.green
                                  : trut[index] == 2
                                      ? Colors.red
                                      : Color.fromRGBO(232, 232, 232, 30),
                            ),
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width - 60,
                            child: Container(
                              margin: EdgeInsets.all(12),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Wrap(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    '${test[erorr[index]]["answer2"]}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      fontFamily: "Abed",
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: test[erorr[index]]["true"] ==
                                                    2
                                                ? Icon(Icons.check_circle)
                                                : trut[index] == 2
                                                    ? Icon(Icons.cancel_rounded)
                                                    : Icon(Icons
                                                        .radio_button_off)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: test[erorr[index]]["true"] == 3
                                  ? Colors.green
                                  : trut[index] == 3
                                      ? Colors.red
                                      : Color.fromRGBO(232, 232, 232, 30),
                            ),
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width - 60,
                            child: Container(
                              margin: EdgeInsets.all(12),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Wrap(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    '${test[erorr[index]]["answer3"]}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      fontFamily: "Abed",
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: test[erorr[index]]["true"] ==
                                                    3
                                                ? Icon(Icons.check_circle)
                                                : trut[index] == 3
                                                    ? Icon(Icons.cancel_rounded)
                                                    : Icon(Icons
                                                        .radio_button_off)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: test[erorr[index]]["true"] == 4
                                  ? Colors.green
                                  : trut[index] == 4
                                      ? Colors.red
                                      : Color.fromRGBO(232, 232, 232, 30),
                            ),
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width - 60,
                            child: Container(
                              margin: EdgeInsets.all(12),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Wrap(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    '${test[erorr[index]]["answer4"]}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      fontFamily: "Abed",
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: test[erorr[index]]["true"] ==
                                                    4
                                                ? Icon(Icons.check_circle)
                                                : trut[index] == 4
                                                    ? Icon(Icons.cancel_rounded)
                                                    : Icon(Icons
                                                        .radio_button_off)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : test[erorr[index]]["num"] == 3
                      ? Container(
                          color: Color.fromRGBO(245, 245, 245, 30),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 20,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Wrap(
                                      alignment: WrapAlignment.end,
                                      children: [
                                        Text(
                                          "السؤال ${index + 1}",
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                              fontFamily: "Abed"),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 30, left: 30),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Wrap(
                                    alignment: WrapAlignment.end,
                                    children: [
                                      Text(
                                        "${test[erorr[index]]["quastion"]}",
                                        textAlign: TextAlign.end,
                                        style:
                                            const TextStyle(fontFamily: "Abed"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: test[erorr[index]]["imageurl"] != null
                                    ? Container(
                                        margin: EdgeInsets.all(10),
                                        child: Center(
                                            child: CachedNetworkImage(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          placeholder: (context, url) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("جاري تحميل الصورة"),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              CircularProgressIndicator()
                                            ],
                                          ),
                                          imageUrl:
                                              "${test[erorr[index]]["imageurl"]}",
                                        )),
                                      )
                                    : Container(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: test[erorr[index]]["true"] == 1
                                      ? Colors.green
                                      : trut[index] == 1
                                          ? Colors.red
                                          : Color.fromRGBO(232, 232, 232, 30),
                                ),
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width - 60,
                                child: Container(
                                  margin: EdgeInsets.all(12),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Wrap(
                                                    children: [
                                                      Text(
                                                        '${test[erorr[index]]["answer1"]}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                          fontFamily: "Abed",
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: test[erorr[index]]
                                                            ["true"] ==
                                                        1
                                                    ? Icon(Icons.check_circle)
                                                    : trut[index] == 1
                                                        ? Icon(Icons
                                                            .cancel_rounded)
                                                        : Icon(Icons
                                                            .radio_button_off)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: test[erorr[index]]["true"] == 2
                                      ? Colors.green
                                      : trut[index] == 2
                                          ? Colors.red
                                          : Color.fromRGBO(232, 232, 232, 30),
                                ),
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width - 60,
                                child: Container(
                                  margin: EdgeInsets.all(12),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Wrap(
                                                    children: [
                                                      Text(
                                                        '${test[erorr[index]]["answer2"]}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                          fontFamily: "Abed",
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: test[erorr[index]]
                                                            ["true"] ==
                                                        2
                                                    ? Icon(Icons.check_circle)
                                                    : trut[index] == 2
                                                        ? Icon(Icons
                                                            .cancel_rounded)
                                                        : Icon(Icons
                                                            .radio_button_off)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: test[erorr[index]]["true"] == 3
                                      ? Colors.green
                                      : trut[index] == 3
                                          ? Colors.red
                                          : Color.fromRGBO(232, 232, 232, 30),
                                ),
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width - 60,
                                child: Container(
                                  margin: EdgeInsets.all(12),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Wrap(
                                                    children: [
                                                      Text(
                                                        '${test[erorr[index]]["answer3"]}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                          fontFamily: "Abed",
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: test[erorr[index]]
                                                            ["true"] ==
                                                        3
                                                    ? Icon(Icons.check_circle)
                                                    : trut[index] == 3
                                                        ? Icon(Icons
                                                            .cancel_rounded)
                                                        : Icon(Icons
                                                            .radio_button_off)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          color: Color.fromRGBO(245, 245, 245, 30),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 20,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Wrap(
                                      alignment: WrapAlignment.end,
                                      children: [
                                        Text(
                                          "السؤال ${index + 1}",
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                              fontFamily: "Abed"),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 30, left: 30),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Wrap(
                                    alignment: WrapAlignment.end,
                                    children: [
                                      Text(
                                        "${test[erorr[index]]["quastion"]}",
                                        textAlign: TextAlign.end,
                                        style:
                                            const TextStyle(fontFamily: "Abed"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: test[erorr[index]]["imageurl"] != null
                                    ? Container(
                                        margin: EdgeInsets.all(10),
                                        child: Center(
                                            child: CachedNetworkImage(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          placeholder: (context, url) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("جاري تحميل الصورة"),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              CircularProgressIndicator()
                                            ],
                                          ),
                                          imageUrl:
                                              "${test[erorr[index]]["imageurl"]}",
                                        )),
                                      )
                                    : Container(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: test[erorr[index]]["true"] == 1
                                      ? Colors.green
                                      : trut[index] == 1
                                          ? Colors.red
                                          : Color.fromRGBO(232, 232, 232, 30),
                                ),
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width - 60,
                                child: Container(
                                  margin: EdgeInsets.all(12),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Wrap(
                                                    children: [
                                                      Text(
                                                        '${test[erorr[index]]["answer1"]}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                          fontFamily: "Abed",
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: test[erorr[index]]
                                                            ["true"] ==
                                                        1
                                                    ? Icon(Icons.check_circle)
                                                    : trut[index] == 1
                                                        ? Icon(Icons
                                                            .cancel_rounded)
                                                        : Icon(Icons
                                                            .radio_button_off)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: test[erorr[index]]["true"] == 2
                                      ? Colors.green
                                      : trut[index] == 2
                                          ? Colors.red
                                          : Color.fromRGBO(232, 232, 232, 30),
                                ),
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width - 60,
                                child: Container(
                                  margin: EdgeInsets.all(12),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Wrap(
                                                    children: [
                                                      Text(
                                                        '${test[erorr[index]]["answer2"]}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                          fontFamily: "Abed",
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: test[erorr[index]]
                                                            ["true"] ==
                                                        2
                                                    ? Icon(Icons.check_circle)
                                                    : trut[index] == 2
                                                        ? Icon(Icons
                                                            .cancel_rounded)
                                                        : Icon(Icons
                                                            .radio_button_off)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
            ],
          );
        }
        //-------------------------================الأسئلة=============================================================================
        return test[erorr[index]]["num"] == 4
            ? Container(
                color: Color.fromRGBO(245, 245, 245, 30),
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.end,
                            children: [
                              Text(
                                "السؤال ${index + 1}",
                                textAlign: TextAlign.end,
                                style: const TextStyle(fontFamily: "Abed"),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 30, left: 30),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            Text(
                              "${test[erorr[index]]["quastion"]}",
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontFamily: "Abed"),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: test[erorr[index]]["imageurl"] != null
                          ? Container(
                              margin: EdgeInsets.all(10),
                              child: Center(
                                  child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.width - 60,
                                placeholder: (context, url) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("جاري تحميل الصورة"),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    CircularProgressIndicator()
                                  ],
                                ),
                                imageUrl: "${test[erorr[index]]["imageurl"]}",
                              )),
                            )
                          : Container(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: test[erorr[index]]["true"] == 1
                            ? Colors.green
                            : trut[index] == 1
                                ? Colors.red
                                : Color.fromRGBO(232, 232, 232, 30),
                      ),
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 60,
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              '${test[erorr[index]]["answer1"]}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: test[erorr[index]]["true"] == 1
                                          ? Icon(Icons.check_circle)
                                          : trut[index] == 1
                                              ? Icon(Icons.cancel_rounded)
                                              : Icon(Icons.radio_button_off)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: test[erorr[index]]["true"] == 2
                            ? Colors.green
                            : trut[index] == 2
                                ? Colors.red
                                : Color.fromRGBO(232, 232, 232, 30),
                      ),
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 60,
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              '${test[erorr[index]]["answer2"]}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: test[erorr[index]]["true"] == 2
                                          ? Icon(Icons.check_circle)
                                          : trut[index] == 2
                                              ? Icon(Icons.cancel_rounded)
                                              : Icon(Icons.radio_button_off)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: test[erorr[index]]["true"] == 3
                            ? Colors.green
                            : trut[index] == 3
                                ? Colors.red
                                : Color.fromRGBO(232, 232, 232, 30),
                      ),
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 60,
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              '${test[erorr[index]]["answer3"]}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: test[erorr[index]]["true"] == 3
                                          ? Icon(Icons.check_circle)
                                          : trut[index] == 3
                                              ? Icon(Icons.cancel_rounded)
                                              : Icon(Icons.radio_button_off)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: test[erorr[index]]["true"] == 4
                            ? Colors.green
                            : trut[index] == 4
                                ? Colors.red
                                : Color.fromRGBO(232, 232, 232, 30),
                      ),
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 60,
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              '${test[erorr[index]]["answer4"]}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: test[erorr[index]]["true"] == 4
                                          ? Icon(Icons.check_circle)
                                          : trut[index] == 4
                                              ? Icon(Icons.cancel_rounded)
                                              : Icon(Icons.radio_button_off)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : test[erorr[index]]["num"] == 3
                ? Container(
                    color: Color.fromRGBO(245, 245, 245, 30),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Wrap(
                                alignment: WrapAlignment.end,
                                children: [
                                  Text(
                                    "السؤال ${index + 1}",
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(fontFamily: "Abed"),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30, left: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [
                                Text(
                                  "${test[erorr[index]]["quastion"]}",
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(fontFamily: "Abed"),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: test[erorr[index]]["imageurl"] != null
                              ? Container(
                                  margin: EdgeInsets.all(10),
                                  child: Center(
                                      child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    placeholder: (context, url) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("جاري تحميل الصورة"),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        CircularProgressIndicator()
                                      ],
                                    ),
                                    imageUrl:
                                        "${test[erorr[index]]["imageurl"]}",
                                  )),
                                )
                              : Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: test[erorr[index]]["true"] == 1
                                ? Colors.green
                                : trut[index] == 1
                                    ? Colors.red
                                    : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Wrap(
                                              children: [
                                                Text(
                                                  '${test[erorr[index]]["answer1"]}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontFamily: "Abed",
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: test[erorr[index]]["true"] == 1
                                              ? Icon(Icons.check_circle)
                                              : trut[index] == 1
                                                  ? Icon(Icons.cancel_rounded)
                                                  : Icon(
                                                      Icons.radio_button_off)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: test[erorr[index]]["true"] == 2
                                ? Colors.green
                                : trut[index] == 2
                                    ? Colors.red
                                    : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Wrap(
                                              children: [
                                                Text(
                                                  '${test[erorr[index]]["answer2"]}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontFamily: "Abed",
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: test[erorr[index]]["true"] == 2
                                              ? Icon(Icons.check_circle)
                                              : trut[index] == 2
                                                  ? Icon(Icons.cancel_rounded)
                                                  : Icon(
                                                      Icons.radio_button_off)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: test[erorr[index]]["true"] == 3
                                ? Colors.green
                                : trut[index] == 3
                                    ? Colors.red
                                    : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Wrap(
                                              children: [
                                                Text(
                                                  '${test[erorr[index]]["answer3"]}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontFamily: "Abed",
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: test[erorr[index]]["true"] == 3
                                              ? Icon(Icons.check_circle)
                                              : trut[index] == 3
                                                  ? Icon(Icons.cancel_rounded)
                                                  : Icon(
                                                      Icons.radio_button_off)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    color: Color.fromRGBO(245, 245, 245, 30),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Wrap(
                                alignment: WrapAlignment.end,
                                children: [
                                  Text(
                                    "السؤال ${index + 1}",
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(fontFamily: "Abed"),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30, left: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [
                                Text(
                                  "${test[erorr[index]]["quastion"]}",
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(fontFamily: "Abed"),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: test[erorr[index]]["imageurl"] != null
                              ? Container(
                                  margin: EdgeInsets.all(10),
                                  child: Center(
                                      child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    placeholder: (context, url) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("جاري تحميل الصورة"),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        CircularProgressIndicator()
                                      ],
                                    ),
                                    imageUrl:
                                        "${test[erorr[index]]["imageurl"]}",
                                  )),
                                )
                              : Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: test[erorr[index]]["true"] == 1
                                ? Colors.green
                                : trut[index] == 1
                                    ? Colors.red
                                    : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Wrap(
                                              children: [
                                                Text(
                                                  '${test[erorr[index]]["answer1"]}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontFamily: "Abed",
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: test[erorr[index]]["true"] == 1
                                              ? Icon(Icons.check_circle)
                                              : trut[index] == 1
                                                  ? Icon(Icons.cancel_rounded)
                                                  : Icon(
                                                      Icons.radio_button_off)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: test[erorr[index]]["true"] == 2
                                ? Colors.green
                                : trut[index] == 2
                                    ? Colors.red
                                    : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Wrap(
                                              children: [
                                                Text(
                                                  '${test[erorr[index]]["answer2"]}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontFamily: "Abed",
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: test[erorr[index]]["true"] == 2
                                              ? Icon(Icons.check_circle)
                                              : trut[index] == 2
                                                  ? Icon(Icons.cancel_rounded)
                                                  : Icon(
                                                      Icons.radio_button_off)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
        //=----------------------------==========================================================================================
      },
    );
  }

  var dispose1 = 0;
  var trut = [];

  void startTimer1() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (dispose1 == 0) {
          if (m == 0) {
            if (_start1 == 0) {
              setState(() {
                v = 1;
                timer.cancel();
              });
            } else {
              setState(() {
                _start1--;
              });
            }
          } else {
            timer.cancel();
          }
        }
      },
    );
  }

  var k = 0;

  void startTimer() {
    const oneSec = const Duration(minutes: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            startTimer1();
            k = 1;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    dispose1 = 1;
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (beta == 1) {
          setState(() {
            beta = 0;
          });
          return false;
        }
        if (m == 1 || v == 1) {
          Navigator.of(context).pushReplacementNamed("/home");
        } else {
          AwesomeDialog(
            btnOk: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/home");
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(7)),
                child: Text(
                  "الخروج",
                  style: TextStyle(
                      fontFamily: "Abed", fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            btnCancel: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(7)),
                child: Text(
                  "الرجوع",
                  style: TextStyle(
                      fontFamily: "Abed", fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.BOTTOMSLIDE,
            body: Column(
              children: [
                Text(
                  "هل تريد الخروج من الإمتحان",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: "Abed"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "في حال قمت بالخروج سوف تفقد تقدمك ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Abed", fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ).show();
          return false;
        }
        return false;
      },
      child: Scaffold(
        floatingActionButton: m == 0
            ? v == 0
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(10),
                    child: Text(
                      k == 0 ? "متبقي $_start دقيقة" : "متبقي $_start1 ثانية",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Abed"),
                    ),
                  )
                : null
            : null,
        //------------------------------------------------------------------------------------------------------------------------------
        body: SafeArea(
          child: m == 0
              ? loading == false
                  ? Center(
                      child: Container(
                          width: 180,
                          child: Ink.image(
                              image: AssetImage("assets/images/loading.gif"))))
                  : v == 0
                      ? Container(
                          color: Color.fromRGBO(245, 245, 245, 30),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 20,
                          child: test[index]["num"] == 4
                              ? test[index]["imageurl"] == null
                                  ? ListView(
                                      children: [
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 8,
                                              ),
                                              child: ListTile(
                                                trailing: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child: const Text(
                                                    "الإختبار النظري التجريبي",
                                                    style: TextStyle(
                                                        fontFamily: "Abed",
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                leading: InkWell(
                                                  onTap: () {
                                                    if (m == 1 || v == 1) {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              "/home");
                                                    } else {
                                                      AwesomeDialog(
                                                        btnOk: InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacementNamed(
                                                                    "/home");
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .redAccent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7)),
                                                            child: Text(
                                                              "الخروج",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Abed",
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                        btnCancel: InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .blueAccent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7)),
                                                            child: Text(
                                                              "الرجوع",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Abed",
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                        context: context,
                                                        dialogType:
                                                            DialogType.WARNING,
                                                        animType: AnimType
                                                            .BOTTOMSLIDE,
                                                        body: Column(
                                                          children: [
                                                            Text(
                                                              "هل تريد الخروج من الإمتحان",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily:
                                                                      "Abed"),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              child: Text(
                                                                "في حال قمت بالخروج سوف تفقد تقدمك ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Abed",
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                          ],
                                                        ),
                                                      ).show();
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.exit_to_app,
                                                    size: 27,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 15, top: 18, bottom: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Wrap(
                                                alignment: WrapAlignment.end,
                                                children: [
                                                  Text(
                                                    "السؤال ${1 + index}",
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        fontFamily: "Abed"),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 30, left: 30),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Wrap(
                                              alignment: WrapAlignment.end,
                                              children: [
                                                Text(
                                                  "${test[index]["quastion"]}",
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      fontFamily: "Abed"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: num == 1
                                                ? Colors.green
                                                : Color.fromRGBO(
                                                    232, 232, 232, 30),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                num = 1;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(12),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 7,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Wrap(
                                                                children: [
                                                                  Text(
                                                                    '${test[index]["answer1"]}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Icon(
                                                              Icons.circle,
                                                              color:
                                                                  Colors.black,
                                                              size: 15,
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: num == 2
                                                ? Colors.green
                                                : Color.fromRGBO(
                                                    232, 232, 232, 30),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                num = 2;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(12),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 7,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Wrap(
                                                                children: [
                                                                  Text(
                                                                    '${test[index]["answer2"]}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Icon(
                                                              Icons.circle,
                                                              color:
                                                                  Colors.black,
                                                              size: 15,
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: num == 3
                                                ? Colors.green
                                                : Color.fromRGBO(
                                                    232, 232, 232, 30),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                num = 3;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(12),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 7,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Wrap(
                                                                children: [
                                                                  Text(
                                                                    '${test[index]["answer3"]}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Icon(
                                                            Icons.circle,
                                                            color: Colors.black,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: num == 4
                                                ? Colors.green
                                                : Color.fromRGBO(
                                                    232, 232, 232, 30),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                num = 4;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(12),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 7,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Wrap(
                                                                children: [
                                                                  Text(
                                                                    '${test[index]["answer4"]}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Icon(
                                                            Icons.circle,
                                                            color: Colors.black,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.blueAccent,
                                              ),
                                              onPressed: () {
                                                Next();
                                              },
                                              child: Text(
                                                "التالي",
                                                style: TextStyle(
                                                    fontFamily: "Abed"),
                                              )),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(15),
                                              margin: EdgeInsets.only(
                                                  left: 15,
                                                  top: 15,
                                                  bottom: 15),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blue)),
                                              child: Row(
                                                children: [
                                                  dam == 1
                                                      ? Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                          size: 20,
                                                        )
                                                      : dam == 0
                                                          ? Text(
                                                              "إبدأ",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Abed"),
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .close_outlined,
                                                              size: 20,
                                                            ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    "الإجابة السابقة ",
                                                    style: TextStyle(
                                                        fontFamily: "Abed",
                                                        color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(15),
                                              margin: EdgeInsets.only(
                                                  left: 15,
                                                  top: 15,
                                                  bottom: 15),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blue)),
                                              child: Row(
                                                children: [
                                                  Text("${notrate}",
                                                      style: TextStyle(
                                                          fontFamily: "Abed")),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "الإجابات الخاظئة",
                                                    style: TextStyle(
                                                        fontFamily: "Abed",
                                                        color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  : ListView(
                                      children: [
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 8,
                                              ),
                                              child: ListTile(
                                                trailing: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child: const Text(
                                                    "الاختبار النظري التجريبي",
                                                    style: TextStyle(
                                                        fontFamily: "Abed",
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                leading: InkWell(
                                                  onTap: () {
                                                    if (m == 1 || v == 1) {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              "/home");
                                                    } else {
                                                      AwesomeDialog(
                                                        btnOk: InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacementNamed(
                                                                    "/home");
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .redAccent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7)),
                                                            child: Text(
                                                              "الخروج",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Abed",
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                        btnCancel: InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .blueAccent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7)),
                                                            child: Text(
                                                              "الرجوع",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Abed",
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                        context: context,
                                                        dialogType:
                                                            DialogType.WARNING,
                                                        animType: AnimType
                                                            .BOTTOMSLIDE,
                                                        body: Column(
                                                          children: [
                                                            Text(
                                                              "هل تريد الخروج من الإمتحان",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily:
                                                                      "Abed"),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              child: Text(
                                                                "في حال قمت بالخروج سوف تفقد تقدمك ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Abed",
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                          ],
                                                        ),
                                                      ).show();
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.exit_to_app,
                                                    size: 27,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 15, top: 18, bottom: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Wrap(
                                                alignment: WrapAlignment.end,
                                                children: [
                                                  Text(
                                                    "السؤال ${1 + index}",
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        fontFamily: "Abed"),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 30, left: 30),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Wrap(
                                              alignment: WrapAlignment.end,
                                              children: [
                                                Text(
                                                  "${test[index]["quastion"]}",
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      fontFamily: "Abed"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: Center(
                                              child: CachedNetworkImage(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                60,
                                            placeholder: (context, url) => Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("جاري تحميل الصورة"),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                CircularProgressIndicator()
                                              ],
                                            ),
                                            imageUrl:
                                                "${test[index]["imageurl"]}",
                                          )),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: num == 1
                                                ? Colors.green
                                                : Color.fromRGBO(
                                                    232, 232, 232, 30),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                num = 1;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(12),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 7,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Wrap(
                                                                children: [
                                                                  Text(
                                                                    '${test[index]["answer1"]}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Icon(
                                                              Icons.circle,
                                                              color:
                                                                  Colors.black,
                                                              size: 15,
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: num == 2
                                                ? Colors.green
                                                : Color.fromRGBO(
                                                    232, 232, 232, 30),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                num = 2;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(12),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 7,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Wrap(
                                                                children: [
                                                                  Text(
                                                                    '${test[index]["answer2"]}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Icon(
                                                              Icons.circle,
                                                              color:
                                                                  Colors.black,
                                                              size: 15,
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: num == 3
                                                ? Colors.green
                                                : Color.fromRGBO(
                                                    232, 232, 232, 30),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                num = 3;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(12),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 7,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Wrap(
                                                                children: [
                                                                  Text(
                                                                    '${test[index]["answer3"]}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Icon(
                                                            Icons.circle,
                                                            color: Colors.black,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: num == 4
                                                ? Colors.green
                                                : Color.fromRGBO(
                                                    232, 232, 232, 30),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                num = 4;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(12),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 7,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Wrap(
                                                                children: [
                                                                  Text(
                                                                    '${test[index]["answer4"]}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Icon(
                                                            Icons.circle,
                                                            color: Colors.black,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blueAccent,
                                            ),
                                            onPressed: () {
                                              Next();
                                            },
                                            child: Text(
                                              "التالي",
                                              style:
                                                  TextStyle(fontFamily: "Abed"),
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(15),
                                              margin: EdgeInsets.only(
                                                  left: 15,
                                                  top: 15,
                                                  bottom: 15),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blue)),
                                              child: Row(
                                                children: [
                                                  dam == 1
                                                      ? Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                          size: 20,
                                                        )
                                                      : dam == 0
                                                          ? Text(
                                                              "إبدأ",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Abed"),
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .close_outlined,
                                                              size: 20,
                                                            ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    "الإجابة السابقة ",
                                                    style: TextStyle(
                                                        fontFamily: "Abed",
                                                        color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(15),
                                              margin: EdgeInsets.only(
                                                  left: 15,
                                                  top: 15,
                                                  bottom: 15),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blue)),
                                              child: Row(
                                                children: [
                                                  Text("${notrate}",
                                                      style: TextStyle(
                                                          fontFamily: "Abed")),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "الإجابات الخاظئة",
                                                    style: TextStyle(
                                                        fontFamily: "Abed",
                                                        color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                              : test[index]["num"] == 3
                                  ? test[index]["imageurl"] == null
                                      ? ListView(
                                          children: [
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    right: 8,
                                                  ),
                                                  child: ListTile(
                                                      trailing: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 5),
                                                        child: const Text(
                                                          "اختبار النظري التجريبي",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Abed",
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      leading: InkWell(
                                                        onTap: () {
                                                          if (m == 1 ||
                                                              v == 1) {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacementNamed(
                                                                    "/home");
                                                          } else {
                                                            AwesomeDialog(
                                                              btnOk: InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pushReplacementNamed(
                                                                          "/home");
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              12),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .redAccent,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              7)),
                                                                  child: Text(
                                                                    "الخروج",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Abed",
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              btnCancel:
                                                                  InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              12),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blueAccent,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              7)),
                                                                  child: Text(
                                                                    "الرجوع",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Abed",
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              context: context,
                                                              dialogType:
                                                                  DialogType
                                                                      .WARNING,
                                                              animType: AnimType
                                                                  .BOTTOMSLIDE,
                                                              body: Column(
                                                                children: [
                                                                  Text(
                                                                    "هل تريد الخروج من الإمتحان",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            "Abed"),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                    child: Text(
                                                                      "في حال قمت بالخروج سوف تفقد تقدمك ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Abed",
                                                                          fontSize:
                                                                              13),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ).show();
                                                          }
                                                        },
                                                        child: const Icon(
                                                          Icons.exit_to_app,
                                                          size: 27,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 15,
                                                  top: 18,
                                                  bottom: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Wrap(
                                                    alignment:
                                                        WrapAlignment.end,
                                                    children: [
                                                      Text(
                                                        "السؤال ${1 + index}",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            fontFamily: "Abed"),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 30, left: 30),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  alignment: WrapAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${test[index]["quastion"]}",
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                          fontFamily: "Abed"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: num == 1
                                                    ? Colors.green
                                                    : Color.fromRGBO(
                                                        232, 232, 232, 30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    num = 1;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Wrap(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        '${test[index]["answer1"]}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              "Abed",
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Icon(
                                                                  Icons.circle,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: num == 2
                                                    ? Colors.green
                                                    : Color.fromRGBO(
                                                        232, 232, 232, 30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    num = 2;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Wrap(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        '${test[index]["answer2"]}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              "Abed",
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Icon(
                                                                  Icons.circle,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: num == 3
                                                    ? Colors.green
                                                    : Color.fromRGBO(
                                                        232, 232, 232, 30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    num = 3;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Wrap(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        '${test[index]["answer3"]}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              "Abed",
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Icon(
                                                                Icons.circle,
                                                                color: Colors
                                                                    .black,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.blueAccent,
                                                ),
                                                onPressed: () {
                                                  Next();
                                                },
                                                child: Text(
                                                  "التالي",
                                                  style: TextStyle(
                                                      fontFamily: "Abed"),
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  margin: EdgeInsets.only(
                                                      left: 15,
                                                      top: 15,
                                                      bottom: 15),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue)),
                                                  child: Row(
                                                    children: [
                                                      dam == 1
                                                          ? Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.green,
                                                              size: 20,
                                                            )
                                                          : dam == 0
                                                              ? Text(
                                                                  "إبدأ",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Abed"),
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .close_outlined,
                                                                  size: 20,
                                                                ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        "الإجابة السابقة ",
                                                        style: TextStyle(
                                                            fontFamily: "Abed",
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  margin: EdgeInsets.only(
                                                      left: 15,
                                                      top: 15,
                                                      bottom: 15),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue)),
                                                  child: Row(
                                                    children: [
                                                      Text("${notrate}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Abed")),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "الإجابات الخاظئة",
                                                        style: TextStyle(
                                                            fontFamily: "Abed",
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      : ListView(
                                          children: [
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    right: 8,
                                                  ),
                                                  child: ListTile(
                                                    trailing: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: const Text(
                                                        "الإختبار النظري التجريبي",
                                                        style: TextStyle(
                                                            fontFamily: "Abed",
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                    leading: InkWell(
                                                      onTap: () {
                                                        if (m == 1 || v == 1) {
                                                          Navigator.of(context)
                                                              .pushReplacementNamed(
                                                                  "/home");
                                                        } else {
                                                          AwesomeDialog(
                                                            btnOk: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushReplacementNamed(
                                                                        "/home");
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            12),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7)),
                                                                child: Text(
                                                                  "الخروج",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                            btnCancel: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            12),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7)),
                                                                child: Text(
                                                                  "الرجوع",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .WARNING,
                                                            animType: AnimType
                                                                .BOTTOMSLIDE,
                                                            body: Column(
                                                              children: [
                                                                Text(
                                                                  "هل تريد الخروج من الإمتحان",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontFamily:
                                                                          "Abed"),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                  child: Text(
                                                                    "في حال قمت بالخروج سوف تفقد تقدمك ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Abed",
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                              ],
                                                            ),
                                                          ).show();
                                                        }
                                                      },
                                                      child: const Icon(
                                                        Icons.exit_to_app,
                                                        size: 27,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 15,
                                                  top: 18,
                                                  bottom: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Wrap(
                                                    alignment:
                                                        WrapAlignment.end,
                                                    children: [
                                                      Text(
                                                        "السؤال ${1 + index}",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            fontFamily: "Abed"),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 30, left: 30),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  alignment: WrapAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${test[index]["quastion"]}",
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                          fontFamily: "Abed"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child: Center(
                                                  child: CachedNetworkImage(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    60,
                                                placeholder: (context, url) =>
                                                    Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("جاري تحميل الصورة"),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    CircularProgressIndicator()
                                                  ],
                                                ),
                                                imageUrl:
                                                    "${test[index]["imageurl"]}",
                                              )),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: num == 1
                                                    ? Colors.green
                                                    : Color.fromRGBO(
                                                        232, 232, 232, 30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    num = 1;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Wrap(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        '${test[index]["answer1"]}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              "Abed",
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Icon(
                                                                  Icons.circle,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: num == 2
                                                    ? Colors.green
                                                    : Color.fromRGBO(
                                                        232, 232, 232, 30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    num = 2;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Wrap(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        '${test[index]["answer2"]}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              "Abed",
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Icon(
                                                                  Icons.circle,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: num == 3
                                                    ? Colors.green
                                                    : Color.fromRGBO(
                                                        232, 232, 232, 30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    num = 3;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Wrap(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        '${test[index]["answer3"]}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              "Abed",
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Icon(
                                                                Icons.circle,
                                                                color: Colors
                                                                    .black,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.blueAccent,
                                                ),
                                                onPressed: () {
                                                  Next();
                                                },
                                                child: Text(
                                                  "التالي",
                                                  style: TextStyle(
                                                      fontFamily: "Abed"),
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  margin: EdgeInsets.only(
                                                      left: 15,
                                                      top: 15,
                                                      bottom: 15),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue)),
                                                  child: Row(
                                                    children: [
                                                      dam == 1
                                                          ? Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.green,
                                                              size: 20,
                                                            )
                                                          : dam == 0
                                                              ? Text(
                                                                  "إبدأ",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Abed"),
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .close_outlined,
                                                                  size: 20,
                                                                ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        "الإجابة السابقة ",
                                                        style: TextStyle(
                                                            fontFamily: "Abed",
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  margin: EdgeInsets.only(
                                                      left: 15,
                                                      top: 15,
                                                      bottom: 15),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue)),
                                                  child: Row(
                                                    children: [
                                                      Text("${notrate}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Abed")),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "الإجابات الخاظئة",
                                                        style: TextStyle(
                                                            fontFamily: "Abed",
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                  : test[index]["imageurl"] == null
                                      ? ListView(
                                          children: [
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    right: 8,
                                                  ),
                                                  child: ListTile(
                                                    trailing: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: const Text(
                                                        "الإختبار النظري التجريبي",
                                                        style: TextStyle(
                                                            fontFamily: "Abed",
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                    leading: InkWell(
                                                      onTap: () {
                                                        if (m == 1 || v == 1) {
                                                          Navigator.of(context)
                                                              .pushReplacementNamed(
                                                                  "/home");
                                                        } else {
                                                          AwesomeDialog(
                                                            btnOk: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushReplacementNamed(
                                                                        "/home");
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            12),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7)),
                                                                child: Text(
                                                                  "الخروج",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                            btnCancel: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            12),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7)),
                                                                child: Text(
                                                                  "الرجوع",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .WARNING,
                                                            animType: AnimType
                                                                .BOTTOMSLIDE,
                                                            body: Column(
                                                              children: [
                                                                Text(
                                                                  "هل تريد الخروج من الإمتحان",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontFamily:
                                                                          "Abed"),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                  child: Text(
                                                                    "في حال قمت بالخروج سوف تفقد تقدمك ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Abed",
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                              ],
                                                            ),
                                                          ).show();
                                                        }
                                                      },
                                                      child: const Icon(
                                                        Icons.exit_to_app,
                                                        size: 27,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 15,
                                                  top: 18,
                                                  bottom: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Wrap(
                                                    alignment:
                                                        WrapAlignment.end,
                                                    children: [
                                                      Text(
                                                        "السؤال ${1 + index}",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            fontFamily: "Abed"),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 30, left: 30),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  alignment: WrapAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${test[index]["quastion"]}",
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                          fontFamily: "Abed"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: num == 1
                                                    ? Colors.green
                                                    : Color.fromRGBO(
                                                        232, 232, 232, 30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    num = 1;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Wrap(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        '${test[index]["answer1"]}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              "Abed",
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Icon(
                                                                  Icons.circle,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: num == 2
                                                    ? Colors.green
                                                    : Color.fromRGBO(
                                                        232, 232, 232, 30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    num = 2;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Wrap(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        '${test[index]["answer2"]}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              "Abed",
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Icon(
                                                                  Icons.circle,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.blueAccent,
                                                ),
                                                onPressed: () {
                                                  Next();
                                                },
                                                child: Text(
                                                  "التالي",
                                                  style: TextStyle(
                                                      fontFamily: "Abed"),
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  margin: EdgeInsets.only(
                                                      left: 15,
                                                      top: 15,
                                                      bottom: 15),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue)),
                                                  child: Row(
                                                    children: [
                                                      dam == 1
                                                          ? Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.green,
                                                              size: 20,
                                                            )
                                                          : dam == 0
                                                              ? Text(
                                                                  "إبدأ",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Abed"),
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .close_outlined,
                                                                  size: 20,
                                                                ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        "الإجابة السابقة ",
                                                        style: TextStyle(
                                                            fontFamily: "Abed",
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  margin: EdgeInsets.only(
                                                      left: 15,
                                                      top: 15,
                                                      bottom: 15),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue)),
                                                  child: Row(
                                                    children: [
                                                      Text("${notrate}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Abed")),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "الإجابات الخاظئة",
                                                        style: TextStyle(
                                                            fontFamily: "Abed",
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      : ListView(
                                          children: [
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    right: 8,
                                                  ),
                                                  child: ListTile(
                                                    trailing: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: const Text(
                                                        "الإختبار النظري التجريبي",
                                                        style: TextStyle(
                                                            fontFamily: "Abed",
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                    leading: InkWell(
                                                      onTap: () {
                                                        if (m == 1 || v == 1) {
                                                          Navigator.of(context)
                                                              .pushReplacementNamed(
                                                                  "/home");
                                                        } else {
                                                          AwesomeDialog(
                                                            btnOk: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushReplacementNamed(
                                                                        "/home");
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            12),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7)),
                                                                child: Text(
                                                                  "الخروج",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                            btnCancel: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            12),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7)),
                                                                child: Text(
                                                                  "الرجوع",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Abed",
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .WARNING,
                                                            animType: AnimType
                                                                .BOTTOMSLIDE,
                                                            body: Column(
                                                              children: [
                                                                Text(
                                                                  "هل تريد الخروج من الإمتحان",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontFamily:
                                                                          "Abed"),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                  child: Text(
                                                                    "في حال قمت بالخروج سوف تفقد تقدمك ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Abed",
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                              ],
                                                            ),
                                                          ).show();
                                                        }
                                                      },
                                                      child: const Icon(
                                                        Icons.exit_to_app,
                                                        size: 27,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 15,
                                                  top: 18,
                                                  bottom: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Wrap(
                                                    alignment:
                                                        WrapAlignment.end,
                                                    children: [
                                                      Text(
                                                        "السؤال ${1 + index}",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            fontFamily: "Abed"),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 30, left: 30),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Wrap(
                                                  alignment: WrapAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${test[index]["quastion"]}",
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                          fontFamily: "Abed"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child: Center(
                                                  child: CachedNetworkImage(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    60,
                                                placeholder: (context, url) =>
                                                    Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("جاري تحميل الصورة"),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    CircularProgressIndicator()
                                                  ],
                                                ),
                                                imageUrl:
                                                    "${test[index]["imageurl"]}",
                                              )),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: num == 1
                                                    ? Colors.green
                                                    : Color.fromRGBO(
                                                        232, 232, 232, 30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    num = 1;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Wrap(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        '${test[index]["answer1"]}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              "Abed",
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Icon(
                                                                  Icons.circle,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: num == 2
                                                    ? Colors.green
                                                    : Color.fromRGBO(
                                                        232, 232, 232, 30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    num = 2;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Wrap(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        '${test[index]["answer2"]}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              "Abed",
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Icon(
                                                                  Icons.circle,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.blueAccent,
                                                ),
                                                onPressed: () {
                                                  Next();
                                                },
                                                child: Text(
                                                  "التالي",
                                                  style: TextStyle(
                                                      fontFamily: "Abed"),
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  margin: EdgeInsets.only(
                                                      left: 15,
                                                      top: 15,
                                                      bottom: 15),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue)),
                                                  child: Row(
                                                    children: [
                                                      dam == 1
                                                          ? Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.green,
                                                              size: 20,
                                                            )
                                                          : dam == 0
                                                              ? Text(
                                                                  "إبدأ",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Abed"),
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .close_outlined,
                                                                  size: 20,
                                                                ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        "الإجابة السابقة ",
                                                        style: TextStyle(
                                                            fontFamily: "Abed",
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  margin: EdgeInsets.only(
                                                      left: 15,
                                                      top: 15,
                                                      bottom: 15),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue)),
                                                  child: Row(
                                                    children: [
                                                      Text("${notrate}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Abed")),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "الإجابات الخاظئة",
                                                        style: TextStyle(
                                                            fontFamily: "Abed",
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ))
                      : beta == 0
                          ? Time()
                          : Erorrs()
              : beta == 0
                  ? Finish()
                  : Erorrs(),
        ),
      ),
    );
  }
}
