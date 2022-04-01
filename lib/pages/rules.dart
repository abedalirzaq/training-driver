import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rules extends StatefulWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  final _advancedDrawerController = AdvancedDrawerController();



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
  var rules = [
    {
      'name' : 'القاعدة الأولى',
      'des' : 'بالتقاطعات المتكافئه الحقوق ( لا توجد ضوابط مروريه) يجب ان يعطى السائق الاولويه للمركبه القادمه على التقاطع من يمينه بغض النظر عن وجهة سيرها'
    },{
      'name' : "القاعدة الثانية",
      'des' : "اذا تقابلت مركبتان على التقاطع وكانت كل منهما على يسار الاخرى .. وكانت احداهما (احدى المركبتين) تشير الى انها ستتجه الى يسارها فيجب ان تعطى تلك المركبه الاولويه للمركبه الاخرى التى تشير الى انها ستتجه باستقامه او انها تشير باتجاهها الى يمينها"
    },{
      'name' : "القاعدة الثالثة",
      'des' : "اعطاء الاوليه للمركبات القادمه من طريق رئيسي اذا كان السائق قادم من طريق فرعي"
    },{
      'name' : "القاعدة الرابعة",
      'des' : "اولويه السير للمركبات داخل الدوار , وعلى سائق المركبه التى خارج الدوار الانتظار واعطاء الاولويه للمركبات التى داخل الدوار"
    },{
      'name' : "القاعدة الخامسة",
      'des' : "تكون الاولويه للقطارات والمركبات التى تسير على خطوط حديديه فى حاله تقاطعها مع الطريق"
    },{
      'name' : "القاعدة السادسة",
      'des' : "على تقاطع الطرق الذى على شكل حرف T او Y تكون الاولويه للمركبه الموجوده على الطريق ذات استقامه وبغض النظر عن اتجاهها"
    },{
      'name' : "القاعدة السابعة",
      'des' : "يجب ان يعطى السائق الاولويه لمركبات المواكب الرسميه والاسعاف والانقاذ والاطفاء والشرطه اثناء تأديتها للواجب واستخدامها للمنبهات والاشارات الداله على ذلك"
    },{
      'name' : "القاعدة الثامنة",
      'des' : "يجب على المركبات القادمه من الساحات الخاصه او المداخل الخاصه او الطرق الزراعيه او الكراجات او محطات الوقود او المنعطفه بشكل نص دائرى او المتحوله من اتجاه الى اخر فى الطرق مفصوله الاتجاهات التوقف والتاكد من خلو الطريق قبل الدخول اليه"
    },{
      'name' : "القاعدة التسعة",
      'des' : "يجب ان يعطى السائق الاولويه للمشاه ومواكب الموتى والمسيرات المنظمه"
    }
  ];

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
          itemCount: rules.length,
          itemBuilder: (context, index) {
            if(index == 0){
              return Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    trailing: Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: const Text(
                        "القواعد المرورية",
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
                  Container(
                    color: Color.fromRGBO(245, 245, 245, 30),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text(": معلومة",
                                textAlign: TextAlign.end,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 15,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("تم وضع مجموعه من القواعد لتوزيع الحقوق واولويه المرور للمركبات على التقاطعات متكافئه الحقوق ( تقاطعات غير محكومه بضوابط مروريه) اى لا يحكمها اشاره ضوئيه او رجل سير او شاخصه مروريه او علامه ارضيه . حيث ان التقاطعات من اكثر الاماكن التى ينتج عنها نقاط تضارب وحوداث مروريه وناتى الان لهذه القواعد الثابته ",
                                textAlign: TextAlign.end,style: const TextStyle(
                                  height: 1.5,
                                  fontSize: 13,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(245, 245, 245, 30),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["name"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 19,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromRGBO(232, 232, 232, 30),
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
                                              Text('${rules[index]["des"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
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
                    color: Color.fromRGBO(245, 245, 245, 30),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["name"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 19,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromRGBO(232, 232, 232, 30),
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
                                              Text('${rules[index]["des"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
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
                    color: Color.fromRGBO(245, 245, 245, 30),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["name"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 19,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromRGBO(232, 232, 232, 30),
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
                                              Text('${rules[index]["des"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
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
            return Container(
              color: Color.fromRGBO(245, 245, 245, 30),
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width - 20,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [ Text("${rules[index]["name"]}", textAlign: TextAlign.end,style: const TextStyle(
                          fontSize: 19,
                            fontFamily: "Abed"
                        ),)],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color.fromRGBO(232, 232, 232, 30),
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
                                        Text('${rules[index]["des"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          height: 1.7,
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ) ;
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
