import 'dart:html';
import 'package:covid_19_tracker_app/homepage.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:covid_19_tracker_app/AppThemes.dart';

import 'dataSource.dart';

void main() {
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
       return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: primaryBlack,
            fontFamily: 'Circular'
          ),
          home: HomePage(),
        );
      }

  }


