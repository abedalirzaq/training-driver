import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: UserPage()),
    );
  }
}

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

String _url2 = 'https://abed-000000.blogspot.com/2022/01/blog-post.html';

void _launchURL2() async {
  if (!await launch(_url2)) throw 'Could not launch $_url';
}

class UserCard extends StatefulWidget {
  const UserCard({Key? key}) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  var date;
  var loading = true;

  getdate() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      date = [
        {
          'name': prefs.getString('name'),
          'phone': prefs.getString('phone'),
          'rate': prefs.getString('rate'),
          'num': prefs.getString('num'),
        }
      ];
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getdate();
    super.initState();
  }

  Widget _buildUserRow() {
    return Row(
      children: <Widget>[
        Parent(style: userImageStyle, child: Icon(Icons.account_circle)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(children: [Txt(loading ? 'إنتظر ...' : date[0]['name'], style: nameTextStyle)],),
            SizedBox(height: 5),
            Txt(loading ? 'إنتظر ...' : date[0]['phone'],
                style: nameDescriptionTextStyle)
          ],
        )
      ],
    );
  }

  Widget _buildUserStats() {
    return Parent(
      style: userStatsStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
              child: _buildUserStatsItem(
                  'أخر علامة', loading ? 'إنتظر ...' : "${date[0]['num']}")),
          Expanded(
              child: _buildUserStatsItem(
                  'أخر تقييم', loading ? 'إنتظر ...' : date[0]['rate'])),
        ],
      ),
    );
  }

  Widget _buildUserStatsItem(String value, String text) {
    final TxtStyle textStyle = TxtStyle()
      ..fontSize(15)
      ..textColor(Colors.white)
      ..fontFamily("Abed");
    return Column(
      children: <Widget>[
        Txt(value, style: textStyle),
        SizedBox(height: 6),
        Txt(text, style: nameDescriptionTextStyle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: userCardStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[_buildUserRow(), _buildUserStats()],
      ),
    );
  }

  //Styling

  final ParentStyle userCardStyle = ParentStyle()
    ..height(175)
    ..padding(horizontal: 20.0, vertical: 10)
    ..alignment.center()
    ..background.hex('#3977FF')
    ..borderRadius(all: 20.0)
    ..elevation(10, color: hex('#3977FF'));

  final ParentStyle userImageStyle = ParentStyle()
    ..height(50)
    ..width(50)
    ..margin(right: 10.0)
    ..borderRadius(all: 30)
    ..background.hex('ffffff');

  final ParentStyle userStatsStyle = ParentStyle()..margin(vertical: 10.0);

  final TxtStyle nameTextStyle = TxtStyle()
    ..textColor(Colors.white)
    ..fontSize(18)
    ..fontWeight(FontWeight.w600)
    ..fontFamily("Abed");

  final TxtStyle nameDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.white.withOpacity(0.6))
    ..fontSize(12)
    ..fontFamily("Abed");
}

class _HomeState extends State<Home> {
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  var fbm = FirebaseMessaging.instance;

  User? user = FirebaseAuth.instance.currentUser;

  var ban = 0;

  var usersref2 = FirebaseFirestore.instance.collection("users");

  Widget _buildUserStatsItem(String value, String text) {
    final TxtStyle textStyle = TxtStyle()
      ..fontSize(20)
      ..textColor(Colors.white)
      ..fontFamily("Abed");
    return Column(
      children: <Widget>[
        Txt(value, style: textStyle),
        SizedBox(height: 5),
        Txt(text, style: nameDescriptionTextStyle),
      ],
    );
  }

  final ParentStyle userCardStyle = ParentStyle()
    ..padding(horizontal: 20.0, vertical: 10)
    ..alignment.center()
    ..background.hex('#3977FF')
    ..borderRadius(all: 20.0)
    ..elevation(10, color: hex('#3977FF'));

  final ParentStyle userImageStyle = ParentStyle()
    ..height(50)
    ..width(50)
    ..margin(right: 10.0)
    ..borderRadius(all: 30)
    ..background.hex('ffffff');

