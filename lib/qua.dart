import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class Questions1 extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions1> {
  final _advancedDrawerController = AdvancedDrawerController();

  var questions = [];

  @override
  void initState() {
    // TODO: implement initState
    getDate();
    super.initState();
  }
  var usersref = FirebaseFirestore.instance.collection("quastions");
  var loading = false;
  getDate() async {
    var responsebody = await usersref.get();
    responsebody.docs.forEach((element) {
      setState(() {
        questions.add(element.data());
        loading = true;
      });

    }) ;
  }


  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
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
        body: loading == true ? ListView.builder(
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
                        "أسئلة النظري المقترحة",
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
                  questions[index]["num"] == 4  ? Container(
                    color: Color.fromRGBO(245, 245, 245, 30),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Wrap(
                                alignment: WrapAlignment.end,
                                children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                    fontFamily: "Abed"
                                ),)],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        Container(
                          child: questions[index]["imageurl"] != null  ? Container(
                            margin: EdgeInsets.all(10),
                            child: Center(
                                child: CachedNetworkImage(
                                  width: MediaQuery.of(context).size.width - 60,
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
                          ) : Container(),
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
                                              Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                                  ],)
                                ],
                              ),
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
                                              Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                                  ],)
                                ],
                              ),
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
                                              Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                                  ],)
                                ],
                              ),
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
                                              Text('${questions[index]["answer4"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) :
                  questions[index]["num"] == 3  ?  Container(
                    color: Color.fromRGBO(245, 245, 245, 30),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Wrap(
                                alignment: WrapAlignment.end,
                                children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                    fontFamily: "Abed"
                                ),)],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        Container(
                          child: questions[index]["imageurl"] != null  ? Container(
                            margin: EdgeInsets.all(10),
                            child: Center(
                                child: CachedNetworkImage(
                                  width: MediaQuery.of(context).size.width - 60,
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
                          ) : Container(),
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
                                              Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                                  ],)
                                ],
                              ),
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
                                              Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                                  ],)
                                ],
                              ),
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
                                              Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) :
                  Container(
                    color: Color.fromRGBO(245, 245, 245, 30),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Wrap(
                                alignment: WrapAlignment.end,
                                children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                                    fontFamily: "Abed"
                                ),)],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30 , left: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                                  fontFamily: "Abed"
                              ),)],
                            ),
                          ),
                        ),
                        Container(
                          child: questions[index]["imageurl"] != null  ? Container(
                            margin: EdgeInsets.all(10),
                            child: Center(
                                child: CachedNetworkImage(
                                  width: MediaQuery.of(context).size.width - 60,
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
                          ) : Container(),
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
                                              Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                                  ],)
                                ],
                              ),
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
                                              Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                                fontFamily: "Abed",
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
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
            //-------------------------================الأسئلة=============================================================================
            return questions[index]["num"] == 4  ? Container(
              color: Color.fromRGBO(245, 245, 245, 30),
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width - 20,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                              fontFamily: "Abed"
                          ),)],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30 , left: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                            fontFamily: "Abed"
                        ),)],
                      ),
                    ),
                  ),
                  Container(
                    child: questions[index]["imageurl"] != null  ? Container(
                      margin: EdgeInsets.all(10),
                      child: Center(
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width - 60,
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
                    ) : Container(),
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
                                        Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                            ],)
                          ],
                        ),
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
                                        Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                            ],)
                          ],
                        ),
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
                                        Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                            ],)
                          ],
                        ),
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
                                        Text('${questions[index]["answer4"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) :
            questions[index]["num"] == 3  ?  Container(
              color: Color.fromRGBO(245, 245, 245, 30),
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width - 20,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                              fontFamily: "Abed"
                          ),)],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30 , left: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                            fontFamily: "Abed"
                        ),)],
                      ),
                    ),
                  ),
                  Container(
                    child: questions[index]["imageurl"] != null  ? Container(
                      margin: EdgeInsets.all(10),
                      child: Center(
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width - 60,
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
                    ) : Container(),
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
                                        Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                            ],)
                          ],
                        ),
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
                                        Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                            ],)
                          ],
                        ),
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
                                        Text('${questions[index]["answer3"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) :
            Container(
              color: Color.fromRGBO(245, 245, 245, 30),
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width - 20,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [ Text("السؤال ${index + 1}", textAlign: TextAlign.end,style: const TextStyle(
                              fontFamily: "Abed"
                          ),)],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30 , left: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [ Text("${questions[index]["quastion"]}", textAlign: TextAlign.end,style: const TextStyle(
                            fontFamily: "Abed"
                        ),)],
                      ),
                    ),
                  ),
                  Container(
                    child: questions[index]["imageurl"] != null  ? Container(
                      margin: EdgeInsets.all(10),
                      child: Center(
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width - 60,
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
                    ) : Container(),
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
                                        Text('${questions[index]["answer1"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                            ],)
                          ],
                        ),
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
                                        Text('${questions[index]["answer2"]}', textAlign: TextAlign.end,style: const TextStyle(
                                          fontFamily: "Abed",
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded( flex : 1,child: Icon(Icons.check_circle_outline)),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) ;
            //=----------------------------==========================================================================================
          },
        ) : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("جاري تحميل الأسئلة"),
                SizedBox(
                  width: 8,
                ),
                CircularProgressIndicator()
              ],
            )),
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
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text(
                    'الحساب',
                    style: TextStyle(fontFamily: "Abed"),
                  ),
                ),
                ListTile(
                  onTap: () {},
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
                  onTap: () {},
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
