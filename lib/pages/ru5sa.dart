import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rusa extends StatefulWidget {
  const Rusa({Key? key}) : super(key: key);

  @override
  _RusaState createState() => _RusaState();
}

class _RusaState extends State<Rusa> {
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
      'name' : "الفئة الأولى",
      'image' : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/فئات%20الرخص%2F1.jpg?alt=media&token=62c1a2d9-f4e1-482a-b4c9-6cc5dd7c47f0",
      'image1' : 'https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/فئات%20الرخص%2Fimages.jpg?alt=media&token=f5d05744-f45a-4d61-9161-3a4652ca0bd7',
      '1' : 'رخصه سواقه لجميع انواع الدراجات الأليه',
      '1-' : 'ادنى سن للحصول عليها 18 سنه',
      '1--' : 'مدة صلاحيه الرخصه 10 سنوات',
      '2' : 'رخصه سواقة سكوتر',
      "2-" : 'ادنى سن للحصول عليها 18 سنه',
      '2--' : 'مدة صلاحيه الرخصه 10 سنوات'
    },
    {
      'name' : "الفئه الثانية",
      'image' : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/فئات%20الرخص%2Fmaxresdefault.jpg?alt=media&token=543b9214-4ab8-4f7e-87a1-22543e3ceb7a",
      'image1' : 'https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/فئات%20الرخص%2Fcontent_loader_bg.jpg?alt=media&token=2f225ad1-8e70-41f7-97ce-2d92c63da489',
      '1' : 'رخصة سواقة لقيادة مركبة الاشغال',
      '1-' : 'ادنى سن للحصول عليها 18 سنه',
      '1--' : 'مدة الصلاحيه 10 سنوات',
      '2' : 'رخصة سواقة لقيادة مركبة زراعية',
      "2-" : 'ادنى سن للحصول عليها 18 سنه',
      '2--' : 'مدة صلاحيه الرخصه 10 سنوات'
    },
    {
      'name' : "الفئه الثالثة",
      'image' : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/فئات%20الرخص%2Fاسعار-ومواصفات-تويوتا-كامري-2018-3.jpg?alt=media&token=c646f8a1-5037-4f3c-b211-6efdaecdd933",
      '1info' : 'رخصه قياده سيارات ركوب خصوصيه او سيارات ركوب من صنف سيارات التاجير او مركبه خصوصيه لا يزيد وزنها الاجمالى عن 5 طن تعمل بمبدل سرعه يدوى',
      '1' : 'رخصة سوق لقيادة مركبة جير عادي',
      '1-' : 'ادنى سن للحصول عليها 18 سنه',
      '1--' : 'مدة الصلاحيه 10 سنوات',
      '2info' : 'رخصه قياده سيارات ركوب خصوصيه او سيارات ركوب من صنف سيارات التاجير او مركبه خصوصيه لا يزيد وزنها الاجمالى عن 5 طن تعمل بمبدل سرعه اوتوماتيك',
      '2' : 'رخصة سواقة لقيادة مركبة جير اوتوماتيك',
      "2-" : 'ادنى سن للحصول عليها 18 سنه',
      '2--' : 'مدة صلاحيه الرخصه 10 سنوات'
    },
    {
      'name' : "الفئه الرابعة",
      'image' : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/فئات%20الرخص%2FUntitled-1-226.jpg?alt=media&token=29531eaf-1629-4643-aeca-e6d390bb4a78",
      '1' : 'رخصه قياده سياره ركوب عموميه او مركبه لا يزيد وزنها الاجمالى عن 7 اطنان ونصف الطن',
      '1-' : 'ادنى سن للحصول  عليها 21 سنه ',
      '1--' : 'مدة صلاحيه الرخصه 5 سنوات',
    },
    {
      'name' : "الفئه الخامسة",
      'image' : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/فئات%20الرخص%2F97093.jpg?alt=media&token=6251591d-815a-4537-9bf6-591e125dd159",
      '1' : 'رخصه قياده حافله متوسطه او مركبه يزيد وزنها الاجمالي على سبعه اطنان ونصف الطن',
      '1-' : 'ادنى سن للحصول عليها 23 سنه ',
      '1--' : 'مدة صلاحيه الرخصه 5 سنوات',
    },
    {
      'name' : "الفئه السادسة",
      'image' : 'https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/فئات%20الرخص%2F5cc06d3a8ff6c.jpg?alt=media&token=13dd17e7-995c-4ba1-818f-57bed98f318c',
      'image1' : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/فئات%20الرخص%2Fimage_path_ar5b59dbe312599.jpg?alt=media&token=4c1caa3a-76eb-4c36-9169-767e360abd47",
      '1' : 'رخصه قياده قاطره ومقطوره او رأس قاطر ونصف مقطوره',
      '1-' : 'ادنى سن للحصول  عليها 25 سنه ',
      '1--' : 'مدة صلاحيه الرخصه 5 سنوات',
      '2' : 'رخصه قياده  حافلة',
      "2-" : 'ادنى سن للحصول عليها 25 سنه',
      '2--' : 'مدة صلاحيه الرخصه 5 سنوات'
    },
    {
      'name' : "الفئه السابعة",
      'image' : "https://firebasestorage.googleapis.com/v0/b/test-dcf59.appspot.com/o/فئات%20الرخص%2Fمصري-يبتر-ساقه-ليحصل-على-سيارة-ذوي-الاحتياجات-الخاصة-54453.webp?alt=media&token=1eaaf0ea-46fd-45c8-bad7-a7ca6f354b06",
      '1' : 'رخصة سوق لقيادة سياره ركوب صغيرة لذوى الاحتياجات الخاصة او دراجة أليه مصممه للغاية ذاتها',
      '1-' : 'ادنى سن للحصول  عليها 18 سنه ',
      '1--' : 'مدة صلاحيه الرخصه 2 سنوات',
    },

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
                        "فئات رخص القيادة",
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
                              children: [ Text(": شروط الحصول على الرخص",
                                textAlign: TextAlign.end,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 15,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("- يشترط فى طالب رخصه القياده ان يكون لائقا صحيا",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 13,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("- ان يجتاز الفحص النظرى والعملى بنجاح",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 13,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("- يشترط فى طالب رخصه القياده من الفئات الاولى والثانيه والثالثه والسابعه ان يكون قد اكمل ال 18 سنه",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 13,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("- يشترط فى طالب رخصه القياده من الفئه الرابعه ان يكون قد اكمل ال 21 سنه",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 13,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("- تمنح رخص القياده من الفئه الرابعه والخامسه والسادسه بعد انقضاء الفترات التاليه :",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 15,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("1 -لا تمنح الفئه الرابعه لطالبها الا بعد مرور سنه من تاريخ حصوله على الفئه الثالثه جير  ",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 13,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("2- لا تمنح الفئه الخامسه لطالبها الا بعد مرور سنتين من تاريخ حصوله على الفئه الرابعه",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 13,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("3- لا تمنح الفئه السادسه لطالبها الا بعد مرور سنتين من تاريخ حصوله على الفئه الخامسه",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 13,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("- يشترط فى طالب رخصه القياده من الفئات الاولي والرابعه والخامسه والسادسه ان :",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 15,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("1- يكون اردنى الجنسيه",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 13,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("2- ان يكون حسن السيره والسلوك",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 13,
                                    fontFamily: "Abed"
                                ),)],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("3 - للوزير الحق باعطاء غير الاردني ايا من رخص القياده المنصوص عليها",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,style: const TextStyle(
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
                          margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10, top: 20),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["name"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        rules[index]["image"] != null ?Container(
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
                                imageUrl: "${rules[index]["image"]}",
                              )),
                        ) : SizedBox(),
                        rules[index]["image1"] != null ?Container(
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
                                imageUrl: "${rules[index]["image1"]}",
                              )),
                        ) : SizedBox(),
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
                                              Text('${rules[index]["1"]}', textAlign: TextAlign.end,style: const TextStyle(
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
                        rules[index]["1info"] != null ? Container(
                          margin: EdgeInsets.only(right: 40 , left: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["1info"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ) : SizedBox(),
                        Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('شروط الحصول عليها', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w600,
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
                        Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["1-"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["1--"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        rules[index]["2"] != null ? Container(
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
                                              Text('${rules[index]["2"]}', textAlign: TextAlign.end,style: const TextStyle(
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
                        ): SizedBox(),
                        rules[index]["2info"] != null ? Container(
                          margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["2info"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ) : SizedBox(),
                        rules[index]["2-"] != null ? Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('شروط الحصول عليها', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w600,
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
                        ): SizedBox(),
                        rules[index]["2-"] != null ? Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["2-"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        ): SizedBox(),
                        rules[index]["2--"] != null ? Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["2--"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        ): SizedBox(),


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
                          margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10, top: 20),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["name"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        rules[index]["image"] != null ?Container(
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
                                imageUrl: "${rules[index]["image"]}",
                              )),
                        ) : SizedBox(),
                        rules[index]["image1"] != null ?Container(
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
                                imageUrl: "${rules[index]["image1"]}",
                              )),
                        ) : SizedBox(),
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
                                              Text('${rules[index]["1"]}', textAlign: TextAlign.end,style: const TextStyle(
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
                        rules[index]["1info"] != null ? Container(
                          margin: EdgeInsets.only(right: 40 , left: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["1info"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ) : SizedBox(),
                        Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('شروط الحصول عليها', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w600,
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
                        Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["1-"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["1--"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        rules[index]["2"] != null ? Container(
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
                                              Text('${rules[index]["2"]}', textAlign: TextAlign.end,style: const TextStyle(
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
                        ): SizedBox(),
                        rules[index]["2info"] != null ? Container(
                          margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["2info"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ) : SizedBox(),
                        rules[index]["2-"] != null ? Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('شروط الحصول عليها', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w600,
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
                        ): SizedBox(),
                        rules[index]["2-"] != null ? Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["2-"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        ): SizedBox(),
                        rules[index]["2--"] != null ? Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["2--"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        ): SizedBox(),


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
                          margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10, top: 20),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["name"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        rules[index]["image"] != null ?Container(
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
                                imageUrl: "${rules[index]["image"]}",
                              )),
                        ) : SizedBox(),
                        rules[index]["image1"] != null ?Container(
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
                                imageUrl: "${rules[index]["image1"]}",
                              )),
                        ) : SizedBox(),
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
                                              Text('${rules[index]["1"]}', textAlign: TextAlign.end,style: const TextStyle(
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
                        rules[index]["1info"] != null ? Container(
                          margin: EdgeInsets.only(right: 40 , left: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["1info"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ) : SizedBox(),
                        Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('شروط الحصول عليها', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w600,
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
                        Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["1-"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["1--"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        rules[index]["2"] != null ? Container(
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
                                              Text('${rules[index]["2"]}', textAlign: TextAlign.end,style: const TextStyle(
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
                        ): SizedBox(),
                        rules[index]["2info"] != null ? Container(
                          margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${rules[index]["2info"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ) : SizedBox(),
                        rules[index]["2-"] != null ? Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('شروط الحصول عليها', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w600,
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
                        ): SizedBox(),
                        rules[index]["2-"] != null ? Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["2-"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        ): SizedBox(),
                        rules[index]["2--"] != null ? Container(
                          margin: EdgeInsets.only(right: 14, left: 14),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
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
                                              Text('${rules[index]["2--"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
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
                        ): SizedBox(),


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
                    margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10, top: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [ Text("${rules[index]["name"]}", textAlign: TextAlign.end,style: const TextStyle(
                            fontSize: 20,
                            fontFamily: "Abed"
                        ),)],
                      ),
                    ),
                  ),
                  rules[index]["image"] != null ?Container(
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
                          imageUrl: "${rules[index]["image"]}",
                        )),
                  ) : SizedBox(),
                  rules[index]["image1"] != null ?Container(
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
                          imageUrl: "${rules[index]["image1"]}",
                        )),
                  ) : SizedBox(),
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
                                        Text('${rules[index]["1"]}', textAlign: TextAlign.end,style: const TextStyle(
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
                  rules[index]["1info"] != null ? Container(
                    margin: EdgeInsets.only(right: 40 , left: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [ Text("${rules[index]["1info"]}", textAlign: TextAlign.end,style: const TextStyle(
                            fontSize: 13,
                            fontFamily: "Abed"
                        ),)],
                      ),
                    ),
                  ) : SizedBox(),
                  Container(
                    margin: EdgeInsets.only(right: 14, left: 14),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
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
                                        Text('شروط الحصول عليها', textAlign: TextAlign.end,style: const TextStyle(
                                          height: 1.7,
                                          fontWeight: FontWeight.w600,
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
                  Container(
                    margin: EdgeInsets.only(right: 14, left: 14),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
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
                                        Text('${rules[index]["1-"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          height: 1.7,
                                          fontWeight: FontWeight.w400,
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
                  Container(
                    margin: EdgeInsets.only(right: 14, left: 14),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
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
                                        Text('${rules[index]["1--"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          height: 1.7,
                                          fontWeight: FontWeight.w400,
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
                  rules[index]["2"] != null ? Container(
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
                                        Text('${rules[index]["2"]}', textAlign: TextAlign.end,style: const TextStyle(
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
                  ): SizedBox(),
                  rules[index]["2info"] != null ? Container(
                    margin: EdgeInsets.only(right: 40 , left: 30,bottom: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [ Text("${rules[index]["2info"]}", textAlign: TextAlign.end,style: const TextStyle(
                            fontSize: 13,
                            fontFamily: "Abed"
                        ),)],
                      ),
                    ),
                  ) : SizedBox(),
                  rules[index]["2-"] != null ? Container(
                    margin: EdgeInsets.only(right: 14, left: 14),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
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
                                        Text('شروط الحصول عليها', textAlign: TextAlign.end,style: const TextStyle(
                                          height: 1.7,
                                          fontWeight: FontWeight.w600,
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
                  ): SizedBox(),
                  rules[index]["2-"] != null ? Container(
                    margin: EdgeInsets.only(right: 14, left: 14),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
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
                                        Text('${rules[index]["2-"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          height: 1.7,
                                          fontWeight: FontWeight.w400,
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
                  ): SizedBox(),
                  rules[index]["2--"] != null ? Container(
                    margin: EdgeInsets.only(right: 14, left: 14),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
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
                                        Text('${rules[index]["2--"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          height: 1.7,
                                          fontWeight: FontWeight.w400,
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
                  ): SizedBox(),


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
