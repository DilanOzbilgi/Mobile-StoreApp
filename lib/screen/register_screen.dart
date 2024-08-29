import 'package:badinan_mobile_app/language/language.dart';
import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: _buildForm(context),
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 100),
          _buildLogo(),
          SizedBox(height: 20),
          _buildCompanyNameInputField(context),
          SizedBox(height: 20),
          _buildContactNameInputField(context),
          SizedBox(height: 20),
          _buildPhoneNumberInputField(context),
          SizedBox(height: 20),
          _buildAddressInputField(context),
          SizedBox(height: 20),
          _buildRegisterButton(context),
          SizedBox(height: 10),
          _buildErrorText(context),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'images/main_logo.png',
      height: 100,
      width: 150,
    );
  }

  Widget _buildCompanyNameInputField(BuildContext context) {
    return _buildTextFormField(
      controller: _companyNameController,
      hintText: translation(context).labelEnterCompanyName,
      validator: (value) => _validateName(context, value),
    );
  }

  Widget _buildContactNameInputField(BuildContext context) {
    return _buildTextFormField(
      controller: _contactNameController,
      hintText: translation(context).labelEnterContactName,
      validator: (value) => _validateName(context, value),
    );
  }

  Widget _buildPhoneNumberInputField(BuildContext context) {
    return _buildTextFormField(
      controller: _phoneNumberController,
      hintText: translation(context).labelEnterPhoneNumber,
      keyboardType: TextInputType.phone,
      maxLength: 11,
      showMaxLength: false,
      validator: (value) => _validatePhoneNumber(context, value!),
    );
  }

  Widget _buildAddressInputField(BuildContext context) {
    return TextFormField(
      controller: _addressController,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      style: TextStyle(color: Colors.white),
      decoration: _inputDecoration(translation(context).labelEnterAddress),
      validator: (value) =>
      value!.isEmpty ? translation(context).labelAddressRequired : null,
    );
  }

  String? _validatePhoneNumber(BuildContext context, String value) {
    if (value.isEmpty) {
      return translation(context).labelEnterValidPhoneNumber;
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return translation(context).labelInvalidCharacter;
    }
    if (value.length != 11) {
      return translation(context).labelPhoneNumber11Digits;
    }
    return null;
  }

  String? _validateName(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return translation(context).labelRequired;
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return translation(context).labelInvalidCharacters;
    }
    return null;
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    int? maxLength,
    int maxLines = 1,
    bool showMaxLength = true,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: showMaxLength ? maxLength : null,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white),
      inputFormatters: [
        LengthLimitingTextInputFormatter(11),
      ],
      decoration: _inputDecoration(hintText),
      validator: validator,
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
      fillColor: Colors.black,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: ElevatedButton(
        onPressed: () => _onRegisterButtonPressed(context),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFE65100),
        ),
        child: Text(translation(context).labelRegister),
      ),
    );
  }

  Widget _buildErrorText(BuildContext context) {
    return Text(
      translation(context).labelRegistrationFailed,
      style: TextStyle(color: Colors.grey),
    );
  }

  void _onRegisterButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Kayıt işlemleri burada yapılır
      String companyName = _companyNameController.text;
      String contactName = _contactNameController.text;
      String phoneNumber = _phoneNumberController.text;
      String address = _addressController.text;

      // Bilgileri api'ye gönderme işlemi yapabilirsiniz
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
}
