import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
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
  File? imageFile;

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: _openCamera,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.camera,
                          color: Colors.purple,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: _openGallery,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.image,
                          color: Colors.purple,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  void _openCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      final imageTemp = File(pickedFile.path);
      setState(() {
        imageFile = imageTemp;
      });
    } else {
    }

    Navigator.pop(context);
  }

  void _openGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final imageTemp = File(pickedFile.path);
      setState(() {
        imageFile = imageTemp;
      });
    } else {

    }

    Navigator.pop(context);
  }

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
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 48,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Flexible(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width:80,
                            height: 80,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(16)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: imageFile == null
                                  ? Image.network(
                                'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                                fit: BoxFit.fill,
                              )
                                  : Image.file(
                                imageFile!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: _showImageDialog,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                border: Border.all(
                                    width: 2, color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  imageFile == null
                                      ? Icons.add_a_photo
                                      : Icons.edit_outlined,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
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