  final ParentStyle userStatsStyle = ParentStyle()..margin(vertical: 10.0);
  final TxtStyle nameTextStyle = TxtStyle()
    ..textColor(Colors.white)
    ..fontSize(18)
    ..fontWeight(FontWeight.w600)
    ..fontFamily("Abed");

  final TxtStyle nameDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.white.withOpacity(0.6))
    ..fontSize(12)
    ..fontFamily("Abed");

  final contentStyle = (BuildContext context) => ParentStyle()
    ..overflow.scrollable()
    ..padding(vertical: 30, horizontal: 20)
    ..minHeight(MediaQuery.of(context).size.height - (2 * 30));

  final titleStyle = TxtStyle()
    ..bold()
    ..fontSize(32)
    ..margin(bottom: 20)
    ..alignmentContent.centerLeft()
    ..fontFamily("Abed");

  final _advancedDrawerController = AdvancedDrawerController();

  var a = 0;

  var list = [];

  getDatePref() async {
    final prefs = await SharedPreferences.getInstance();
    var a = jsonEncode(list);
    prefs.remove('list');
    await prefs.setString('list', a);
    print('save list in the cache--------------------');
  }

  var usersref = FirebaseFirestore.instance.collection("quastions");

  getDate() async {
    var responsebody = await usersref.get();
    responsebody.docs.forEach((element) {
      setState(() {
        list.add(element.data());
      });
    });
    print("install date now !!");
  }

  var usersref1 = FirebaseFirestore.instance.collection("update");
  var name = [];

  update() async {
    await usersref1.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          name.add(element.data());
        });
      });
    });
  }

  howGet() async {
    final prefs = await SharedPreferences.getInstance();
    final day = "${prefs.getInt('day')}";
    final month = "${prefs.getInt('month')}";
    print("التحديث يوم ${day} شهر ${month}");
    final b = "${prefs.getString('list')}";
    var d = jsonDecode(b);
    if (DateTime.now().month == int.parse(month)) {
      if (int.parse(day) == DateTime.now().day ||
          int.parse(day) < DateTime.now().day) {
        await update();
        print("رقم التحديث هو ${name[0]["update"]}");
        if (name[0]["update"] > prefs.getInt('update')) {
          print('اليوم يوم التحديث');
          await getDate();
          if (list.length > 110) {
            await getDatePref();
            prefs.remove('day');
            prefs.setInt('day', DateTime.now().day + 2);
            prefs.remove('month');
            prefs.setInt('month', DateTime.now().month);
            prefs.remove('update');
            prefs.setInt('update', name[0]["update"]);
          } else {
            print('list is low -------------------------------------');
            prefs.remove('day');
            prefs.setInt('day', DateTime.now().day + 1);
            prefs.remove('month');
            prefs.setInt('month', DateTime.now().month);
          }
        } else {
          print('رقم التحديث موجود بالفعل');
          prefs.remove('day');
          prefs.setInt('day', DateTime.now().day + 2);
          prefs.remove('month');
          prefs.setInt('month', DateTime.now().month);
        }
      }
    } else {
      await update();
      if (name[0]["update"] > prefs.getInt('update')) {
        await getDate();
        print("now is day download ----------------------------");
        if (list.length > 110) {
          await getDatePref();

          prefs.remove('day');
          prefs.setInt('day', DateTime.now().day + 2);
          prefs.remove('month');
          prefs.setInt('month', DateTime.now().month);
          prefs.remove('update');
          prefs.setInt('update', name[0]["update"]);
        } else {
          print('list is low -------------------------------------');
          prefs.remove('day');
          prefs.setInt('day', DateTime.now().day + 1);
          prefs.remove('month');
          prefs.setInt('month', DateTime.now().month);
        }
      } else {
        print('رقم التحديث موجود بالفعل');
        prefs.remove('day');
        prefs.setInt('day', DateTime.now().day + 2);
        prefs.remove('month');
        prefs.setInt('month', DateTime.now().month);
      }
    }
  }

  kam() async{
    await getDate();
    for(var i = 0; i < 116; i++){
      print("{'quastion' : '${list[i]["quastion"]}' , 'answer1' : '${list[i]["answer1"]}' , 'answer2' : '${list[i]["answer2"]}' , 'answer3' : '${list[i]["answer3"]}' ,'answer4' : '${list[i]["answer4"]}' , 'num' : ${list[i]["num"]} ,'true' : ${list[i]["true"]} , ${list[i]["imageurl"] != null ? "'imageurl' : '${list[i]["imageurl"]}'" : ''} }");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    kam();
    super.initState();
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
      child: WillPopScope(
        onWillPop: () async {
          AwesomeDialog(
            btnOk: InkWell(
              onTap: () {
                SystemNavigator.pop();
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
                  "مغادرة التطبيق",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: "Abed"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "هل تريد فعلا الخروج من التطبيق ؟",
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
        },
        child: Scaffold(
          //------------------------------------------------------------------------------------------------------------------------------
          body: Parent(
            style: contentStyle(context),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "الصفحة الرئيسية",
                    style: TextStyle(fontSize: 20, fontFamily: "Abed"),
                  ),
                ),
                Parent(
                  style: userCardStyle,
                  child: UserCard(),
                ),
                ActionsRow(),
                Settings(),
              ],
            ),
          ),
        ),
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
                  onTap: () {},
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
                    Navigator.of(context).pushNamed("/quastion");
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
                  onTap: () async {
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
                          Navigator.of(context).pushReplacementNamed("/Not");
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(7)),
                          child: Text(
                            "الخروج",
                            style: TextStyle(
                                fontFamily: "Abed",
                                fontSize: 15,
                                color: Colors.white),
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
                                fontFamily: "Abed",
                                fontSize: 15,
                                color: Colors.white),
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
                            "تسجيل الخروج",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, fontFamily: "Abed"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              "هل أنت متأكد من أنك تريد تسجيل الخروج ؟",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontFamily: "Abed", fontSize: 13),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
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
                InkWell(
                  onTap: () {
                    _launchURL2();
                  },
                  child: DefaultTextStyle(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActionsRow extends StatefulWidget {
  const ActionsRow({Key? key}) : super(key: key);

  @override
  _ActionsRowState createState() => _ActionsRowState();
}

class _ActionsRowState extends State<ActionsRow> {
  // TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    InterstitialAd.load(
      adUnitId: "abed",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;

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
  }

  Widget _buildActionsItem(
      String title, IconData icon, String string, context) {
    return InkWell(
      onTap: () {
        if (string == "/Profile") {
          Navigator.of(context).pushNamed(string);
        } else {
          _interstitialAd?.show();
          Navigator.of(context).pushNamed(string);
        }
      },
      child: Parent(
        style: actionsItemStyle,
        child: Column(
          children: <Widget>[
            Parent(
              style: actionsItemIconStyle,
              child: Icon(icon, size: 20, color: Color(0xFF42526F)),
            ),
            Txt(title, style: actionsItemTextStyle)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildActionsItem(
            'الحساب', Icons.account_circle_rounded, "/Profile", context),
        _buildActionsItem(
            'الشواخص', Icons.accessibility_outlined, "/Pillars", context),
        _buildActionsItem('الإختبار النظري', Icons.paste, "/Chack", context),
        _buildActionsItem('الأسئلة', Icons.dehaze, "/quastion", context),
      ],
    );
  }

  final ParentStyle actionsItemIconStyle = ParentStyle()
    ..alignmentContent.center()
    ..width(50)
    ..height(50)
    ..margin(bottom: 5)
    ..borderRadius(all: 30)
    ..background.hex('#F6F5F8');

  final ParentStyle actionsItemStyle = ParentStyle()..margin(vertical: 20.0);

  final TxtStyle actionsItemTextStyle = TxtStyle()
    ..textColor(Colors.black.withOpacity(0.8))
    ..fontSize(12)
    ..fontFamily("Abed");
}

String _url = 'https://wa.me/962782556917';

void _launchURL() async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3527427928264280/6998883965',
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
      InterstitialAd.load(
        adUnitId: 'ca-app-pub-3527427928264280/5942605556',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            this._interstitialAd = ad;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
              },
            );

            _isInterstitialAdReady = true;
          },
          onAdFailedToLoad: (err) {
            print('Failed to load an interstitial ad: ${err.message}');
            _isInterstitialAdReady = false;
          },
        ),
      );


    _bannerAd.load();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            _interstitialAd?.show();
            Navigator.of(context).pushNamed("/Pillars");
          },
          child: SettingsItem(Icons.assistant_photo, hex('#8D7AEE'), "الشواخص",
              'سوف تجد هنا جميع الشواخص المرورية', 'no'),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/Chack");
          },
          child: SettingsItem(Icons.update, hex('#F468B7'), 'الإختبار النظري',
              'إختبر معلوماتك الآن ...', 'no'),
        ),
        InkWell(
          onTap: () {
            _interstitialAd?.show();
            Navigator.of(context).pushNamed("/quastion");
          },
          child: SettingsItem(
              Icons.menu,
              hex('#FEC85C'),
              'أسئلة الإختبار النظري',
              'يجب أن تتدرب قبل البدء بالإختبار',
              'no'),
        ),
        InkWell(
          onTap: () {
            _interstitialAd?.show();
            Navigator.of(context).pushNamed("/Rules");
          },
          child: SettingsItem(Icons.assistant_photo, hex('#8D7AEE'),
              "القواعد المرورية", 'شرح للقواعد المرورية التسعة', 'yes'),
        ),
        InkWell(
          onTap: () {
            _interstitialAd?.show();
            Navigator.of(context).pushNamed("/Rusa");
          },
          child: SettingsItem(Icons.assistant_photo, hex('#8D7AEE'),
              "فئات رخص القيادة  ", 'تعرف على فئات الرخص في الأردن', 'yes'),
        ),
        InkWell(
          onTap: () {
            _launchURL();
          },
          child: SettingsItem(
              Icons.question_answer,
              hex('#BFACAA'),
              'التواصل مع المدرب',
              'للبدء في التدريب العملي أو أي استفسار',
              'no'),
        ),
        SizedBox(
          height: 20,
        ),
        if (_isBannerAdReady)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
          ),
      ],
    );
  }
}

