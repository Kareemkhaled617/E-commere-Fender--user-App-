
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/main.dart';
import 'package:test_provider/provider/login_controller.dart';
import 'package:test_provider/ui/search/settings_page.dart';

import '../device_info.dart';
import '../login1/login_ui.dart';
import 'lock_screen_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<LoginController>(builder: (context, value, child) {
          return FutureBuilder(
              future: value.getDataUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData && value.userData.isNotEmpty) {
                  final map = snapshot.data as Map;
                  return Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView(
                        children: [
                          BigUserCard(
                            cardColor: Colors.blueGrey,
                            userName: '${map['f_name']} ${map['l_name']}',
                            userProfilePic: NetworkImage(map['image']),
                            cardActionWidget: SettingsItem(
                              icons: Icons.edit,
                              iconStyle: IconStyle(
                                withBackground: true,
                                borderRadius: 50,
                                backgroundColor: Colors.yellow[600],
                              ),
                              title: "Modify",
                              subtitle: "Tap to change your data",
                              onTap: () {},
                            ),
                          ),
                          SettingsGroup(
                            items: [
                              SettingsItem(
                                onTap: () {},
                                icons: CupertinoIcons.pencil_outline,
                                iconStyle: IconStyle(),
                                title: 'Appearance',
                                subtitle: "Make Ziar'App yours",
                              ),
                              SettingsItem(
                                onTap: () {},
                                icons: Icons.dark_mode_rounded,
                                iconStyle: IconStyle(
                                  iconsColor: Colors.white,
                                  withBackground: true,
                                  backgroundColor: Colors.red,
                                ),
                                title: 'Dark mode',
                                subtitle: "Automatic",
                                trailing: Switch.adaptive(
                                  value: false,
                                  onChanged: (value) {},
                                ),
                              ),
                              SettingsItem(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsPage()));
                                },
                                icons: Icons.language_rounded,
                                iconStyle: IconStyle(
                                  iconsColor: Colors.white,
                                  withBackground: true,
                                  backgroundColor: Colors.blue,
                                ),
                                title: 'Language',
                                subtitle: "Automatic",
                              ),
                            ],
                          ),
                          SettingsGroup(
                            items: [
                              SettingsItem(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const DeviceInfo()));
                                },
                                icons: Icons.info_rounded,
                                iconStyle: IconStyle(
                                  backgroundColor: Colors.purple,
                                ),
                                title: 'About',
                                subtitle: "Learn more about Ziar'App",
                              ),
                            ],
                          ),
                          // You can add a settings title
                          SettingsGroup(
                            settingsGroupTitle: "Account",
                            items: [
                              !context.watch<LoginController>().signIp
                                  ? SettingsItem(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      },
                                      icons: Icons.exit_to_app_rounded,
                                      title: "Sign in",
                                    )
                                  : SettingsItem(
                                      onTap: () {
                                        value.clearData().whenComplete(() {
                                          value.saveSignIn(false);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyApp()));
                                        });
                                      },
                                      icons: Icons.exit_to_app_rounded,
                                      title: "Sign Out",
                                    ),
                              SettingsItem(
                                onTap: () {},
                                icons: CupertinoIcons.delete_solid,
                                title: "Delete account",
                                titleStyle: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView(
                        children: [
                          BigUserCard(
                            cardColor: Colors.blueGrey,
                            userName: 'Guest',
                            userProfilePic: const AssetImage(
                                'assets/images/profile_pic.png'),
                            cardActionWidget: SettingsItem(
                              icons: Icons.edit,
                              iconStyle: IconStyle(
                                withBackground: true,
                                borderRadius: 50,
                                backgroundColor: Colors.yellow[600],
                              ),
                              title: "Modify",
                              subtitle: "Tap to change your data",
                              onTap: () {},
                            ),
                          ),
                          SettingsGroup(
                            items: [
                              SettingsItem(
                                onTap: () {},
                                icons: CupertinoIcons.pencil_outline,
                                iconStyle: IconStyle(),
                                title: 'Appearance',
                                subtitle: "Make Ziar'App yours",
                              ),
                              SettingsItem(
                                onTap: () {},
                                icons: Icons.dark_mode_rounded,
                                iconStyle: IconStyle(
                                  iconsColor: Colors.white,
                                  withBackground: true,
                                  backgroundColor: Colors.red,
                                ),
                                title: 'Dark mode',
                                subtitle: "Automatic",
                                trailing: Switch.adaptive(
                                  value: false,
                                  onChanged: (value) {},
                                ),
                              ),
                              SettingsItem(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsPage()));
                                },
                                icons: Icons.language_rounded,
                                iconStyle: IconStyle(
                                  iconsColor: Colors.white,
                                  withBackground: true,
                                  backgroundColor: Colors.blue,
                                ),
                                title: 'Language',
                                subtitle: "Automatic",
                              ),
                            ],
                          ),
                          SettingsGroup(
                            items: [
                              SettingsItem(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const DeviceInfo()));
                                },
                                icons: Icons.info_rounded,
                                iconStyle: IconStyle(
                                  backgroundColor: Colors.purple,
                                ),
                                title: 'About',
                                subtitle: "Learn more about Ziar'App",
                              ),
                            ],
                          ),
                          // You can add a settings title
                          SettingsGroup(
                            settingsGroupTitle: "Account",
                            items: [
                              SettingsItem(
                                onTap: () {},
                                icons: Icons.exit_to_app_rounded,
                                title: "Sign Out",
                              ),
                              SettingsItem(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                                },
                                icons: Icons.exit_to_app_rounded,
                                title: "Sign in",
                              ),
                              SettingsItem(
                                onTap: () {},
                                icons: CupertinoIcons.delete_solid,
                                title: "Delete account",
                                titleStyle: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              });
        }),
        !context.watch<LoginController>().signIp
            ? const LockScreen()
            : Container(),
      ],
    );
  }
}
