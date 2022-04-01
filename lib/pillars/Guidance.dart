import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Guidance extends StatefulWidget {
  const Guidance({Key? key}) : super(key: key);

  @override
  _GuidanceState createState() => _GuidanceState();
}

class _GuidanceState extends State<Guidance> {
  final _advancedDrawerController = AdvancedDrawerController();

  var questions = [
    {
      "name" : "محطه وقود",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485420915.jpg?alt=media&token=71252ad8-6283-4078-9e85-760453001242",
    },
    {
      "name" : "مقهى",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485420959.jpg?alt=media&token=396ec38c-4997-45d2-aef8-e482e1597014",
    },
    {
      "name" : "مطعم",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485420986.jpg?alt=media&token=df0a6eb0-ce0e-4f6a-8e34-fec3fb0c561b",
    },
    {
      "name" : "فندق",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485421002.jpg?alt=media&token=69f5a0c5-7ee3-44ec-a3db-a0797d98c453",
    },
    {
      "name" : "مركز اسعاف اولي",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485421017.jpg?alt=media&token=c055e8bb-025d-4ebd-8e1a-d7f4329fccb4",
    },
    {
      "name" : "موقف",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485421040.jpg?alt=media&token=3427ea93-0f6b-4bd8-99a5-f20d33ccf43a",
    },
    {
      "name" : "مخرج المنحدرات للطوارىء",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485421083.jpg?alt=media&token=fc0f0a5f-a40a-414f-af9e-4edacb97c380",
    },
    {
      "name" : "توزین إجباري للشاحنات",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485421115.jpg?alt=media&token=fe9930e1-253b-4953-bb6a-9fb817c4c382",
    },

    {
      "name" : "نهايه الاوتوستراد",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485421137.jpg?alt=media&token=a2654727-a083-4bfb-b246-d2d5e398b84f",
    },
    {
      "name" : "بدايه الاوتوستراد",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485421160.jpg?alt=media&token=573b2c19-da4e-40f3-804d-b3339dc3a7a8",
    },
    // لم يتم إكمال جميع الشواخص


  ];

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  late BannerAd _bannerAd1;
  bool _isBannerAdReady1 = false;
  @override
  void initState() {
    // TODO: Initialize _bannerAd
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

    _bannerAd1.load();
    _bannerAd.load();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();
    _bannerAd1.dispose();
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
        body: ListView.builder(
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
                        "الشواخص الإرشادية",
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
                ],
              );
            }
            if (index == 5){
              return Column(
                children: [
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
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 245, 245, 30),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    width: MediaQuery.of(context).size.width - 80,
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.only(top: 20 , left: 40, right: 40 , ),
                    child: Column(
                      children: [
                        Center(
                            child: CachedNetworkImage(height: 250,
                              placeholder: (context, url) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("جاري تحميل الصورة"),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  CircularProgressIndicator()
                                ],
                              ),
                              imageUrl: "${questions[index]["imageurl"]}",
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text("${questions[index]["name"]}" , style: TextStyle(
                              fontFamily: "Abed"
                          ),),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            if (index == 8){
              return Column(
                children: [
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
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 245, 245, 30),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    width: MediaQuery.of(context).size.width - 80,
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.only(top: 20 , left: 40, right: 40 , ),
                    child: Column(
                      children: [
                        Center(
                            child: CachedNetworkImage(height: 250,
                              placeholder: (context, url) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("جاري تحميل الصورة"),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  CircularProgressIndicator()
                                ],
                              ),
                              imageUrl: "${questions[index]["imageurl"]}",
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text("${questions[index]["name"]}" , style: TextStyle(
                              fontFamily: "Abed"
                          ),),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 30),
                  borderRadius: BorderRadius.circular(10)
              ),
              width: MediaQuery.of(context).size.width - 80,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.only(top: 20 , left: 40, right: 40 , ),
              child: Column(
                children: [
                  Center(
                      child: CachedNetworkImage(height: 250,
                        placeholder: (context, url) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("جاري تحميل الصورة"),
                            SizedBox(
                              width: 8,
                            ),
                            CircularProgressIndicator()
                          ],
                        ),
                        imageUrl: "${questions[index]["imageurl"]}",
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text("${questions[index]["name"]}" , style: TextStyle(
                        fontFamily: "Abed"
                    ),),
                  )
                ],
              ),
            );
          },
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

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
