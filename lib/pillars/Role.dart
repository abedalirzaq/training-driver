import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Role extends StatefulWidget {
  const Role({Key? key}) : super(key: key);

  @override
  _RoleState createState() => _RoleState();
}

class _RoleState extends State<Role> {
  final _advancedDrawerController = AdvancedDrawerController();

  var questions = [
    {
      "name" : "شاخصة قف",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/شواخص%20الأولوية%2F1485509587.jpg?alt=media&token=8078870b-f3f0-4b14-8f4c-70d492c5da1c",
    },
    {
      "name" : "طريق ذو أولوية",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/شواخص%20الأولوية%2F1485509654.jpg?alt=media&token=4887f844-8343-4212-8a4d-dfcdc649aa53",
    },
    {
      "name" : "اعط الأولوية",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/شواخص%20الأولوية%2F1485509699.jpg?alt=media&token=01502638-d151-41a3-90f1-bab77776bc48",
    },
    {
      "name" : "أولوية المرور للقادم من الجهة المقابلة",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/شواخص%20الأولوية%2F1485509740.jpg?alt=media&token=e4e81d6d-b443-46e2-a1a5-60ac4e03c218",
    },
    {
      "name" : "أولوية المرور لك علي السيارات المقابلة",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/شواخص%20الأولوية%2F1485509783.jpg?alt=media&token=f8e2b227-7056-4ce0-b81a-84f57a471cbb",
    },
    {
      "name" : "نهاية طريق ذو الأولوية",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/شواخص%20الأولوية%2F1485945275.jpg?alt=media&token=d5d09a6c-0536-4459-a3bc-9a083b6a9d60",
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
                        "شواخص الأولوية",
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
            if (index == 2){
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
            if (index == 4){
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
