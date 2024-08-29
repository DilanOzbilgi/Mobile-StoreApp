import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/screen/register_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 10),
                _buildHeaderText(translation(context).labelEnterCode),
                _buildCodeInputField(context),
                SizedBox(height: 20),
                _buildLoginButton(context),
                SizedBox(height: 10),
                _buildResendCodeButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'images/main_logo.png',
      height: 200,
      width: 300,
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCodeInputField(BuildContext context) {
    return TextFormField(
      controller: _codeController,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: _codeInputDecoration(context),
      validator: (value) => _validateCode(context, value),
    );
  }

  InputDecoration _codeInputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: translation(context).labelEnterCode,
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

  String? _validateCode(BuildContext context, String? value) {
    if (value!.isEmpty) {
      return translation(context).labelValidCode;
    }

    // Gelen kodun doğruluğunun kontrolünü yapabilirsiniz
    return null;
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onLoginButtonPressed(context),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFE65100),
      ),
      child: Text(translation(context).labelLogin),
    );
  }

  Widget _buildResendCodeButton(BuildContext context) {
    return TextButton(
      onPressed: _onResendButtonPressed,
      child: Text(
        translation(context).labelSendAgain,
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  void _onResendButtonPressed() {
    // Kodu yeniden göndermek için işlemleri burada yapabilirsiniz
  }

  void _onLoginButtonPressed(BuildContext context) {
    String gelenKod = _codeController.text;
    if (gelenKod.isNotEmpty) {
      // Gelen kodun doğruluğunu kontrol edebilir ve işlemleri yapabilirsiniz.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterScreen()),
      );
    } else {
      _showSnackBar(context, translation(context).labelValidCode);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}