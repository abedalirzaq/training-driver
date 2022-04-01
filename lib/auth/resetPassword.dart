import 'package:app/auth/register.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/auth/login.dart';
import 'package:app/components/background.dart';
import 'package:flutter/services.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  var myemail;

  showLoading(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(230, 239, 241, 1),
            content: Container(
              width: 100,
              height: 150,
              child: Center(
                child: Ink.image(image: AssetImage("assets/images/loading.gif")),
              ),
            ),
          );
        });
  }



  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  var reset = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/login');
        return false;
      },
      child: Scaffold(
        body: Background(
          child: reset == 0 ? Form(
            key: formstate,
            child: ListView(
              children: <Widget>[
                SizedBox(height: size.height / 3,),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "إستعادة الحساب",
                    style: TextStyle(
                        fontFamily: "Abed",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 36
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),


                SizedBox(height: size.height * 0.03),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    validator: (val){
                      if (val == null) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.length < 8) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains("@") == false) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains(".") == false) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains(":") == true) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains(";") == true) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains("{") == true) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains("}") == true) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains("[") == true) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains("]") == true) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains('"') == true) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains("'") == true) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains("(") == true) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      if (val.contains(")") == true) {
                        return "يجب إدخال بريد إلكتروني صالح";
                      }
                      return null;
                    },
                    onSaved: (val){
                      myemail = val;
                    },
                    style: TextStyle(
                      fontFamily: "Abed",
                    ),
                    decoration: InputDecoration(

                        labelText: "البريد الإلكتروني",
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.03),


                SizedBox(height: size.height * 0.028),

                Center(
                  child: Container(
                    child: RaisedButton(
                      onPressed: () async {
                        showLoading(context);
                        var formdate = formstate.currentState;
                        if(formdate!.validate()){
                        formdate.save();
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: myemail.toLowerCase().replaceAll(new RegExp(r"\s+"), ""));
                        Navigator.of(context).pop();
                        reset = 1;
                      }},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: size.width * 0.5,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            gradient: new LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 136, 34),
                                  Color.fromARGB(255, 255, 177, 41)
                                ]
                            )
                        ),
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          "إرسال",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Abed",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ) : Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Text("لقد تم ارسال رابط إعادة تعيين كلمة المرور إلى البريد الإلكتروني الخاص بك" , textAlign: TextAlign.center, style: TextStyle(fontFamily: "Abed" ,height: 1.7),))) ,
        ),
      ),
    );
  }

}
