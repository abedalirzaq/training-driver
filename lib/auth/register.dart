import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/auth/login.dart';
import 'package:app/components/background.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var username, mypassword, myemail, phono;

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

  signup() async {
    var formdate = formstate.currentState;
    if (formdate!.validate()) {
      formdate.save();
      try {
        showLoading(
            context);
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: myemail.replaceAll(new RegExp(r"\s+"), ""),
            password: mypassword

        );
        return  userCredential ;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Color.fromRGBO(230, 239, 241, 1),
                  content: Container(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Center(
                            child: Text("كلمة المرور ضعيفة ..." , textAlign: TextAlign.center , style: TextStyle(
                                fontFamily: "Abed"
                            ),),
                          ),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
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
                      ],
                    ),
                  ),
                );
              });
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Color.fromRGBO(230, 239, 241, 1),
                  content: Container(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Center(
                            child: Text("البريد الإلكتروني مستخدم بالفعل ..." , textAlign: TextAlign.center , style: TextStyle(
                                fontFamily: "Abed"
                            ),),
                          ),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
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
                      ],
                    ),
                  ),
                );
              });
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }


  var list = [
    {'quastion' : 'المسرب هو أي جزء من الاجزاء الطولية للطريق يسمح بمرور صف واحد من المركبات المتتابعة' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'التوقف في حال خلو الطريق من المركبات والمشاة' , 'answer2' : 'عدم التوقف إلا إذا كنت تقوم بتحميل وتنزيل الركاب أو تحميل وتنزيل البضائع' , 'answer3' : ' عدم الوقوف والتوقف نهائياً كون توقفك ووقوفك يؤدى لإعاقة حركة المرور' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/38%20(3).jpg?alt=media&token=faa90727-dbd7-4974-b448-6f73a49c5834' }
    ,{'quastion' : 'عند قيادة المركبة من قبل سائق تحت تأثير الكحول أو أي من المؤثرات العقلية التي تفقد سائقها السيطرة على قيادتها أو تناول الكحول أثناء القيادة ' , 'answer1' : 'القبض من قبل أفراد الأمن العام على السائق بدون مذكرة' , 'answer2' : 'القبض من قبل أفراد الأمن العام على السائق بمذكرة' , 'answer3' : 'لاشيء مما ذكر' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 ,  }
    ,{'quastion' : 'يعمل نظام محرك الإبتداء على بدأ حركة المحرك أو إعطاء المحرك الطاقة للحركة اللازمة لبدء عملية الأشواط الأربعة' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'في الصورة التي امامك يريد السائق التوجه' , 'answer1' : 'إلى اليمين' , 'answer2' : 'الى اليسار' , 'answer3' : 'تخفيف السرعة' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/2.jpg?alt=media&token=73361305-a26f-4402-9d3c-6d52c8a701ce' }
    ,{'quastion' : 'ان تناول الكحول يقلل من التركيز وسرعة الاستجابة عند القيادة' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'ملائمة سرعة مركبتك مع هذا المنحدر والالتزام بحدود السرعة المقررة واستعمال الغيارات العكسية' , 'answer2' : 'ملائمة سرعة مركبتك مع هذا المرتفع والالتزام بحدود السرعة المقررة والتزام الجانب الأيمن من الطريق' , 'answer3' : 'ملائمة سرعة مركبتك مع هذا المنحدر والالتزام بحدود السرعة المقررة واستعمال المكابح' ,'answer4' : 'ملائمة سرعة مركبتك مع هذا المنحدر وزيادة السرعة عن المقررة واستعمال الغيارات العكسية' , 'num' : 4 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/14.jpg?alt=media&token=a021e9f9-0ef7-481d-adc2-1c869f1a61c8' }
    ,{'quastion' : 'اذا حاول السائق الهرب من مكان حادث ارتكبه فإنه' , 'answer1' : 'يجوز لاي فرد من افراد الشرطة ان يلقي القبض عليه دون مذكرة' , 'answer2' : 'لايجوز إلقاء القبض عليه ولكن يجب دفع قيمة المخالفه فقط' , 'answer3' : 'لاشئ مما ذكر' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 ,  }
    ,{'quastion' : ' الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'زيادة سرعة مركبتك والانعطاف نحو اليسار' , 'answer2' : 'تخفيض سرعة مركبتك والانعطاف نحو اليسار' , 'answer3' : 'زيادة سرعة مركبتك والانعطاف نحو اليمين' ,'answer4' : 'تخفيض سرعة مركبتك والانعطاف نحو اليمين' , 'num' : 4 ,'true' : 4 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/40.jpg?alt=media&token=2a9b6b1b-c81f-4e75-a51e-7ba6984081b4' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'زيادة سرعة مركبتك لتستطيع تجنب (الجمل)' , 'answer2' : 'تخفيض سرعة مركبتك لتستطيع تجنب ( الجمل)' , 'answer3' : 'المحافظة على نفس السرعة' ,'answer4' : 'لاشئ مما ذكر' , 'num' : 4 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/25.jpg?alt=media&token=e47c6b16-a394-4376-b4c7-f2567c61ffef' }
    ,{'quastion' : 'يمكن أن يقذف الأطفال من السيارة عند وقوع حوادث في حالة عدم تثبيتهم بنظام آمن كحزام الأمانو/أو كرسي ألأطفال' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'في الصورة التي امامك تكون الاولوية' , 'answer1' : 'للمركبة رقم (1)' , 'answer2' : 'للمركبة رقم (2)' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/214.jpg?alt=media&token=e0754002-f869-4978-bdac-5ea68712f105' }
    ,{'quastion' : 'على سائق المركبة عند رؤيته لهذه الشاخصة' , 'answer1' : 'سلوك هذا الطريق عند التأكد من خلوه من الدراجات الهوائية' , 'answer2' : ' عدم سلوك هذا الطريق كونه مخصص للدراجات الهوائية' , 'answer3' : 'لا شئ مما ذكر' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/43.jpg?alt=media&token=826ed383-05dd-4ed4-ae0a-c973d863c2d3' }
    ,{'quastion' : 'في الصورة التي امامك تبين كفيف يقطع الشارع على السائق ان' , 'answer1' : 'يتجاوز عنه' , 'answer2' : 'الإستمرار في المرور مع تنبيه الكفيف بالزامور' , 'answer3' : 'الوقوف التام لحين مرور الكفيف' ,'answer4' : 'null' , 'num' : 3 ,'true' : 3 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/214.jpg?alt=media&token=e0754002-f869-4978-bdac-5ea68712f105' }
    ,{'quastion' : 'من أسباب حميان المحرك' , 'answer1' : 'نقص الماء في الرديتر' , 'answer2' : 'عطل في غطاء الرديتر' , 'answer3' : 'قطع أو أرتخاء قشاط المروحة' ,'answer4' : 'جميع ماذكر صحيح' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'في الصورة التي امامك تبين الظروف الجوية الغير ملائمة لوجود الضباب و الامطار فعلى السائق ان' , 'answer1' : 'يخفف السرعة' , 'answer2' : 'اعطاء المزيد من الوقت عندما يقترب من ممر المشاة' , 'answer3' : 'يتابع المسير في نفس السرعة' ,'answer4' : 'الإجابة الأولى و الثانية' , 'num' : 4 ,'true' : 4 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/214.jpg?alt=media&token=e0754002-f869-4978-bdac-5ea68712f105' }
    ,{'quastion' : 'النزيف هو خروج الدم من الأوعية الدموية ( الشرايين – الأوردة – الشعيرات الدموية )' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'من إجراءات الاسعافات الاولية لايقاف النزيف' , 'answer1' : 'الضغط المباشر على مكان النزيف بواسطة رباط ضاغط وذلك لإيقاف أي نوع من النزيف' , 'answer2' : 'وضع رباط حاصر على مسافة 5-10 سم أعلى مكان النزيف لإيقاف النزيف الشرياني أو أسفل مكان النزيف لإيقاف النزيف الوريدي' , 'answer3' : 'جميع ما ذكر ' ,'answer4' : 'null' , 'num' : 3 ,'true' : 3 ,  }
    ,{'quastion' : 'يجوز لاي فرد من افراد الشرطة اذا كانت المركبة غير مسجلة او انتهى ترخيصها لمدة تزيد على ستة' , 'answer1' : 'حجز المركبة' , 'answer2' : 'إلقاء القبض على السائق' , 'answer3' : 'إلزام السائق بدفع غرامه فقط' ,'answer4' : 'لاشئ مما ذكر' , 'num' : 4 ,'true' : 1 ,  }
    ,{'quastion' : 'وظيفة القابض (الكلتش)' , 'answer1' : 'نقل القوة من المحرك الى صندوق التروس أو فصلها عند الحاجة' , 'answer2' : 'نقل القوة من صندوق التروس الى المحرك أو فصلها عند الحاجة' , 'answer3' : 'نقل القوة من المحرك الى صندوق التروس دون فصلها حتى عند الحاجة' ,'answer4' : 'null' , 'num' : 1 ,'true' : 1 ,  }
    ,{'quastion' : 'ان سائق المركبة الحمراء لا يزعج بضوئه سائق المركبة الموجودة في الأمام (الخضراء) و ذلك لأنه لا يسير ملاصقا له' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/101111.gif?alt=media&token=6aa60d99-9501-4e4f-aaa2-3152e689f905' }
    ,{'quastion' : 'فئة رخصة السوق التي تؤهلك لقيادة المركبة المبينة هي' , 'answer1' : 'الفئة الاولى' , 'answer2' : 'الفئة الثانية' , 'answer3' : 'الفئة الثالثة' ,'answer4' : 'لا شيء مما ذكر' , 'num' : 4 ,'true' : 3 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/192.jpg?alt=media&token=9b637286-46c3-4765-95a8-304c9420e37b' }
    ,{'quastion' : 'من إجراءات التي تتخذ لفاقد الوعي' , 'answer1' : 'عدم نقل المصاب من مكان الحادث' , 'answer2' : 'عدم تجبير أي جزء من جسمه' , 'answer3' : 'الإجابة الأولى + الإجابة الثانية' ,'answer4' : 'لاشيء مما ذكر' , 'num' : 4 ,'true' : 3 ,  }
    ,{'quastion' : 'ماذا تعني لك الاشارة الموجودة بالصورة' , 'answer1' : ' قم بتخفيف السرعة' , 'answer2' : 'قم بزيادة السرعة' , 'answer3' : 'الانعطاف الى اليمين' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/48.jpg?alt=media&token=bf63230c-4cfe-467b-8d17-2012281242a8' }
    ,{'quastion' : 'في الصورة التي امامك تكون الاولوية' , 'answer1' : 'للمركبة رقم (1)' , 'answer2' : 'للمركبة رقم (2)' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/217.jpg?alt=media&token=0c18e699-8b00-4be6-af83-7ac0b1ffb34a' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'تخفيض سرعة مركبتك والالتزام بحدود السرعة المقررة والجانب الأيسر من الطريق وعدم التجاوز' , 'answer2' : 'تخفيض سرعة مركبتك والالتزام بحدود السرعة المقررة والجانب الأيسر من الطريق وإمكانية التجاوز' , 'answer3' : 'زيادة سرعة مركبتك والالتزام بحدود السرعة المقررة والجانب الأيمن من الطريق وعدم التجاوز' ,'answer4' : 'تخفيض سرعة مركبتك والالتزام بحدود السرعة المقررة والجانب الأيمن من الطريق وعدم التجاوز' , 'num' : 4 ,'true' : 4 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/16.jpg?alt=media&token=d560a922-bc2c-4bd0-b774-4df9a348fb5b' }
    ,{'quastion' : 'في الصورة التي امامك وقوف المركبة صحيح' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/243.jpg?alt=media&token=d06272a9-0523-4d61-ac1b-b1b391b2374b' }
    ,{'quastion' : 'في الصورة التي امامك وقوف المركبة صحيح' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/245.jpg?alt=media&token=7d59151e-c2dc-49cc-a93e-182836e17228' }
    ,{'quastion' : 'يجوز لاي فرد من افراد الشرطة ان يلقي القبض دون مذكرة على سائق اي مركبة في حال' , 'answer1' : 'قيادة المركبة بطريقة متهورة او بصورة تشكل خطرا على مستعملي الطريق' , 'answer2' : 'قيادة المركبة وهو تحت تاثير الكحول او اي مخدر يفقده السيطرة على قيادتها' , 'answer3' : 'محاولة الهرب من مكان حادث ارتكبه' ,'answer4' : 'جميع ماذكر' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'توقيف مركبتك والسماح للمركبات الأخرى الموجودة في الاتجاه الآخر بالمرور' , 'answer2' : 'تخفيف السرعة ومتابعة المسير كون أولوية المرور لك' , 'answer3' : 'ملاحظة وضع الطريق وبناءا عليه تسير او تعطي الأولوية للمركبات القادمة' ,'answer4' : 'لاشئ مما ذكر' , 'num' : 4 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/32.jpg?alt=media&token=35c931f1-10f5-4189-b605-46474f4899d4' }
    ,{'quastion' : 'اذا تسبب سائق المركبة اثناء قيادتها بوفاة انسان او تسبب باحداث عاهة دائمة فإنه' , 'answer1' : 'تحجز رخصة القيادة العائدة له' , 'answer2' : 'يعاقب بالحبس مدة من ثلاثة اشهر الى ثلاثة سنوات' , 'answer3' : 'وقف العمل برخصة القيادة مدة لاتقل عن ستة اشهر ولاتزيد على السنتين' ,'answer4' : 'جميع ماذكر صحيح' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : ' ان سائق المركبة الحمراء يزعج بضوئه سائق المركبة الموجودة في الأمام (الصفراء) لانه' , 'answer1' : 'يسير ملاسقا له' , 'answer2' : 'لا يسير ملاصقا له' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/11.jpg?alt=media&token=f254db96-6b0e-422e-9fb3-465ae62d8b60' }
    ,{'quastion' : 'في الصورة التي امامك تكون الاولوية' , 'answer1' : 'للمركبة رقم (1)' , 'answer2' : 'للمركبة رقم (2)' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/216.jpg?alt=media&token=6741a2f9-7fad-4b57-96a6-522f9092d501' }
    ,{'quastion' : 'من أجزاء نظام الوقود' , 'answer1' : ' خزان الوقود' , 'answer2' : 'مضخة الوقود' , 'answer3' : 'المازج ( الكاربوريتر)' ,'answer4' : 'جميع ماذكر' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'الالتزام بحدود السرعة المقررة والالتزام بالجانب الأيمن من الطريق' , 'answer2' : 'الالتزام بحدود السرعة المقررة والالتزام بالجانب الأيسر من الطريق' , 'answer3' : 'زيادة سرعتك عن حدود السرعة المقررة والالتزام بالجانب الأيمن من الطريق' ,'answer4' : 'زيادة سرعتك عن حدود السرعة المقررة والالتزام بالجانب الأيسر من الطريق' , 'num' : 4 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/26.jpg?alt=media&token=aa1a0531-c04c-4593-8140-f8f02528cf0e' }
    ,{'quastion' : 'في الصورة التي أمامك يريد السائق' , 'answer1' : 'أن تزيد من سرعتك' , 'answer2' : 'أن تقوم بالتجاوز عنه' , 'answer3' : 'أن تخفف من سرعتك' ,'answer4' : 'null' , 'num' : 3 ,'true' : 3 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/5.jpg?alt=media&token=c72b2dbf-b263-4a74-94f8-fcd49213789c' }
    ,{'quastion' : 'إذا كانت المركبة التي امامك تقف على منحدر فإن وضعية عجلات المركبة تكون كما في الشكل' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/6.jpg?alt=media&token=1cbdd8bf-cdce-4545-9e9c-2f79510dcd83' }
    ,{'quastion' : 'يجوز لأي فرد البقاء في السيارة أثناء رفعها بالرافعة (الجك)' , 'answer1' : ' نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 2 ,  }
    ,{'quastion' : 'في الصورة التي امامك التصرف الذي تقوم به المركبة صحيح' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/228.jpg?alt=media&token=88e494e8-3b8b-4a9c-93b4-aaf6330b842e' }
    ,{'quastion' : 'ماذا تعني لك الاشارة الموجودة بالصورة' , 'answer1' : 'قف' , 'answer2' : 'قم بتخفيف السرعة' , 'answer3' : 'قم بزيادة السرعة' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/49.jpg?alt=media&token=66ed4f57-355f-41da-80f5-786f33008008' }
    ,{'quastion' : 'يجوز للأطفال الجلوس في أي منطقة في السيارة الغير مجهزة بمقاعدالأمان الخاصة بالأطفال' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 2 ,  }
    ,{'quastion' : 'يجب على السائق الإلتزام بالجانب الايمن من الطريق للانتقال الى طريق اخر يقع على يمينه' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'علامة الرصيف تعني' , 'answer1' : 'ممنوع الوقوف لجميع المركبات' , 'answer2' : 'الوقوف فقط للمركبات العمومية و النقل' , 'answer3' : 'لتأكيد الرؤيا فقط' ,'answer4' : 'null' , 'num' : 3 ,'true' : 3 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/191.jpg?alt=media&token=7792134d-2690-4e04-aa47-8da049fa38d4' }
    ,{'quastion' : '(حرف P) ) في الجير الأتوماتيك تعني (PARK )أي توقف' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'يتكون نظام الكهرباء في المركبات من' , 'answer1' : 'البطارية' , 'answer2' : 'نظام التوليد والشحن' , 'answer3' : 'نظام محرك الابتداء (السلف)' ,'answer4' : 'جميع ماذكر' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'في الصورة التي امامك هل تتجاوز المركبة الزرقاء بشكل صحيح' , 'answer1' : ' نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/231.jpg?alt=media&token=1627b95d-7e32-4bfe-b8c9-4c71c395b5b0' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'عدم الدوران كون ذلك ممنوع ومن الممكن ان يواجهك مخاطر ناتجة عن عدم اتساع التقاطع' , 'answer2' : 'الدوران بعد التأكد من خلو الطريق من المركبات الأخرى' , 'answer3' : 'الدوران خلال اوقات المساء فقط' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/37.jpg?alt=media&token=2501d3ec-384e-441b-845b-b7d4531234ee' }
    ,{'quastion' : 'من الأمور الواجب تفقدها بصورة مستمرة' , 'answer1' : 'مستوى الزيت في المحرك والماء في المبرد' , 'answer2' : 'قشاط المروحة' , 'answer3' : 'مؤشر ساعة الحرارة' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 ,  }
    ,{'quastion' : 'ماذا تعني لك الاشارة الموجودة بالصورة' , 'answer1' : 'الأنعطاف الى اليسار' , 'answer2' : 'الانعطاف الى اليمين' , 'answer3' : 'التوقف' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/47.jpg?alt=media&token=b7e0be54-dedb-4300-b4a0-bc12a9a27bdc' }
    ,{'quastion' : 'من إجراءات الاسعافات الاولية للنزيف' , 'answer1' : 'طلب المساعدة الطبية من خلال استدعاء الإسعاف فورا' , 'answer2' : 'العمل على إراحة المصاب من خلال وضعه على ظهره مع خفض الرأس عن مستوى الجسم' , 'answer3' : 'العمل على إيقاف النزيف' ,'answer4' : 'جميع ما ذكر' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'ماذا تعني لك الاشارة الموجودة بالصورة' , 'answer1' : 'يوجد خطر من اعلى الخوذة' , 'answer2' : 'يوجد خطر من جهة اليمين' , 'answer3' : 'يوجد خطر من جهة اليسار' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/53.jpg?alt=media&token=7720aa79-fd4f-496f-be0f-fd049f787bb1' }
    ,{'quastion' : 'استخدام حزام الأمان هو' , 'answer1' : 'إختياري' , 'answer2' : 'إلزامي على الطرق الخارجية فقط' , 'answer3' : 'حرية شخصية للمستخدم وحسب مزاجه' ,'answer4' : 'إلزامي ويساعد المستخدم على تخفيف حدة الإصابة في حال وقوع حادث مروري شريطة استخدامه بالطريقة الصحيحة' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'من مواصفات ماء التبريد المستخدم لتبريد المحرك' , 'answer1' : 'يجب أن يكون ماء التبريد نقياً وأن يحتوي مادة تساعد على عدم تكون الصدأ والرواسب' , 'answer2' : 'يجب أن يكون ماء التبريد نقياً وأن يحتوي على نسبة مرتفعة من الكلس' , 'answer3' : 'يجب أن يكون ماء التبريدعكراً وأن يحتوي على نسبة مخفضة من الكلس' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'زيادة سرعة مركبتك، لتتناسب مع سرعة المنعطف والسماح بالتجاوز' , 'answer2' : 'تخفيض سرعة مركبتك، لتتناسب مع سرعة المنعطف وعدم التجاوز' , 'answer3' : 'تخفيض سرعة مركبتك، لتتناسب مع سرعة المنعطف والسماح بالتجاوز' ,'answer4' : 'إيقاف مركبتك ثم التحرك ببطء نحو المنعطف لدخوله بأمان ومنع التجاوز' , 'num' : 4 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/12.jpg?alt=media&token=72ba97cf-ccc7-4df8-b99a-765ec344bfce' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'تخفيض سرعة مركبتك لكي تستطيع اجتياز هذا الانخفاض بأمان' , 'answer2' : 'تخفيض سرعة مركبتك، لكي تستطيع اجتياز المطب بأمان' , 'answer3' : 'زيادة سرعة مركبتك، لكي تستطيع اجتياز المطب بأمان' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/18.jpg?alt=media&token=545bed7d-9572-4659-bb7b-b973126a6cd4' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'تخفيض سرعة مركبتك والالتزام بحدود السرعة المقررة والجانب الأيسر من الطريق وعدم التجاوز' , 'answer2' : 'تخفيض سرعة مركبتك والالتزام بحدود السرعة المقررة والجانب الأيسر من الطريق وإمكانية التجاوز' , 'answer3' : 'تخفيض سرعة مركبتك والالتزام بحدود السرعة المقررة والجانب الأيمن من الطريق وعدم التجاوز' ,'answer4' : 'زيادة سرعة مركبتك والالتزام بحدود السرعة المقررة والجانب الأيمن من الطريق وعدم التجاوز' , 'num' : 4 ,'true' : 3 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/17.jpg?alt=media&token=9c8ceb7b-bbd7-4a2f-ab6b-b6f38db33cfd' }
    ,{'quastion' : ' الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'تخفيض سرعة مركبتك وإعطاء الأولوية للمركبات الأخرى على التقاطع ثم الدوران' , 'answer2' : 'زيادة سرعة مركبتك وأخذ حق الأولوية على التقاطع ثم الدوران' , 'answer3' : ' الذهاب إلى تقاطع أخر يكون فيه الدوران مسموح' ,'answer4' : 'لاشئ مما ذكر' , 'num' : 4 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/42.jpg?alt=media&token=94fdc40e-3501-42ac-9d4f-2b5ae2c872b9' }
    ,{'quastion' : 'يجوز لاي فرد من افراد الشرطة ان يلقي القبض دون مذكرة على سائق اي مركبة في حال' , 'answer1' : 'قيادة المركبة بطريقة متهورة او بصورة تشكل خطرا على مستعملي الطريق' , 'answer2' : 'قيادة المركبة وهو تحت تاثير الكحول او اي مخدر يفقده السيطرة على قيادتها' , 'answer3' : 'محاولة الهرب من مكان حادث ارتكبه' ,'answer4' : 'جميع ماذكر' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'سلوك هذا الطريق بعد التأكد من خلوه من المركبات القادمة' , 'answer2' : 'عدم سلوك هذا الطريق كونه باتجاه واحد' , 'answer3' : ' لا شىء مما ذكر' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/34.jpg?alt=media&token=c935a8de-cb10-46ed-a568-07019c2851c9' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'زيادة سرعة مركبتك دون الإلتزام بحدود السرعة' , 'answer2' : 'الوقوف التام بمركبتك' , 'answer3' : 'تخفيض سرعة مركبتك وإعطاء الأولوية للمركبات صاحبة حق الأولوية ' ,'answer4' : 'متابعة مسيرك دون توقف والإلتزام بحدود السرعة' , 'num' : 4 ,'true' : 3 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/30.jpg?alt=media&token=4c315d59-3be6-430d-acd2-81ee05754842' }
    ,{'quastion' : 'يجوز لاي فرد من افراد الشرطة ان يلقي القبض دون مذكرة على سائق اي مركبة إذا' , 'answer1' : 'تسبب في وفاة شخص او اصابته بسبب قيادة المركبة' , 'answer2' : 'رفض التوقف لدورية الشرطة' , 'answer3' : 'القيادة بعكس السير' ,'answer4' : 'لاشئ مما ذكر' , 'num' : 4 ,'true' : 1 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'زيادة سرعة مركبتك لتجنب الحصى وترك مسافة أمان كافية بينك وبين المركبات الأخرى والسماح بالتجاوز' , 'answer2' : 'زيادة سرعة مركبتك و المسافة بينك وبين المركبات الأخرى وعدم القيام بالتجاوز.' , 'answer3' : 'تخفيض سرعة مركبتك وترك مسافة أمان كافية بينك وبين المركبات الأخرى والسماح بالتجاوز' ,'answer4' : 'تخفيض سرعة مركبتك وترك مسافة أمان كافية بينك وبين المركبات الأخرى وعدم القيام بالتجاوز' , 'num' : 4 ,'true' : 4 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/22.jpg?alt=media&token=58796243-f000-4f9d-82e9-d5a0dd5c6a5e' }
    ,{'quastion' : 'ماذا تعني لك الاشارة الموجودة بالصورة' , 'answer1' : 'يوجد خطر من جهة اليسار' , 'answer2' : 'يوجد خطر من جهة اليمين' , 'answer3' : ' الانعطاف الى اليسار' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/51.jpg?alt=media&token=53b44741-1223-4894-a3eb-4a2b8f5c1d29' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'تخفيض سرعة مركبتك والالتزام بمسربك وعدم التجاوز' , 'answer2' : 'زيادة سرعة مركبتك والالتزام بمسربك وعدم التجاوز' , 'answer3' : 'تخفيض سرعة مركبتك وتغيير مسربك الى المسرب المناسب وعدم التجاوز' ,'answer4' : 'تخفيض سرعة مركبتك وتغيير مسربك الى المسرب المناسب والسماح بالتجاوز' , 'num' : 4 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/21.jpg?alt=media&token=519eef20-619e-498a-94eb-7434ddc099cb' }
    ,{'quastion' : 'يدخل أول أكسيد الكربون إلى غرفة السيارة إذا كانت أبواب السيارة مفتوحة' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'قد يحشر رأس أو يد الطفل في النافذة إذا عبث بمفتاح النافذة الكهربائي' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'على سائق الدراجة قبل ان يبدأ القيادة' , 'answer1' : 'إرتداء أي نوع من اللباس يغطي جسده' , 'answer2' : 'إرتداء اللباس الصحيح والمناسب' , 'answer3' : 'لاشئ مما ذكر' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 ,  }
    ,{'quastion' : 'في الصور التي امامك يكون ترتيب الاولوية' , 'answer1' : '1 - 2 - 3' , 'answer2' : '1 - 3 - 2' , 'answer3' : '3 - 1 - 2' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/210.jpg?alt=media&token=de44514f-ff9b-4e96-8b59-1ad7c6848810' }
    ,{'quastion' : 'تساعد أحزمة الامان في إبقاء السائق والراكب في موضعيهما الصحيحين' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'في الصورة التي امامك تكون الاولوية' , 'answer1' : 'للمركبة رقم (1)' , 'answer2' : 'للمركبة رقم (2)' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/215.jpg?alt=media&token=705a8c92-b27f-4c14-8a58-81f3d1aa1c14' }
    ,{'quastion' : 'الإجراء الصحيح عند اقترابك من التقاطع ورؤيتك للخط العرضي المتصل' , 'answer1' : 'متابعة السير دون التوقف' , 'answer2' : 'تخفيض السرعة والتوقف قبل الخط وإعطاء الأولوية للمركبات صاحبة حق الأولوية' , 'answer3' : 'التوقف عند الضرورة قبل استئناف السير' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/44.jpg?alt=media&token=68f1365d-512d-478c-8993-fbdc9fa9acd8' }
    ,{'quastion' : 'عند التقابل على طريق منحدر' , 'answer1' : 'على السائق الذي يقود مركبته في الاتجاه المنحدر من الطريق الالتزام باقصى يمينه او ايقاف مركبته تماما وذلك لتمكين المركبة الصاعدة من المرور اذا كان عرض الطريق لا يسمح بمرور المركبتين معا' , 'answer2' : 'على سائق المركبة الصاعدة الموجودة بالقرب من قسم عريض من الطريق التوقف فيه وذلك لتمكين المركبة الموجودة في الاتجاه المقابل من المرور' , 'answer3' : 'جميع ماذكر' ,'answer4' : 'null' , 'num' : 3 ,'true' : 3 ,  }
    ,{'quastion' : 'الحروق هي عبارة عن إصابات تحدث في الجلد وانسجة الجسم الأخرى بسب' , 'answer1' : 'التعرض للشمس او الحرارة الجافة او الرطبة' , 'answer2' : 'المواد الكيماوية مثل الاحماض والقلويات والمواد المشعة' , 'answer3' : ' التيارات الكهربائية' ,'answer4' : 'جميع ما ذكر' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'ماذا تعني لك الاشارة الموجودة بالصورة' , 'answer1' : 'يوجد خطر من جهة اليمين' , 'answer2' : 'يوجد خطر من جهة اليسار' , 'answer3' : 'الانعطاف الى اليمين' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/52.jpg?alt=media&token=6914636c-4c1c-448b-bfda-d4d4bc3e713f' }
    ,{'quastion' : 'من أجزاء نظام التبريد بالماء' , 'answer1' : 'المشع ( الرديتر)' , 'answer2' : 'طلبمة ماء' , 'answer3' : 'الثيرموس' ,'answer4' : ' جميع ماذكر صحيح' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'ماذا تعني لك الاشارة الموجودة بالصورة' , 'answer1' : 'الاتعطاف الى اليسار' , 'answer2' : 'الانعطاف الى اليمين' , 'answer3' : 'التوقف' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/46.jpg?alt=media&token=0a672701-c6be-4665-aea0-1f80e0a578f4' }
    ,{'quastion' : 'وظيفة نظام الوقود في المركبة هي أمداد الكربورتير بكمية وقود كافية' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'زيادة سرعة مركبتك قبل الوصول إلى التقاطع وإعطاء الاولوية للمركبات الأخرى' , 'answer2' : 'الوقوف التام بمركبتك قبل الوصول إلى التقاطع وإعطاء الاولوية للمركبات الأخرى' , 'answer3' : 'تخفيض سرعة مركبتك قبل الوصول إلى التقاطع وإعطاء الاولوية للمركبات صاحبة حق الأولوية' ,'answer4' : 'لا شيء مما ذكر' , 'num' : 3 ,'true' : 3 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/27.jpg?alt=media&token=1401933e-b266-415e-ad06-ee94c1adf911' }
    ,{'quastion' : 'التقاطع المتكافئ' , 'answer1' : 'تقاطع غير محكوم بشرطي مرور ولاضوابط مرورية كالإشارات الضوئية والشواخص المرورية والعلامات الأرضية' , 'answer2' : 'تقاطع محكوم بشرطي مرور وضوابط مرورية كالإشارات الضوئية والشواخص المرورية والعلامات الأرضية' , 'answer3' : 'تقاطع غير محكوم بشرطي مرور ولكن يوجد ضوابط مرورية كالإشارات الضوئية والشواخص المرورية العلامات الأرضية' ,'answer4' : 'لاشئ مما ذكر' , 'num' : 4 ,'true' : 1 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'زيادة سرعة مركبتك قبل الوصول إلى التقاطع وإعطاء الاولوية للمركبات الأخرى' , 'answer2' : 'الوقوف التام بمركبتك قبل الوصول إلى التقاطع وإعطاء الاولوية للمركبات الأخرى' , 'answer3' : 'تخفيض سرعة مركبتك قبل الوصول إلى التقاطع وإعطاء الاولوية للمركبات صاحبة حق الأولوية' ,'answer4' : ' جميع ما ذكر صحيح' , 'num' : 4 ,'true' : 3 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/27.jpg?alt=media&token=1401933e-b266-415e-ad06-ee94c1adf911' }
    ,{'quastion' : 'في الصورة التي امامك وقوف المركبات صحيح' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/244.jpg?alt=media&token=cbe38e92-c457-48aa-8d33-f8009f85e31f' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'زيادة سرعة مركبتك والانعطاف نحو اليسار' , 'answer2' : 'تخفيض سرعة مركبتك والانعطاف نحو اليسار' , 'answer3' : 'زيادة سرعة مركبتك والانعطاف نحو اليمين' ,'answer4' : 'تخفيض سرعة مركبتك والانعطاف نحو اليمين' , 'num' : 4 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/41.jpg?alt=media&token=475ff929-a9b0-43f0-873e-6ae092cf864d' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'سلوك هذا الطريق بحذر كونه يوجد دوار' , 'answer2' : 'عدم سلوك هذا الطريق كونه مخصص لحركة المشاه فقط' , 'answer3' : 'لا شىء مما ذكر' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/33.jpg?alt=media&token=96910bc9-3f80-466c-94fa-0dcfe2f459ec' }
    ,{'quastion' : 'ان الرياح التي تؤثر على المركبة اثناء عملية التجاوز كما هو مبين بالرسم' , 'answer1' : 'رياح طبيعية' , 'answer2' : 'رياح التفريغ' , 'answer3' : 'لاشئ مما ذكر' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/8.jpg?alt=media&token=bcfa61a6-7375-4f6c-a763-380bb1bf1df3' }
    ,{'quastion' : 'يعاقب السائق بالحبس مدة لا تقل عن ثلاثة أشهر ولا تزيد على ثلاث سنوات لمن ارتكب المخالفة التالية' , 'answer1' : 'إذا تسبب سائق المركبة أثناء قيادتها بوفاة إنسان أو تسبب بإحداث عاهة دائمة له' , 'answer2' : 'محاولة الهرب من مكان حادث ارتكبه' , 'answer3' : 'عدم إعلام أول مركز أمني أو دورية شرطه بحادث سير ارتكبه أثناء قيادة مركبة وأدى إلى إصابة شخص' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 ,  }
    ,{'quastion' : ' الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'عليك سلوك هذا الطريق بحذر شديد اذا كان إرتفاع مركبتك يزيد عن الرقم المدون' , 'answer2' : 'عليك سلوك طريق آخر' , 'answer3' : 'عليك سلوك طريق آخر اذا كان إرتفاع مركبتك يزيد عن الرقم المدون' ,'answer4' : 'null' , 'num' : 3 ,'true' : 3 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/36.jpg?alt=media&token=d5564fb1-da87-4a53-8492-ab3d65f3b6a2' }
    ,{'quastion' : 'في الصورة التي امامك تقف المركبة الحمراء في المكان الصحيح' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/241.jpg?alt=media&token=869f0578-fd9d-4360-ad47-9b031af3f38b' }
    ,{'quastion' : 'في الصورة التي امامك التصرف الذي تقوم به المركبة صحيح' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/229.jpg?alt=media&token=8394bbc0-890d-4387-8290-f2080153774b' }
    ,{'quastion' : 'هذه العلامة الارضيه تعني' , 'answer1' : 'مواقف للمركبات بشكل زاوية على الطريق' , 'answer2' : 'مواقف للمركبات موازية للطريق' , 'answer3' : 'ممنوع الوقوف' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/188.jpg?alt=media&token=02ec2234-1634-4c67-aa1d-26f17c6e402d' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة ' , 'answer1' : 'التوقف في حال خلو الطريق من المركبات والمشاة' , 'answer2' : 'عدم التوقف إلا إذا كنت تقوم بتحميل وتنزيل الركاب أو تحميل وتنزيل البضائع' , 'answer3' : 'عدم الوقوف والتوقف نهائياً كون توقفك ووقوفك يؤدى لإعاقة حركة المرور' ,'answer4' : 'null' , 'num' : 3 ,'true' : 3 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/39.jpg?alt=media&token=2bf986d9-ff45-45d9-839b-2ec963605934' }
    ,{'quastion' : 'من الأهداف الرئيسية لرجال السير هو' , 'answer1' : 'حماية السائق من ايذاء نفسه او ايذاء الاخرين' , 'answer2' : 'ضمان فعالية النظام المروري وضمان تفاعل عناصره بالطريقة الصحيحة' , 'answer3' : 'توعية مستخدمي الطريق' ,'answer4' : 'جميع ما ذكر' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'تكون فرصة تجنب الإصابات الخطيرة كبيرة جداً لسائقي الدراجات إذا قاموا بإرتداء' , 'answer1' : 'واقية الرأس ( الخوذة) المناسبة' , 'answer2' : 'نظارات طبية' , 'answer3' : 'قبعة تغطي الرأس بشكل كامل' ,'answer4' : 'لاشئ مما ذكر' , 'num' : 4 ,'true' : 1 ,  }
    ,{'quastion' : 'من اهم اجزاء نظام التزييت في المحرك' , 'answer1' : 'مضخة الزيت' , 'answer2' : 'وعاء حفظ الزيت (الكرتير)' , 'answer3' : ' فلتر الزيت' ,'answer4' : 'جميع ماذكر' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'زيادة سرعة مركبتك قبل الوصول إلى التقاطع وإعطاء الاولوية للمركبات الاخرى' , 'answer2' : 'الوقوف التام بمركبتك قبل الوصول إلى التقاطع وإعطاء الاولوية للمركبات صاحبة حق الأولوية' , 'answer3' : 'تخفيض سرعة مركبتك قبل الوصول إلى التقاطع وإعطاء الاولوية للمركبات الاخرى' ,'answer4' : 'جميع ما ذكر صحيح' , 'num' : 4 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/28.jpg?alt=media&token=137ef052-c7bb-41a5-86ee-2471d325d011' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'عليك سلوك هذا الطريق بحذر شديد اذا كان عرض مركبتك يزيد عن الرقم المدون' , 'answer2' : ' عليك سلوك طريق آخر' , 'answer3' : 'عليك سلوك طريق آخر اذا كان عرض مركبتك يزيد عن الرقم المدون' ,'answer4' : 'null' , 'num' : 3 ,'true' : 3 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/28.jpg?alt=media&token=137ef052-c7bb-41a5-86ee-2471d325d011' }
    ,{'quastion' : 'وظيفة البطارية' , 'answer1' : 'تزويد محرك البدء بالتيار اللازم عند بداية التشغيل' , 'answer2' : 'تزويد الأضوية والأجهزة الإضافية الأخرى أثناء وقوف المحرك' , 'answer3' : 'تخزين الطاقة أثناء دوران المحرك بواسطة المولد' ,'answer4' : 'جميع ماذكر' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'تخفيض سرعة مركبتك لغاية 30كيلومتر/ساعة لتتمكن من الوقوف قبل الممر لإعطاء الأولوية للمشاة في حال وجودهم' , 'answer2' : 'تخفيض سرعة مركبتك لغاية 40كيلومتر/ساعة والعمل على الوقوف قبل الممر لإعطاء الأولوية' , 'answer3' : 'تخفيض سرعة مركبتك 50كيلومتر/ساعة والعمل على الوقوف قبل الممر لإعطاء الأولوية' ,'answer4' : 'تخفيض سرعة مركبتك 60كيلومتر/ساعة والعمل على الوقوف قبل الممر لإعطاء الأولوية' , 'num' : 4 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/23.jpg?alt=media&token=5545875d-7e06-4272-9a91-2770949d2138' }
    ,{'quastion' : 'من انواع النزيف' , 'answer1' : 'نزيف خارجي وهو سيلان الدم خارج الجسم' , 'answer2' : 'نزيف داخلي وهو سيلان الدم داخل تجاويف الجسم مثل تجويف الجمجمة والصدر و البطن والمفاصل' , 'answer3' : 'الإجابة الأولى + الإجابة الثانية' ,'answer4' : 'لا شيء مما ذكر' , 'num' : 4 ,'true' : 3 ,  }
    ,{'quastion' : 'اذا التقت مركبتان من اتجاهين متقابلين في طريق لا يكفي عرضه لمرورهما معا فعليهما' , 'answer1' : 'تخفيف السرعة' , 'answer2' : 'تخطي حافة الطريق اذا اقتضت الضرورة' , 'answer3' : 'جميع ماذكر' ,'answer4' : 'null' , 'num' : 3 ,'true' : 3 ,  }
    ,{'quastion' : 'يجب ضبط المرايا' , 'answer1' : 'قبل الدخول الى المنعطفات' , 'answer2' : 'عند الرجوع الى الخلف' , 'answer3' : 'عند التجاوز' ,'answer4' : 'قبل التحرك' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'الاجراءات التي تتخذ لفاقد الوعي' , 'answer1' : ' يجب استدعاء سيارة الإسعاف فورا' , 'answer2' : 'التأكد من أن المصاب يتنفس بشكل طبيعي' , 'answer3' : 'التأكد من أن قلبه يعمل' ,'answer4' : 'جميع ما ذكر' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'في الصورة التي امامك يريد السائق التوجه الى' , 'answer1' : 'التوجه الى اليمين' , 'answer2' : 'التوجه الى اليسار' , 'answer3' : 'تخفيف السرعة' ,'answer4' : 'null' , 'num' : 3 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/3.jpg?alt=media&token=8dae424d-b08f-48c3-82ed-507a2874feef' }
    ,{'quastion' : 'في الصورة التي امامك يريد السائق التوجه' , 'answer1' : 'الى اليمين' , 'answer2' : 'الى اليسار' , 'answer3' : 'تخفيف السرعة' ,'answer4' : 'null' , 'num' : 3 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/1.jpg?alt=media&token=abb9796f-9d0f-4b98-a931-f2a413a0c8da' }
    ,{'quastion' : 'في الصورة التي امامك تكون الاولوية' , 'answer1' : 'للمركبة رقم (1)' , 'answer2' : 'للمركبة رقم (2)' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/218.jpg?alt=media&token=f9ed1e84-7267-4c03-8d58-7b7169d3f922' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'تخفيض سرعة مركبتك لكي تستطيع اجتياز هذا الانخفاض بأمان' , 'answer2' : 'تخفيض سرعة مركبتك، لكي تستطيع اجتياز المطب بأمان' , 'answer3' : 'زيادة سرعة مركبتك، لكي تستطيع اجتياز المطب بأمان' ,'answer4' : 'لاشئ مما ذكر' , 'num' : 4 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/19.jpg?alt=media&token=17578177-5abd-415a-9c60-2069881ad0da' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'تخفيض سرعة مركبتك لغاية 30كيلومتر/ساعة لتتمكن من الوقوف لإعطاء الأولوية لطلاب المدارس' , 'answer2' : 'تخفيض سرعته لغاية 40كيلومتر/ساعة والعمل على الوقوف لإعطاء الأولوية لطلاب المدارس' , 'answer3' : 'تخفيض سرعته لغاية 50كيلومتر/ساعة والعمل على الوقوف لإعطاء الأولوية لطلاب المدارس' ,'answer4' : 'تخفيض سرعته لغاية 60كيلومتر/ساعة والعمل على الوقوف قبل الممر لإعطاء الأولوية لطلاب المدارس' , 'num' : 4 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/24.jpg?alt=media&token=f49275a4-909d-431a-b83d-90bef189315b' }
    ,{'quastion' : 'في الصورة التي امامك يجب على المركبة الصفراء' , 'answer1' : 'التوقف للإفساح للشاحنة بالالتفاف' , 'answer2' : 'الالتفاف إلى اليمين' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/225.jpg?alt=media&token=b559c6bc-3919-4be0-b507-c6560b78f205' }
    ,{'quastion' : 'في الصورة التي امامك المركبة الزرقاء تتجاوز بشكل صحيح' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/234.jpg?alt=media&token=c5f733e7-502d-47af-8554-f4748123e8f3' }
    ,{'quastion' : 'ان تخفيض الحرارة بين السطوح المحتكة هي جزء من وظائف نظام التزييت في المحرك' , 'answer1' : 'نعم' , 'answer2' : 'لا' , 'answer3' : 'null' ,'answer4' : 'null' , 'num' : 2 ,'true' : 1 ,  }
    ,{'quastion' : 'تشمل اجزاء نظام التوجيه' , 'answer1' : 'عجلة القيادة' , 'answer2' : 'عمود التوجيه الرئيسي' , 'answer3' : 'مجموعة التوجيه' ,'answer4' : 'جميع ماذكر' , 'num' : 4 ,'true' : 4 ,  }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'زيادة سرعة مركبتك، لتتناسب مع سرعة المنعطف والسماح بالتجاوز' , 'answer2' : 'تخفيض سرعة مركبتك، لتتناسب مع سرعة المنعطفات وعدم التجاوز' , 'answer3' : 'تخفيض سرعة مركبتك، لتتناسب مع سرعة المنعطف والسماح بالتجاوز' ,'answer4' : 'إيقاف مركبتك ثم التحرك ببطء نحو المنعطف لدخوله بأمان ومنع التجاوز' , 'num' : 4 ,'true' : 2 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/13.jpg?alt=media&token=c151bdd3-704c-4f15-9142-3e2f69599fb6' }
    ,{'quastion' : 'الإجراء الصحيح عند رؤيتك لهذه الشاخصة أثناء القيادة' , 'answer1' : 'تخفيض سرعة مركبتك والسماح للمركبات الأخرى الموجودة في الاتجاه الآخر بالمرور' , 'answer2' : 'تخفيف السرعة ومتابعة سيرك وعدم السماح للمركبات الأخرى الموجودة في الاتجاه الآخر بالمرور لأن اولوية المرور لك' , 'answer3' : 'ملاحظة وضع الطريق وبناءا عليه تسير او تعطي الأولوية للمركبات القادمة' ,'answer4' : 'لاشئ مماذكر' , 'num' : 4 ,'true' : 1 , 'imageurl' : 'https://firebasestorage.googleapis.com/v0/b/rest-46ae1.appspot.com/o/31.jpg?alt=media&token=da9ec186-5f28-4283-9f40-473fc3307d47' }
  ];

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      
      body: Background(
        child: Form(
          key: formstate,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 120,),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "التسجيل",
                  style: TextStyle(
                      fontFamily: "Abed",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              SizedBox(height: size.height * 0.03),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  onSaved: (val){
                    username = val;
                  },
                  validator: (val){
                    if(val == null || val.isEmpty){
                      return "يرجى إدخال إسم";
                    }
                    if(val.length < 4){
                      return "يرجى إدخال إسم صالح";
                    }
                    if(val.length > 100){
                      return "يرجى إدخال إسم صالح";
                    }
                    return null ;
                  },
                  style: TextStyle(
                    fontFamily: "Abed",
                  ),
                  decoration: InputDecoration(
                      labelText: "الأسم"
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (val){
                    if(val == null || val.isEmpty){
                      return "يرجى إدخال رقم الهاتف ";
                    }
                    return null;
                  },
                  onSaved: (val){
                    phono = val;
                  },
                  style: TextStyle(
                    fontFamily: "Abed",
                  ),
                  decoration: InputDecoration(
                      labelText: "رقم الهاتف"
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
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
                      labelText: "البريد الإلكتروني"
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (val){
                    if (val == null) {
                      return "يجب أن تكون كلمة السر ما بين 8 إلى 25 حرف";
                    }
                    if (val.length > 25) {
                      return "يجب أن تكون كلمة السر ما بين 8 إلى 25 حرف";
                    }
                    if (val.length < 4) {
                      return "يجب أن تكون كلمة السر ما بين 8 إلى 25 حرف";
                    }
                    return null;
                  },
                  onSaved: (val){
                    mypassword = val;
                  },
                  style: TextStyle(
                    fontFamily: "Abed",
                  ),
                  decoration: InputDecoration(
                      labelText: "كلمة السر"
                  ),
                  obscureText: true,
                ),
              ),

              SizedBox(height: size.height * 0.05),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () async {
                    var user = await signup();
                    final prefs = await SharedPreferences.getInstance();
                    if (user != null) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(myemail.replaceAll(' ', '',).toLowerCase()).set({
                        'username': username,
                        'email': myemail.toLowerCase().replaceAll(' ', '',),
                        "phone": phono,
                        "open" : "لم يجتاز أي إختبار بعد",
                        "final" : "لم يجتاز أي إختبار بعد",
                        "ban" : "مفتوح",
                        "message" : "تهانينا تم إنشاء حسابك بنجاح ",
                        "typemessage" : "true",
                        "1" : null,
                        "2" : null,
                      });
                      if(prefs.getString('list') == null){
                        var a = jsonEncode(list);
                        await prefs.setString('list', a);
                        await prefs.setInt('day', DateTime.now().day);
                        await prefs.setInt('month', DateTime.now().month );
                        await prefs.setInt('update', 2);
                      }
                      await prefs.setString('name', username);
                      await prefs.setString('phone', phono);
                      await prefs.setString('rate', 'لم يجتاز أي اختبار بعد');
                      await prefs.setString('num', 'لم يجتاز أي اختبار بعد');
                      await prefs.setString('sign', 'true');
                      Navigator.of(context)
                          .pushReplacementNamed("/home");
                    }
                  },
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
                      " التسجيل",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Abed",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()))
                  },
                  child: Text(
                    "هل لديك حساب بالفعل ؟ تسجيل",
                    style: TextStyle(
                        fontFamily: "Abed",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
