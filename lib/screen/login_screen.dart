import 'package:badinan_mobile_app/language/language.dart';
import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/main.dart';
import 'package:badinan_mobile_app/screen/login_screen2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _textPhoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isRememberMe = false;
  Language _selectedLanguage = Language.languageList()[0];


  @override
  void initState() {
    super.initState();
    _initializePreferences();
    _textPhoneNumber.addListener(_onPhoneNumberChanged);
  }

  void _onPhoneNumberChanged() {
    if (_textPhoneNumber.text == translation(context).labelEnterPhoneNumber) {
      // Eğer _textPhoneNumber içeriği labelEnterPhoneNumber ise boş hale getir
      _textPhoneNumber.text = '';
    }
  }

  Future<void> _initializePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedLanguageCode = prefs.getString('selected_language') ?? _selectedLanguage.languageCode;
    _selectedLanguage = Language.languageList().firstWhere((language) => language.languageCode == savedLanguageCode);

    _isRememberMe = prefs.getBool('remember_me') ?? false;
    if (_isRememberMe) {
      _textPhoneNumber.text = prefs.getString('phone_number') ?? '';
    } else {
      _textPhoneNumber.text = '';
    }
  }

  void _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone_number', _textPhoneNumber.text);
    prefs.setBool('remember_me', _isRememberMe);
  }

  Future<void> _saveLanguagePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selected_language', _selectedLanguage.languageCode);
  }

  void _onRememberMeChanged(bool? newValue) {
    if (newValue == null) return;

    setState(() {
      _isRememberMe = newValue;
    });

    if (_isRememberMe) {
      _savePreferences();
    } else {
      _clearPreferences();
    }

    _saveLanguagePreferences();
  }

  void _clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('phone_number');
    prefs.setBool('remember_me', false);
    _saveLanguagePreferences();
  }

  void _onLoginButtonPressed() {
    if (!_formKey.currentState!.validate()) return;

    // Verilerin API'ya gönderilmesi
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _onLanguageChanged(Language newLanguage) async {
    setState(() {
      _selectedLanguage = newLanguage;
    });
    await _saveLanguagePreferences();
    Locale _locale = await setLocale(_selectedLanguage.languageCode);
    MyApp.setLocale(context, _locale);
    _textPhoneNumber.text = '';
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
                color: Colors.grey,
              ),
              onChanged: (Language? language) {
                if (language != null) {
                  _onLanguageChanged(language);
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
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                _buildLogo(),
                SizedBox(height: 20),
                _buildLoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Image _buildLogo() {
    return Image.asset(
      'images/main_logo.png',
      height: 200,
      width: 300,
    );
  }

  Form _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildPhoneNumberField(),
          SizedBox(height: 10),
          _buildRememberMeCheckbox(),
          _buildLoginButton(),
        ],
      ),
    );
  }

  TextFormField _buildPhoneNumberField() {
    return TextFormField(
      controller: _textPhoneNumber,
      keyboardType: TextInputType.phone,
      maxLength: 11,
      style: TextStyle(color: Colors.white),
      decoration: _phoneNumberDecoration(),
      validator: _validatePhoneNumber,
    );
  }

  InputDecoration _phoneNumberDecoration() {
    return InputDecoration(
      hintText: translation(context).labelEnterPhoneNumber,
      counterText: '',
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide.none,
      ),
    );
  }

  String? _validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return translation(context).labelEnterValidPhoneNumber;
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return translation(context).labelInvalidCharacter;
    }
    if (_selectedLanguage.languageCode == 'tr') {
      if (!value.startsWith('0')) {
        return translation(context).labelPhoneNumberStartsWithZero;
      }
    } else if (_selectedLanguage.languageCode == 'en') {
      if (!value.startsWith('1')) {
        return translation(context).labelPhoneNumberStartsWithOne;
      }
    } else if (_selectedLanguage.languageCode == 'ar') {
      if (!value.startsWith('971')) {
        return translation(context).labelPhoneNumberStartsWith971;
      }
    }
    if (value.length != 11) {
      return translation(context).labelPhoneNumber11Digits;
    }

    return null;
  }

  Row _buildRememberMeCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isRememberMe,
          onChanged: _onRememberMeChanged,
          activeColor: Color(0xFFE65100),
        ),
        Text(
          translation(context).labelRememberMe,
        ),
      ],
    );
  }

  ElevatedButton _buildLoginButton() {
    return ElevatedButton(
      onPressed: _onLoginButtonPressed,
      style: ElevatedButton.styleFrom(primary: Color(0xFFE65100)),
      child: Text(
        translation(context).labelCodeSend,
      ),
    );
  }


}
