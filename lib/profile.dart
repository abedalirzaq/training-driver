import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _advancedDrawerController = AdvancedDrawerController();


  var questions = [
    "aved",
    "awsdasd",
    "asdasd",
    "asdasd",
    " asdasdasd",
  ];

  var usersref = FirebaseFirestore.instance.collection("users");



  @override

  var date;
  var loading = true;
  getdate() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      date = [
        {
          'name' : prefs.getString('name'),
          'phone' : prefs.getString('phone'),
          'rate' : prefs.getString('rate'),
          'num' : prefs.getString('num'),
        }
      ];
      loading = false;
    });
  }
  @override
  void initState(){
    // TODO: implement initState
    getdate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    String _url = 'https://wa.me/962782556917';

    void _launchURL() async {
      if (!await launch(_url)) throw 'Could not launch $_url';
    }

    String _url1 = 'https://abed-000000.blogspot.com/2022/01/blog-post.html';

    void _launchURL1() async {
      if (!await launch(_url1)) throw 'Could not launch $_url1';
    }

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
        body:ListView(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                ListTile(
                  trailing: Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Text(
                      "المعلومات الشخصية",
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 20 , right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
//==================================================================================================
                        Container(
                          alignment: AlignmentDirectional.topEnd,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Text(loading ? 'إنتظر' : date[0]['name'],
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Abed",
                            ),
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(top: 5, left: 20, right: 20),
                          alignment: AlignmentDirectional.topEnd,
                          child: Text(loading ? 'إنتظر' : date[0]['phone'],
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF959595),
                              fontFamily: "Abed",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 124.0,
                    height: 124.0,
                    margin: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 20.0,
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
                ),
                SizedBox(width: 25,),
              ],
            ),
            SafeArea(
              child: Stack(
                children: [
                  Center(
                  ),
                  // TODO: Display a banner when ready
                ],
              ),
            ),
            InkWell(
              onTap: () {
              },
              child: ListTile(
                title: Text(loading ? 'إنتظر' : 'التقييم : ${date[0]['rate']}',
                  style: TextStyle(
                    fontFamily: "Abed",
                  ),
                  textAlign: TextAlign.end,
                ),
                trailing: Icon(Icons.security),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("Privacy");
              },
              child: ListTile(
                title: Text(loading ? 'إنتظر' : 'المعدل : ${date[0]['num']}',
                  style: TextStyle(
                    fontFamily: "Abed",
                  ),
                  textAlign: TextAlign.end,
                ),
                trailing: Icon(Icons.assessment_outlined),
              ),
            ),
            InkWell(
              onTap: () async {
                _launchURL();
              },
              child: ListTile(
                title: Text(
                  "خدمة العملاء",
                  style: TextStyle(
                    fontFamily: "Abed",
                  ),
                  textAlign: TextAlign.end,
                ),
                trailing: Icon(Icons.question_answer),
              ),
            ),
            InkWell(
              onTap: () {
                _launchURL1();
              },
              child: ListTile(
                title: Text(
                  "سياسة الخصوصية",
                  style: TextStyle(
                    fontFamily: "Abed",
                  ),
                  textAlign: TextAlign.end,
                ),
                trailing: Icon(Icons.accessibility),
              ),
            ),
            InkWell(
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
              child: ListTile(
                title: Text(
                  "تسجيل الخروج",
                  style: TextStyle(
                    fontFamily: "Abed",
                  ),
                  textAlign: TextAlign.end,
                ),
                trailing: Icon(Icons.login_outlined),
              ),
            ),
          ],
        ) ,
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
