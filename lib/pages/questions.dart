import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Questions1 extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions1> {
  final _advancedDrawerController = AdvancedDrawerController();

  var questions = [];


  @override
  void initState() {
    // TODO: implement initState
    getDate();
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-3527427928264280/6998883965",
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd1 = BannerAd(
      adUnitId: "ca-app-pub-3527427928264280/6998883965",
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady1 = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady1 = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd2 = BannerAd(
      adUnitId: "ca-app-pub-3527427928264280/6998883965",
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady2 = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady2 = false;
          ad.dispose();
        },
      ),
    );


    _bannerAd.load();
    _bannerAd1.load();
    _bannerAd2.load();

    super.initState();
  }
  var usersref = FirebaseFirestore.instance.collection("quastions");
  var loading = false;
  getDate() async {
    final prefs = await SharedPreferences.getInstance();
    final b = "${prefs.getString('list')}";
    var d = jsonDecode(b);
    setState(() {
      questions = d;
      loading = true;
    });

  }

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  late BannerAd _bannerAd1;
  bool _isBannerAdReady1 = false;
  late BannerAd _bannerAd2;
  bool _isBannerAdReady2 = false;

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();
    _bannerAd1.dispose();
    _bannerAd2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Color.fromRGBO(57, 119, 255, 1),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        //------------------------------------------------------------------------------------------------------------------------------
        body: loading == true ? ListView.builder(
          itemCount: questions.length,
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
                        "أسئلة النظري المقترحة",
                        style: TextStyle(fontFamily: "Abed", fontSize: 20),
                      ),
                    ),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.dehaze,
                        size: 27,
                      ),
                      onPressed: () {
                        _advancedDrawerController.showDrawer();
                      },
                    ),
                  ),
                  questions[index]["num"] == 4  ? Container(
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
                                children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                    fontFamily: "Abed"
                                ),)],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        Container(
                          child: questions[index]["imageurl"] != null  ? Container(
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
                                  imageUrl: "${questions[index]["imageurl"]}",
                                )),
                          ) : Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      flex : 7,
                                      child: Container(

                                        padding: EdgeInsets.all(5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Wrap(
                                            children: [
                                              Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      flex : 7,
                                      child: Container(

                                        padding: EdgeInsets.all(5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Wrap(
                                            children: [
                                              Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: questions[index]["true"] == 3 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      flex : 7,
                                      child: Container(

                                        padding: EdgeInsets.all(5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Wrap(
                                            children: [
                                              Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: questions[index]["true"] == 3 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: questions[index]["true"] == 4 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      flex : 7,
                                      child: Container(

                                        padding: EdgeInsets.all(5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Wrap(
                                            children: [
                                              Text('${questions[index]["answer4"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: questions[index]["true"] == 4 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) :
                  questions[index]["num"] == 3  ?  Container(
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
                                children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                    fontFamily: "Abed"
                                ),)],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        Container(
                          child: questions[index]["imageurl"] != null  ? Container(
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
                                  imageUrl: "${questions[index]["imageurl"]}",
                                )),
                          ) : Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      flex : 7,
                                      child: Container(

                                        padding: EdgeInsets.all(5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Wrap(
                                            children: [
                                              Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      flex : 7,
                                      child: Container(

                                        padding: EdgeInsets.all(5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Wrap(
                                            children: [
                                              Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: questions[index]["true"] == 3 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      flex : 7,
                                      child: Container(

                                        padding: EdgeInsets.all(5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Wrap(
                                            children: [
                                              Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: questions[index]["true"] == 3 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) :
                  Container(
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
                                children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                    fontFamily: "Abed"
                                ),)],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        Container(
                          child: questions[index]["imageurl"] != null  ? Container(
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
                                  imageUrl: "${questions[index]["imageurl"]}",
                                )),
                          ) : Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      flex : 7,
                                      child: Container(

                                        padding: EdgeInsets.all(5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Wrap(
                                            children: [
                                              Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                          ),
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      flex : 7,
                                      child: Container(

                                        padding: EdgeInsets.all(5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Wrap(
                                            children: [
                                              Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                  ],)
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
            if (index == 5) {
              return Column(children: [
                if (_isBannerAdReady)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd),
                    ),
                  ),
                questions[index]["num"] == 4  ? Container(
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
                              children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30 , left: 30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                fontFamily: "Abed"
                            ),)],
                          ),
                        ),
                      ),
                      Container(
                        child: questions[index]["imageurl"] != null  ? Container(
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
                                imageUrl: "${questions[index]["imageurl"]}",
                              )),
                        ) : Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 3 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 3 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 4 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer4"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 4 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ) :
                questions[index]["num"] == 3  ?  Container(
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
                              children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30 , left: 30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                fontFamily: "Abed"
                            ),)],
                          ),
                        ),
                      ),
                      Container(
                        child: questions[index]["imageurl"] != null  ? Container(
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
                                imageUrl: "${questions[index]["imageurl"]}",
                              )),
                        ) : Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 3 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 3 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ) :
                Container(
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
                              children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30 , left: 30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                fontFamily: "Abed"
                            ),)],
                          ),
                        ),
                      ),
                      Container(
                        child: questions[index]["imageurl"] != null  ? Container(
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
                                imageUrl: "${questions[index]["imageurl"]}",
                              )),
                        ) : Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off) ),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],);
            }
            if (index == 10) {
              return Column(children: [
                if (_isBannerAdReady1)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: _bannerAd1.size.width.toDouble(),
                      height: _bannerAd1.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd1),
                    ),
                  ),
                questions[index]["num"] == 4  ? Container(
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
                              children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30 , left: 30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                fontFamily: "Abed"
                            ),)],
                          ),
                        ),
                      ),
                      Container(
                        child: questions[index]["imageurl"] != null  ? Container(
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
                                imageUrl: "${questions[index]["imageurl"]}",
                              )),
                        ) : Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 3 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 3 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 4 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer4"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 4 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ) :
                questions[index]["num"] == 3  ?  Container(
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
                              children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30 , left: 30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                fontFamily: "Abed"
                            ),)],
                          ),
                        ),
                      ),
                      Container(
                        child: questions[index]["imageurl"] != null  ? Container(
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
                                imageUrl: "${questions[index]["imageurl"]}",
                              )),
                        ) : Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 3 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 3 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ) :
                Container(
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
                              children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30 , left: 30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                fontFamily: "Abed"
                            ),)],
                          ),
                        ),
                      ),
                      Container(
                        child: questions[index]["imageurl"] != null  ? Container(
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
                                imageUrl: "${questions[index]["imageurl"]}",
                              )),
                        ) : Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off) ),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],);
            }
            if (index == 15) {
              return Column(children: [
                if (_isBannerAdReady2)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: _bannerAd2.size.width.toDouble(),
                      height: _bannerAd2.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd2),
                    ),
                  ),
                questions[index]["num"] == 4  ? Container(
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
                              children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30 , left: 30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                fontFamily: "Abed"
                            ),)],
                          ),
                        ),
                      ),
                      Container(
                        child: questions[index]["imageurl"] != null  ? Container(
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
                                imageUrl: "${questions[index]["imageurl"]}",
                              )),
                        ) : Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 3 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 3 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 4 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer4"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 4 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ) :
                questions[index]["num"] == 3  ?  Container(
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
                              children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30 , left: 30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                fontFamily: "Abed"
                            ),)],
                          ),
                        ),
                      ),
                      Container(
                        child: questions[index]["imageurl"] != null  ? Container(
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
                                imageUrl: "${questions[index]["imageurl"]}",
                              )),
                        ) : Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 3 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 3 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ) :
                Container(
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
                              children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30 , left: 30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                fontFamily: "Abed"
                            ),)],
                          ),
                        ),
                      ),
                      Container(
                        child: questions[index]["imageurl"] != null  ? Container(
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
                                imageUrl: "${questions[index]["imageurl"]}",
                              )),
                        ) : Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex : 7,
                                    child: Container(

                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Wrap(
                                          children: [
                                            Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                              fontFamily: "Abed",
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off) ),
                                ],)
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],);
            }
            //-------------------------================الأسئلة=============================================================================
            return questions[index]["num"] == 4  ? Container(
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
                          children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                            fontFamily: "Abed"
                          ),)],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30 , left: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                            fontFamily: "Abed"
                        ),)],
                      ),
                    ),
                  ),
                  Container(
                    child: questions[index]["imageurl"] != null  ? Container(
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
                            imageUrl: "${questions[index]["imageurl"]}",
                          )),
                    ) : Container(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                    ),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Wrap(
                          children: [
                            Row(children: [
                              Expanded(
                                flex : 7,
                                child: Container(

                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                            fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                            ],)
                            ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                    ),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Wrap(
                          children: [
                            Row(children: [
                              Expanded(
                                flex : 7,
                                child: Container(

                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: questions[index]["true"] == 3 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                    ),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Wrap(
                          children: [
                            Row(children: [
                              Expanded(
                                flex : 7,
                                child: Container(

                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: questions[index]["true"] == 3 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: questions[index]["true"] == 4 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                    ),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Wrap(
                          children: [
                            Row(children: [
                              Expanded(
                                flex : 7,
                                child: Container(

                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Text('${questions[index]["answer4"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: questions[index]["true"] == 4 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ) :
            questions[index]["num"] == 3  ?  Container(
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
                          children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                              fontFamily: "Abed"
                          ),)],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30 , left: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                            fontFamily: "Abed"
                        ),)],
                      ),
                    ),
                  ),
                  Container(
                    child: questions[index]["imageurl"] != null  ? Container(
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
                            imageUrl: "${questions[index]["imageurl"]}",
                          )),
                    ) : Container(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                    ),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Wrap(
                          children: [
                            Row(children: [
                              Expanded(
                                flex : 7,
                                child: Container(

                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                    ),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Wrap(
                          children: [
                            Row(children: [
                              Expanded(
                                flex : 7,
                                child: Container(

                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: questions[index]["true"] == 3 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                    ),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Wrap(
                          children: [
                            Row(children: [
                              Expanded(
                                flex : 7,
                                child: Container(

                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: questions[index]["true"] == 3 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ) :
            Container(
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
                          children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                              fontFamily: "Abed"
                          ),)],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30 , left: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                            fontFamily: "Abed"
                        ),)],
                      ),
                    ),
                  ),
                  Container(
                    child: questions[index]["imageurl"] != null  ? Container(
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
                            imageUrl: "${questions[index]["imageurl"]}",
                          )),
                    ) : Container(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: questions[index]["true"] == 1 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                    ),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Wrap(
                          children: [
                            Row(children: [
                              Expanded(
                                flex : 7,
                                child: Container(

                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: questions[index]["true"] == 1 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off)),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: questions[index]["true"] == 2 ? Colors.green : Color.fromRGBO(232, 232, 232, 30),
                    ),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Wrap(
                          children: [
                            Row(children: [
                              Expanded(
                                flex : 7,
                                child: Container(

                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      children: [
                                        Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: questions[index]["true"] == 2 ? Icon(Icons.check_circle) : Icon(Icons.radio_button_off) ),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ) ;
            //=----------------------------==========================================================================================
          },
        )
            : Center(
            child: Container(
                width: 180,
                child: Ink.image(image: AssetImage("assets/images/loading.gif")))),
      ),
      //------------------------------------------------------------------------------------------------------------------------------
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/userImage.png',
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("/home");
                  },
                  leading: Icon(Icons.home),
                  title: Text(
                    'الصفحة الرئيسية',
                    style: TextStyle(fontFamily: "Abed"),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed("/Profile");
                  },
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text(
                    'الحساب',
                    style: TextStyle(fontFamily: "Abed"),
                  ),
                ),
                ListTile(
                  onTap: () {
                  },
                  leading: Icon(Icons.assessment_outlined),
                  title: Text(
                    'أسئلة الفحص النظري',
                    style: TextStyle(fontFamily: "Abed"),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed("/Chack");
                  },
                  leading: Icon(Icons.paste_sharp),
                  title: Text(
                    'الإختبار التجريبي',
                    style: TextStyle(fontFamily: "Abed"),
                  ),
                ),
                ListTile(
                  onTap: () {
                    AwesomeDialog(
                      btnOk: InkWell(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('name');
                          await prefs.remove('phone');
                          await prefs.remove('rate');
                          await prefs.remove('num');
                          await prefs.remove('sign');
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context)
                              .pushReplacementNamed("/Not");
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Text("الخروج" ,style: TextStyle(fontFamily: "Abed",fontSize : 15,color: Colors.white), textAlign: TextAlign.center,),),
                      ),
                      btnCancel: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Text("الرجوع" ,style: TextStyle(fontFamily: "Abed",fontSize : 15,color: Colors.white), textAlign: TextAlign.center,),),
                      ),
                      context: context,
                      dialogType: DialogType.WARNING,
                      animType: AnimType.BOTTOMSLIDE,
                      body: Column(
                        children: [
                          Text("تسجيل الخروج" ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Abed"
                            ),),
                          SizedBox(height: 20,),
                          Container(
                            margin: EdgeInsets.only(left: 20,right: 20),
                            child: Text("هل أنت متأكد من أنك تريد تسجيل الخروج ؟",textAlign : TextAlign.center , style: TextStyle(
                                fontFamily: "Abed",
                                fontSize: 13
                            ),),
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),

                    ).show();
                  },
                  leading: Icon(Icons.login),
                  title: Text(
                    'تسجيل الخروج',
                    style: TextStyle(fontFamily: "Abed"),
                  ),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
