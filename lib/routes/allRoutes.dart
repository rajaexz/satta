import 'package:winner11/screen/live/live.dart';
import 'package:winner11/screen/profile/bankEdit.dart';
import 'package:winner11/screen/tap3/myFullBlog.dart';

import 'package:get/get.dart';
import 'package:winner11/screen/KYC/kyc.dart';
import 'package:winner11/screen/aboutTerm&Condition/Tream&con.dart';
import 'package:winner11/screen/aboutTerm&Condition/aboutus.dart';
import 'package:winner11/screen/aboutTerm&Condition/faq.dart';
import 'package:winner11/screen/auth/login.dart';
import 'package:winner11/screen/auth/otpsrceen.dart';
import 'package:winner11/screen/home.dart';
import 'package:winner11/screen/notification/enableNotification.dart';
import 'package:winner11/screen/notification/noti.dart';
import 'package:winner11/screen/profile/editProfile.dart';
import 'package:winner11/screen/profile/profile.dart';
import 'package:winner11/screen/setting/Setting.dart';
import 'package:winner11/screen/setting/more.dart';
import 'package:winner11/screen/tap2/AllShowContest.dart';
import 'package:winner11/screen/tap2/ContList.dart';
import 'package:winner11/screen/tap2/CreatCont.dart';
import 'package:winner11/screen/tap2/MyContDetail.dart';
import 'package:winner11/screen/tap2/mycontestStatus.dart';
import 'package:winner11/screen/wallet/AllHestory.dart';
import 'package:winner11/screen/wallet/wallet.dart';
import 'package:winner11/screen/wallet/withdraw.dart';
import 'package:winner11/splash/intro.dart';
import 'package:winner11/splash/splash.dart';

import '../screen/aboutTerm&Condition/policy.dart';
import '../screen/wallet/addmoney.dart';

var allRutes = [
  GetPage(
      name: '/splash',
      page: () => SplashScreen(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/intro',
      page: () => OnboardingScreen(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/home',
      page: () => MyHomePage(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/login',
      page: () => Loginpage(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/otp',
      page: () => OtpPage(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/contList',
      page: () => ContList(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/myCont',
      page: () => MyCont(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/myNoti',
      page: () => NotificationItem(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/wallet',
      page: () => MyWallet(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/addMoney',
      page: () => Addmoney(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/setting",
      page: () => MySetting(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/kyc",
      page: () => KYC(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/bank",
      page: () => BankEdit(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/createCont",
      page: () => CreateCont(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),

  GetPage(
      name: "/showProfile",
      page: () => ShowProfile(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),

  GetPage(
      name: "/editProfile",
      page: () => EditProfile(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/myAboutus",
      page: () => Myaboutus(),
      transition: Transition.leftToRightWithFade),
  //terms and condition
  GetPage(
      name: "/faq",
      page: () => Steps(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/tarmAnd",
      page: () => TarmAnd(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/privacy",
      page: () => Privacy(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/mySeeMore",
      page: () => SeeMore(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/notification",
      page: () => MyNotificationEnable(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/myContestStatus",
      page: () => MyCricketContestStatus(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/withdraw",
      page: () => WithdrawPage(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/historyWallet",
      page: () => AllHestory(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),

  GetPage(
      name: "/AllShowContest",
      page: () => AllShowContest(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/blog",
      page: () => MyFullBlog(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/live",
      page: () => LiveScores(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade)
];
