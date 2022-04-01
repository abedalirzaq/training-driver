import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chack extends StatelessWidget {
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

class _HomeState extends State<Home> {
  bool pressed = false;

  final buttonStyle = (pressed) => TxtStyle()
    ..alignment.center()
    ..background.color(pressed ? Colors.white : Colors.orange)
    ..textColor(pressed ? Colors.orange : Colors.white)
    ..borderRadius(all: 5)
    ..border(all: 3, color: Colors.orange)
    ..padding(vertical: 10, horizontal: 15)
    ..animate(150, Curves.easeOut)
    ..fontFamily("Abed")
    ..textAlign.center(true);

  Gestures buttonGestures() => Gestures()
    ..isTap((isPressed) {
      _interstitialAd?.show();
      Navigator.of(context).pushNamed("/Final");
      setState(() => pressed = isPressed);
    });

  var ban = 0;

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

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  // TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  // TODO: Implement _loadInterstitialAd()
  @override
  void initState() {
    // TODO: Initialize _bannerAd
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3527427928264280/5942605556",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;

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


    _bannerAd.load();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();
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
        body: Parent(
          style: contentStyle(context),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "قبل الدخول إلى الإمتحان",
                  style: TextStyle(fontSize: 20, fontFamily: "Abed"),
                ),
              ),
              Settings(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTapCancel: () {
                  setState(() {
                    pressed = false;
                  });
                },
                onTapDown: (isTapped) => setState(() => pressed = true),
                onTap: () {
                  if (_isInterstitialAdReady) {
                    _interstitialAd?.show();
                    Navigator.of(context).pushNamed("/Final");
                  }
                  Navigator.of(context).pushNamed("/Final");
                },
                child: Txt(
                  'الدخول إلى الإختبار',
                  style: buttonStyle(pressed),
                  gesture: buttonGestures(),
                ),
              ),
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
            ],
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
                    Navigator.of(context).pushNamed("/quastion");
                  },
                  leading: Icon(Icons.assessment_outlined),
                  title: Text(
                    'أسئلة الفحص النظري',
                    style: TextStyle(fontFamily: "Abed"),
                  ),
                ),
                ListTile(
                  onTap: () {},
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

class ActionsRow extends StatelessWidget {
  Widget _buildActionsItem(
      String title, IconData icon, String string, context) {
    return InkWell(
      onTap: () {
        if (string == "/Final") {
          Navigator.of(context).pushReplacementNamed(string);
        } else {
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
            'الشواخص', Icons.accessibility_outlined, "/Profile", context),
        _buildActionsItem('الإختبار النظري', Icons.paste, "/Final", context),
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

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SettingsItem(Icons.access_alarm_sharp, hex('#8D7AEE'), "المدة",
            'مدة الإمتحان سوف تكون 60 دقيقة '),
        Wrap(
          children: [
            SettingsItem(Icons.help, hex('#F468B7'), 'عدد الأسئلة ',
                'عدد الأسئلة 60 سؤال '),
          ],
        ),
        SettingsItem(Icons.cancel_rounded, hex('#FEC85C'), 'الإجابات الخاطئة',
            'يتم عرض الإجابات الخاطئة في نهاية الإختبار'),
        SettingsItem(Icons.accessibility, hex('#BFACAA'), 'المستوى',
            'يتم حفظ بيانات أخر إختبار في صفحة الحساب'),
      ],
    );
  }
}

class SettingsItem extends StatefulWidget {
  SettingsItem(this.icon, this.iconBgColor, this.title, this.description);

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
      gesture: Gestures()
        ..isTap((isTapped) => setState(() => pressed = isTapped)),
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
              Txt(widget.title, style: itemTitleTextStyle),
              SizedBox(height: 5),
              Txt(widget.description, style: itemDescriptionTextStyle),
            ],
          )
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
    ..ripple(true)
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
