import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mandatory extends StatefulWidget {
  const Mandatory({Key? key}) : super(key: key);

  @override
  _MandatoryState createState() => _MandatoryState();
}

class _MandatoryState extends State<Mandatory> {
  final _advancedDrawerController = AdvancedDrawerController();

  var questions = [
    {
      "name" : "شاخصة انعطاف إجباري الى اليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485422640.jpg?alt=media&token=9d14ee31-dfd7-436d-a24d-77af1776a417",
    },
    {
      "name" : "شاخصة انعطاف إجباري الى اليمين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485422678.jpg?alt=media&token=47f5babe-11b2-4f1c-8c43-c60399d74108",
    },
    {
      "name" : "شاخصة اتجاه إجباري الى اليمين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485422768.jpg?alt=media&token=144956d4-1691-4cd1-a39e-5d119d4e18dc",
    },
    {
      "name" : "شاخصة اتجاه اجباري الى اليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإرشادية%2F1485422640.jpg?alt=media&token=9d14ee31-dfd7-436d-a24d-77af1776a417",
    },
    {
      "name" : "شاخصة اتجاه اجباري نحو الامام او اليمين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485422871.jpg?alt=media&token=4b9c2857-de51-417b-b20a-c0bb92991629",
    },
    {
      "name" : "شاخصة اتجاه اجباري نحو الامام او اليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485422899.jpg?alt=media&token=148e767e-7aa4-4321-ae48-a7e94203d6bd",
    },
    {
      "name" : "شاخصة إجبارية الدوران",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485422924.jpg?alt=media&token=72f1b9d9-a7f0-4f16-87b4-fdd93ed1f566",
    },
    {
      "name" : "شاخصة اتجاة اجباري نحو الامام",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485422956.jpg?alt=media&token=3326ab6d-d1e8-4316-8672-b59c9400dc22",
    },
    {
      "name" : "شاخصة اتجاة اجباري نحو اليمين او اليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485422991.jpg?alt=media&token=5fcb431b-09e7-4441-a1c0-982a9630f06f",
    },
    {
      "name" : "شاخصة اتجاه اجباري نحو اليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485423046.jpg?alt=media&token=534f5e13-c3a5-4df9-8109-f84cbe5e5be9",
    },
    {
      "name" : "شاخصة اتجاه اجباري نحو اليمين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485423060.jpg?alt=media&token=1ad755ae-5602-413b-afe4-7ab278f51625",
    },
    {
      "name" : "شاخصة اتجاة اجباري نحو اليمين او اليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485423078.jpg?alt=media&token=b4e37c8f-2aec-4554-915e-43bde17ba0b9",
    },
    {
      "name" : "شاخصة ممر الزامي للخيول",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485423104.jpg?alt=media&token=c42324d6-aa39-4768-b301-0844ee52fa37",
    },
    {
      "name" : "شاخصة ممر الزامي للمشاة",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485423131.jpg?alt=media&token=880c73fe-c955-41fc-82c0-4b08693d07eb",
    },
    {
      "name" : "شاخصة ممر للدراجات الهوائية",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485423157.jpg?alt=media&token=76b06c95-9842-4c88-9c43-0d990c6f997b",
    },
    {
      "name" : "شاخصة اتجاه اجبارى دائري دوار",
      'imageurl' : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20الإلزامية%2F1485423185.jpg?alt=media&token=18b9c4c2-c1cf-4849-98c8-5b907b2bd4b9",
    },

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
                        "الشواخص الإلزامية",
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
            if (index == 6){
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
            if (index == 9){
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
