import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ban extends StatefulWidget {
  const Ban({Key? key}) : super(key: key);

  @override
  _BanState createState() => _BanState();
}

class _BanState extends State<Ban> {
  final _advancedDrawerController = AdvancedDrawerController();

  var questions = [
    {
      "name" : "شاخصة ممنوع مرور الدراجات الناريه",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376361.jpg?alt=media&token=86220ad8-a0f9-484b-8c14-f8cd9ecda05d",
    },
    {
      "name" : "شاخصة ممنوع المرور",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376361.jpg?alt=media&token=86220ad8-a0f9-484b-8c14-f8cd9ecda05d",
    },
    {
      "name" : "ممنوع مرور المركبات بالاتجاهين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376436.jpg?alt=media&token=8a4bd956-3739-45f2-8ac2-8129750c5769",
    },
    {
      "name" : "شاخصة ممنوع استخدام الزامور",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376498.jpg?alt=media&token=8b14dea8-1163-4bcf-b451-54cdf865008c",
    },
    {
      "name" : "شاخصة ممنوع مرور المقطورات",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376520.jpg?alt=media&token=b6a5f406-3d8c-47b9-9f2a-7b639422680d",
    },
    {
      "name" : "ممنوع مرور المركبات القاطره والمقطوره",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376540.jpg?alt=media&token=01f3c1dd-da1a-41cc-82f7-0b2e37911d06",
    },
    {
      "name" : "ممنوع مرور الدراجات ذات المحرك السريع",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376599.jpg?alt=media&token=162dbdae-d56e-4b84-a5db-a720c9c193b2",
    },
    {
      "name" : "شاخصة ممنوع مرور الدراجات الهوائيه",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376618.jpg?alt=media&token=678e78f7-b882-401d-9bc0-873155768bb5",
    },
    {
      "name" : "ممنوع مرور المركبات التى يزيد عرضها عن 2.2م",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376641.jpg?alt=media&token=5574bb9f-72e9-481e-8c6d-9524dbda619f",
    },
    {
      "name" : "شاخصة ممنوع مرور المركبات الزراعيه",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376722.jpg?alt=media&token=e395a06f-f537-4c12-b0ae-1ba87ca2f786",
    },
    {
      "name" : "ممنوع مرور العربات التى تجرها الحيوانات",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376768.jpg?alt=media&token=07e17953-0cab-4344-b5a7-527061c375d7",
    },
    {
      "name" : "شاخصة ممنوع مرور المشاه",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376808.jpg?alt=media&token=ed1725d5-abb4-410e-b0ee-bb382212b4a3",
    },
    {
      "name" : "شاخصة ممنوع الإنعطاف الى اليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376842.jpg?alt=media&token=c26504ab-7827-40d3-b439-dc5c2321604f",
    },
    {
      "name" : "ممنوع مرور المركبات التى يزيد طولها عن 12م",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376892.jpg?alt=media&token=189a46af-6070-430d-9d1b-3b5f05964e14",
    },
    {
      "name" : "ممنوع مرور المركبات التى يزيد وزنها عن 12طنا",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376918.jpg?alt=media&token=94b2ee7d-e9f8-4b9a-9f78-d6b99f4148b1",
    },
    {
      "name" : "ممنوع مرور المركبات التى يزيد ارتفاعها عن 3.5م",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376942.jpg?alt=media&token=30f4586a-4581-4210-99f5-2aa6d6bd7d20",
    },
    {
      "name" : "شاخصة ممنوع تجاوز الشاحنات",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485376977.jpg?alt=media&token=9e6c89bc-d240-4a5d-874e-9987405f0d70",
    },
    {
      "name" : "شاخصة ممنوع تجاوز السيارات",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377027.jpg?alt=media&token=e7395ea4-6436-488d-8525-9df0d3403a87",
    },
    {
      "name" : "شاخصة ممنوع الدوران",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377074.jpg?alt=media&token=7f892357-84e6-4226-a69a-b51b7aa00d82",
    },
    {
      "name" : "شاخصة ممنوع الانعطاف الى اليمين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377110.jpg?alt=media&token=90e1720e-d384-43a6-92dc-98fcb4fafc32",
    },
    {
      "name" : "شاخصة حدود السرعة القصوي",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377177.jpg?alt=media&token=94692f11-d1a0-4032-8f0a-7a2034b8d4dc",
    },
    {
      "name" : "شاخصة نهاية منطقة المنع",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377212.jpg?alt=media&token=cd5a5e11-19f0-4406-a62e-81b38b9683cc",
    },
    {
      "name" : "نهاية منطقة منع التجاوز للشاحنات",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377230.jpg?alt=media&token=2a296fde-3b70-4f82-8906-dbd822f1d7a3",
    },
    {
      "name" : "نهاية منطقة منع التجاوز للسيارات",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377256.jpg?alt=media&token=949c1c12-73de-4a3a-9e2b-183c1a6414ef",
    },
    {
      "name" : "شاخصة ممنوع الوقوف دون التوقف",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377299.jpg?alt=media&token=5a641595-904f-43b0-ae4a-bde6f1f08279",
    },
    {
      "name" : "شاخصة ممنوع الوقوف أو التوقف",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377379.jpg?alt=media&token=3715cda1-d8e3-442d-a70b-ff3bc9551016",
    },
    {
      "name" : "ممنوع المرور دون توقف - جمارك",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377401.jpg?alt=media&token=46a1ff55-c6ec-4e38-a319-efb1436d480d",
    },
    {
      "name" : "نهايه تحديد السرعه المدون بالشاخصه",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377516.jpg?alt=media&token=97588aac-b71e-4312-9c93-f03927f3c296",
    },
    {
      "name" : "شاخصة ممنوع مرور المركبات الأليه",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377554.jpg?alt=media&token=fe93e20d-a7fd-44d1-b2f5-d8ab20485111",
    },
    {
      "name" : "ممنوع مرور عربات التى تدفع باليد",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377578.jpg?alt=media&token=1a0d38e2-728f-49ee-8ccb-983731007232",
    },
    {
      "name" : "شاخصة حدود السرعة القصوي",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377729.jpg?alt=media&token=0cfb8904-bd8d-4202-8f6f-586bd8ed2be2",
    },
    {
      "name" : "ممنوع مرور لمركبات نقل البضائع",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485377752.jpg?alt=media&token=51c80789-9684-458c-a430-a39d5ab802a9",
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
                        "شواخص المنع",
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