class SettingsItem extends StatefulWidget {
  SettingsItem(
      this.icon, this.iconBgColor, this.title, this.description, this.news);

  final String news;
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: settingsItemStyle(pressed),
      child: Row(
        children: <Widget>[
          Parent(
            style: settingsItemIconStyle(widget.iconBgColor),
            child: Icon(widget.icon, color: Colors.white, size: 20),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Txt(widget.title, style: itemTitleTextStyle),
                  SizedBox(
                    width: 9,
                  ),
                  if (widget.news == 'yes')
                    Container(
                      padding:
                          EdgeInsets.only(right: 7, left: 7, top: 3, bottom: 4),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "جديد",
                        style: TextStyle(fontFamily: "Abed"),
                      ),
                    )
                ],
              ),
              SizedBox(height: 5),
              Txt(widget.description, style: itemDescriptionTextStyle),
            ],
          ),
        ],
      ),
    );
  }

  final settingsItemStyle = (pressed) => ParentStyle()
    ..elevation(pressed ? 0 : 50, color: Colors.grey)
    ..scale(pressed ? 0.95 : 1.0)
    ..alignmentContent.center()
    ..height(70)
    ..margin(vertical: 10)
    ..borderRadius(all: 15)
    ..background.hex('#ffffff')
    ..animate(150, Curves.easeOut);

  final settingsItemIconStyle = (Color color) => ParentStyle()
    ..background.color(color)
    ..margin(left: 15)
    ..padding(all: 12)
    ..borderRadius(all: 30);

  final TxtStyle itemTitleTextStyle = TxtStyle()
    ..bold()
    ..fontSize(16)
    ..fontFamily("Abed");

  final TxtStyle itemDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.black26)
    ..bold()
    ..fontSize(12)
    ..fontFamily("Abed");
}
