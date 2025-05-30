import 'package:flutter/material.dart';
import 'package:memenote/pages/dashboard/dashboard_page.dart';
import 'package:memenote/pages/home_page.dart';
import 'package:memenote/pages/dashboard/about_page.dart';
import 'package:memenote/pages/auth/login_page.dart';
import 'package:memenote/pages/auth/signup_page.dart';
import 'package:memenote/pages/meme/create_meme_page.dart';
import 'package:memenote/pages/meme/meme_details_page.dart';
import 'package:memenote/pages/meme/meme_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomePage(),
  '/about': (context) => AboutPage(),
  '/login': (context) => LoginPage(),
  '/signup': (context) => SignupPage(),
  '/dashboard':(context)=>DashboardPage(),
  '/memes':(context)=>MemePage(),
  '/create-meme':(context)=>CreateMemePage(),
  '/meme-details':(context)=>MemeDetailsPage(),
  // Add more routes as needed
};
