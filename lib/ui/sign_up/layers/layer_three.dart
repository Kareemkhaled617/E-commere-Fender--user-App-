import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/ui/login1/login_ui.dart';

import '../../../provider/login_controller.dart';
import '../theme_helper.dart';

class LayerThree extends StatefulWidget {
  @override
  State<LayerThree> createState() => _LayerThreeState();
}

class _LayerThreeState extends State<LayerThree> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  String? fName,lName,email,phone,pass;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(25, 100, 25, 10),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 235,
              ),
              Container(
                decoration: ThemeHelper().inputBoxDecorationShaddow(),

                child: TextFormField(
                  decoration: ThemeHelper().textInputDecoration(
                      'First Name', 'Enter your first name'),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter a valid Name";
                    }
                    return null;
                  },
                  onSaved: (val){
                    setState(() {
                      fName=val;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                child: TextFormField(
                  decoration: ThemeHelper()
                      .textInputDecoration('Last Name', 'Enter your last name'),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter a valid Name";
                    }
                    return null;
                  },
                  onSaved: (val){
                    setState(() {
                      lName=val;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                child: TextFormField(
                  decoration: ThemeHelper().textInputDecoration(
                      "E-mail address", "Enter your email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if ((val!.isEmpty)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                  onSaved: (val){
                    setState(() {
                      email=val;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                child: TextFormField(
                  decoration: ThemeHelper().textInputDecoration(
                      "Mobile Number", "Enter your mobile number"),
                  keyboardType: TextInputType.phone,
                  validator: (val) {
                    if ((val!.isEmpty) && RegExp(r"^(\d+)*$").hasMatch(val)) {
                      return "Enter a valid phone number";
                    }
                    return null;
                  },
                  onSaved: (val){
                    setState(() {
                      phone=val;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                child: TextFormField(
                  obscureText: true,
                  decoration: ThemeHelper()
                      .textInputDecoration("Password*", "Enter your password"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  onSaved: (val){
                    setState(() {
                      pass=val;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FormField<bool>(
                builder: (state) {
                  return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: checkboxValue,
                              onChanged: (value) {
                                setState(() {
                                  checkboxValue = value!;
                                  state.didChange(value);
                                });
                              }),
                          const Text(
                            "I accept all terms and conditions.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.errorText ?? '',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Theme.of(context).errorColor,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  );
                },
                validator: (value) {
                  if (!checkboxValue) {
                    return 'You need to accept terms and conditions';
                  } else {
                    return null;
                  }
                },
              ),
              InkWell(
                onTap: (){
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    context.read<LoginController>().register(email: email!,lName: lName,fName: fName,phone: phone,password: pass).whenComplete(() {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginPage()));
                    });
                  }
                },
                child: Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: Container(
                    width: 160,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Color(0xFF024335),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Text(
                        'Sign up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Text(
                    "Already have an account ?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                      child:const Text('Sign in',style: TextStyle(color: Colors.blue),))
                ],
              ),
              const Text(
                "Or create account using social media",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: FaIcon(
                      FontAwesomeIcons.googlePlus,
                      size: 35,
                      color: HexColor("#EC2D2F"),
                    ),
                    onTap: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ThemeHelper().alartDialog("Google Plus",
                                "You tap on GooglePlus social icon.", context);
                          },
                        );
                      });
                    },
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border:
                            Border.all(width: 5, color: HexColor("#40ABF0")),
                        color: HexColor("#40ABF0"),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.twitter,
                        size: 23,
                        color: HexColor("#FFFFFF"),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ThemeHelper().alartDialog("Twitter",
                                "You tap on Twitter social icon.", context);
                          },
                        );
                      });
                    },
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  GestureDetector(
                    child: FaIcon(
                      FontAwesomeIcons.facebook,
                      size: 35,
                      color: HexColor("#3E529C"),
                    ),
                    onTap: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ThemeHelper().alartDialog("Facebook",
                                "You tap on Facebook social icon.", context);
                          },
                        );
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
