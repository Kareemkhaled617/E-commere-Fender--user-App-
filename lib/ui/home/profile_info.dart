import 'dart:core';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/login_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
var pro = Provider.of<LoginController>(context);
    void getUrlLauncher(Uri url) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back,color: Colors.blue,),onPressed: (){
          Navigator.of(context).pop();
        },),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: AvatarGlow(
              glowColor: const Color.fromARGB(255, 15, 233, 106),
              endRadius: 90.0,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 100),
              child: DottedBorder(
                radius: const Radius.circular(10),
                color: Colors.blue,
                strokeWidth: 8,
                borderType: BorderType.Circle,
                dashPattern: [1, 12],
                strokeCap: StrokeCap.butt,
                child:  Center(
                  child: SizedBox(
                    width: 130,
                    height: 130,
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(pro.userData['image'] ?? 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                      radius: 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            pro.userData['f_name']??'Guest',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text('Welcome'),
          TextButton(
              onPressed: () async {
                getUrlLauncher(Uri.parse('Kareemkhaled617@gmail.com'));
              },
              child: Text( pro.userData['username']??'')),
          TextButton(
              onPressed: () async {
                getUrlLauncher(Uri.parse('01157446858'));
              },
              child: Text(pro.userData['phone']??'')),
        ],
      ),
    ),),);
  }
}