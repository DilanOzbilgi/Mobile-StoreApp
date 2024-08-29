import 'package:badinan_mobile_app/language/language.dart';
import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/main.dart';
import 'package:badinan_mobile_app/model/theme.dart';
import 'package:badinan_mobile_app/screen/saved_addresses_screen.dart';
import 'package:badinan_mobile_app/screen/settings_screen.dart';
import 'package:badinan_mobile_app/widget/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;
  bool _darkMode = false;

  void _navigateToSettingsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }
  void _navigateToAddressesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SavedAddressesScreen()),
    );
  }

  void _shareOnWhatsApp() async {
    final String text = 'Check out this amazing app!';
    final String url = 'https://play.google.com/store/apps/details?id=com.example.yourapp'; // Uygulamanın Play Store URL'si (Android için) (örnek olarak)

    final String whatsappUrl = "whatsapp://send?text=$text $url";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      // WhatsApp açılamazsa burada bir hata mesajı gösterebilirsiniz.
    }
  }

  void _openPlayStore() async {
    final String appId = 'com.example.yourapp'; // Uygulamanın Play Store'daki paket adı(örnek olarak)
    final String url = 'https://play.google.com/store/apps/details?id=$appId';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // URL açılamazsa burada bir hata mesajı gösterebilirsiniz.
    }
  }

  void _openAppStore() async {
    final String appId = '123456789'; // Uygulamanın App Store'daki App ID'si (örnek olarak)
    final String url = 'https://apps.apple.com/app/id$appId';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // URL açılamazsa burada bir hata mesajı gösterebilirsiniz.
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          translation(context).labelProfile,
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildOptionRow(
                      icon: Icons.settings,
                      title: translation(context).labelGeneralSettings,
                      iconColor: settingsIconColor,
                      onTap: _navigateToSettingsPage,
                    ),
                    buildDivider(),
                    buildOptionRow(
                      icon: Icons.dark_mode,
                      title: translation(context).labelDarkMode,
                      iconColor: darkModeIconColor,
                      trailingWidget: Switch(
                        value: Provider.of<ThemeProvider>(context).darkTheme,
                        onChanged: (value) {
                          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                        },
                      ),
                    ),
                    buildDivider(),
                    buildOptionRow(
                      icon: Icons.language,
                      title: translation(context).labelLanguage,
                      iconColor: languageIconColor,
                      trailingWidget: DropdownButton<Language>(
                        underline: const SizedBox(),
                        icon: const Icon(
                          Icons.language,
                          color: Colors.grey,
                        ),
                        onChanged: (Language? language) async {
                          if (language != null) {
                            Locale _locale = await setLocale(language.languageCode);
                            MyApp.setLocale(context, _locale);
                          }
                        },
                        items: Language.languageList()
                            .map<DropdownMenuItem<Language>>(
                              (e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  e.flag,
                                  style: const TextStyle(fontSize: 30),
                                ),
                                Text(e.name)
                              ],
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),
                    buildDivider(),
                    buildOptionRow(
                      icon: Icons.location_on,
                      iconColor: locationIconColor,
                      title: translation(context).labelSavedAddresses,
                      onTap: _navigateToAddressesPage,
                    ),
                    buildDivider(),
                    buildOptionRow(
                      icon: Icons.article,
                      title: translation(context).labelTermsAndConditions,
                      iconColor: articleIconColor,
                        onTap: (){
                          // Şartlar & Koşullar metninin hazırlanması gerekiyor
                        }
                    ),
                    buildDivider(),
                    buildOptionRow(
                      icon: Icons.privacy_tip,
                      title: translation(context).labelPrivacyPolicy,
                      iconColor: privacyIconColor,
                      onTap: (){
                        // Gizlilik politikası metninin hazırlanması gerekiyor.
                      }
                    ),
                    buildDivider(),
                    buildOptionRow(
                      icon: Icons.star,
                      title: translation(context).labelRateApp,
                      iconColor: starIconColor,
                      onTap: () {
                        if (Platform.isAndroid) {
                          _openPlayStore();
                        } else if (Platform.isIOS) {
                          _openAppStore();
                        }
                      },
                    ),
                    buildDivider(),
                    buildOptionRow(
                      icon: Icons.share,
                      title: translation(context).labelShareApp,
                      iconColor: shareIconColor,
                      onTap: _shareOnWhatsApp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget buildOptionRow({
    required IconData icon,
    required String title,
    Color? iconColor,
    Widget? trailingWidget,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailingWidget != null ? trailingWidget : SizedBox(),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Divider(
        color: Colors.grey,
        height: 12,
        thickness: 1,
      ),
    );
  }
}

Color settingsIconColor = Colors.blue;
Color darkModeIconColor = Colors.black;
Color languageIconColor = Colors.purple;
Color locationIconColor = Colors.red;
Color articleIconColor = Colors.green;
Color privacyIconColor = Colors.orange;
Color starIconColor = Colors.yellow;
Color shareIconColor = Colors.pink;
