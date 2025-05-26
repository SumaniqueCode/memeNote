import 'package:flutter/material.dart';
import 'package:memenote/pages/dashboard_page.dart';
import 'package:memenote/pages/home_page.dart';
import 'package:memenote/pages/about_page.dart';
import 'package:memenote/pages/login_page.dart';
import 'package:memenote/pages/signup_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomePage(),
  '/about': (context) => AboutPage(),
  '/login': (context) => LoginPage(),
  '/signup': (context) => SignupPage(),
  '/dashboard':(context)=>DashboardPage(),
  // Add more routes as needed
};
