import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/login_controller.dart';

import '../../../main.dart';
import '../../sign_up/forget_pass.dart';
import '../../sign_up/sign_up.dart';
import '../../sign_up/theme_helper.dart';

class LayerThree extends StatefulWidget {
  @override
  State<LayerThree> createState() => _LayerThreeState();
}

class _LayerThreeState extends State<LayerThree> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  String? email, pass;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(25, 100, 25, 10),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 250,
              ),
              Text(
                'Email',
                style: GoogleFonts.roboto(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey.shade700),
              ),
              const SizedBox(
                height: 20,
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
                  onSaved: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Password',
                style: GoogleFonts.roboto(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey.shade700),
              ),
              const SizedBox(
                height: 20,
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
                  onSaved: (val) {
                    setState(() {
                      pass = val;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context
                            .read<LoginController>()
                            .login(email: email!, password: pass)
                            .then((value) {
                          if (value['reply'] == true) {
                            context.read<LoginController>().saveUserData(
                                value['image'],
                                value['username'],
                                value['token'],
                                value['f_name'],
                                value['l_name']);
                            context.read<LoginController>().saveSignIn(true);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MyApp()));
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.bottomSlide,
                              title: 'Attend  !',
                              desc: 'This Account IsNot Exist',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          }
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
                            'Sign in',
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
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()));
                      },
                      child: const Text(
                        'Forget Password ?',
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Create Account ..",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignUP()));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Or Login using social media",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
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
