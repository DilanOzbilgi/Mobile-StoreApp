import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 30.0),
      child: Hero(
        tag: 'App_logo',
        child: Center(
          child: Image.asset(
            'images/main_logo.png',
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
