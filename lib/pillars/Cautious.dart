import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cautious extends StatefulWidget {
  const Cautious({Key? key}) : super(key: key);

  @override
  _CautiousState createState() => _CautiousState();
}

class _CautiousState extends State<Cautious> {
  final _advancedDrawerController = AdvancedDrawerController();

  var questions = [
    {
      "name" : "شاخصة احذر امامك منعطف الي اليمين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1.jpg?alt=media&token=4f551a98-17c9-4ea1-ba34-a160154098b6",
    },
    {
      "name" : "شاخصة احذر امامك منعطفان متتاليين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F2.jpg?alt=media&token=802bd819-4c51-439e-a850-93c35ce66f67",
    },
    {
      "name" : "شاخصة احذر امامك مرتفع حاد",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F3.jpg?alt=media&token=0b22927e-7b71-4f61-b3d1-39494dbdf330",
    },
    {
      "name" : "شاخصة احذر امامك شاخصه قف",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F4.jpg?alt=media&token=099d526f-99cc-48c0-b922-20cdb16810a7",
    },
    {
      "name" : "شاخصة احذر امامك منحدر حاد",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F5.jpg?alt=media&token=1d5b03ac-1453-4836-92e3-c43ad965d8d2",
    },
    {
      "name" : "شاخصة احذر امامك تضيق من جهتين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F6.jpg?alt=media&token=ffd6901a-8e22-4a7c-996b-dc0313f43574",
    },
    {
      "name" : "شاخصة احذر امامك تضيق من اليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F7.jpg?alt=media&token=9fa36a93-8104-4759-b17d-0bcdd92cd712",
    },
    {
      "name" : "شاخصة احذر امامك تضيق من اليمين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2Ferror.jpg?alt=media&token=d54b205d-1011-4a52-a04a-3f2fb8905daa",
    },
    {
      "name" : "شاخصة احذر امامك تضيق جسر",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F8.jpg?alt=media&token=810aa3ef-f189-412f-9914-44f12aad35ad",
    },
    {
      "name" : "شاخصة احذر امامك طريق غير مستوى",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F9.jpg?alt=media&token=dad8857b-23de-410b-a97e-ef032d59ac9c",
    },
    {
      "name" : "شاخصة احذر امامك إنخفاض بمستوى الطريق",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F10.jpg?alt=media&token=a9b33f78-134c-46f5-9074-81a89520287f",
    },
    {
      "name" : "شاخصة طريق ينتهى الى بحر او نهر",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F11.jpg?alt=media&token=8aca718e-55d7-4044-b0d1-dfc46f20fdb7",
    },
    {
      "name" : "شاخصة احذر امامك تساقط حجاره من اليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F12.jpg?alt=media&token=d713fc58-485a-4191-a727-6887fe4bd2ef",
    },
    {
      "name" : "شاخصة احذر امامك تساقط حجاره من اليمين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485378995.jpg?alt=media&token=926dc211-3730-4a86-a981-9b4c0b8c2518",
    },
    {
      "name" : "شاخصة احذر امامك طريق زلقه",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379046.jpg?alt=media&token=31b652e6-31d5-4809-ab6f-fd0edc29966e",
    },
    {
      "name" : "شاخصة احذر امامك تناثر حجارة",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379090.jpg?alt=media&token=cccbf972-031f-4059-acf1-8eba47ed984d",
    },
    {
      "name" : "شاخصة احذر امامك ممر مشاة",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379127.jpg?alt=media&token=a58973ae-6517-430d-bb8b-8c7344f955e6",
    },
    {
      "name" : "شاخصة احذر امامك طلاب مدارس",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379170.jpg?alt=media&token=8a22be93-4748-4b9e-a691-6504440bcf6e",
    },
    {
      "name" : "شاخصة احذر امامك ممر دراجات",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379201.jpg?alt=media&token=4564c844-50fb-458c-872e-14ac85e471c4",
    },
    {
      "name" : "شاخصة احذر منطقه طيران منخفض",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379235.jpg?alt=media&token=dd0ef9e9-f166-4a51-9ea2-68a4aeab5de8",
    },
    {
      "name" : "شاخصة احذر امامك رياح شديده من اليمين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379320.jpg?alt=media&token=57ce40bb-2308-4510-93ae-536c41d42eb2",
    },
    {
      "name" : "شاخصة احذر امامك رياح شديده من اليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379338.jpg?alt=media&token=9fd2e087-3bb6-49d4-af53-a628f0bf56c6",
    },
    {
      "name" : "شاخصة احذر امامك طريق ذو اتجاهين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379383.jpg?alt=media&token=551ecf48-6c31-4f0c-88cf-cad9b09a1674",
    },
    {
      "name" : "شاخصة احذر أمامك نفق",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379423.jpg?alt=media&token=48dff316-de4c-493f-af58-560034176642",
    },
    {
      "name" : "شاخصة إحذر امامك مقطع سكة حديدية",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379482.jpg?alt=media&token=383f5e00-98da-4ad8-83aa-838c850c51db",
    },
    {
      "name" : "شاخصة مقطع بوابه سكة حديدية",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379532.jpg?alt=media&token=1bf66548-9549-4ba8-b1d1-a815046ee939",
    },
    {
      "name" : "شاخصة مقطع سكه حديدية خط واحد",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379575.jpg?alt=media&token=ee0e58f2-cc13-43ef-92be-d581d4884ca9",
    },
    {
      "name" : "شاخصة مقطع سكه حديدية اكثر من خط",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379612.jpg?alt=media&token=83f12dda-2214-4ffb-b38e-815257afbd90",
    },
    {
      "name" : "مقاطع سكه حديديه على ابعاد مختلفه من التقاطع",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379639.jpg?alt=media&token=e457995c-620b-4f5a-a964-ff9fdb5ba36b",
    },
    {
      "name" : "شاخصة احذر امامك منطقة أخطار مختلفة",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379681.jpg?alt=media&token=1d89b333-ee82-4eb7-98b4-f570f5322006",
    },
    {
      "name" : "شاخصة احذر امامك تقاطع طرق",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379719.jpg?alt=media&token=cd3ee4fc-1a4d-4951-a595-d28a4056f65c",
    },
    {
      "name" : "شاخصة احذر امامك دوار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379753.jpg?alt=media&token=9d7664d3-8996-4ec0-95e0-5d38f79d5360",
    },
    {
      "name" : "تقاطع طريق رئيسي مع طريقين فرعين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379800.jpg?alt=media&token=0eca9ae2-d47f-43be-a4cb-9849baac0292",
    },
    {
      "name" : "تقاطع طريق رئيسي مع طريق فرعى من اليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379826.jpg?alt=media&token=f107ac66-ed77-4b06-9228-cec7feed454d",
    },
    {
      "name" : "تقاطع طريق رئيسي مع طريق فرعى من اليمين",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379870.jpg?alt=media&token=c789c51e-b760-4977-88b4-72d0b6ad150e",
    },
    {
      "name" : "شاخصة امامك شاخصة اعط الاولوية",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379914.jpg?alt=media&token=aa8d9b90-839f-4710-9daa-ede00abaa86b",
    },
    {
      "name" : "شاخصة احذر امامك اعمال على الطريق",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379954.jpg?alt=media&token=e3b6b029-f7f2-4d10-84d8-837af8305990",
    },
    {
      "name" : "شاخصة احذر امامك عبور حيوانات - جمل",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485379991.jpg?alt=media&token=eb4573b9-a8b4-4edf-82bd-02640cf679c2",
    },
    {
      "name" : "شاخصة انتهاء الطريق بجزيرة وسطيه",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485380048.jpg?alt=media&token=1416423d-0563-456f-ae54-7b10e53bef50",
    },
    {
      "name" : "شاخصة انتبة امامك منعطف لليسار",
      "imageurl" : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/الشواخص%20التحذيرية%2F1485380079.jpg?alt=media&token=f55730ae-3556-4c89-89a1-e8041313b462",
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
                        "الشواخص التحذيرية",
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
