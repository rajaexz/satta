import 'package:winner11/screen/auth/create_pinset.dart';
import 'package:winner11/screen/auth/singup.dart';
import 'package:winner11/screen/payment_set/gpay.dart';
import 'package:winner11/screen/payment_set/paytm.dart';
import 'package:winner11/screen/payment_set/paytm_sreen_upi_set.dart';
import 'package:winner11/screen/payment_set/phonepay.dart';

import 'package:winner11/screen/profile/bankEdit.dart';

import 'package:get/get.dart';
import 'package:winner11/screen/aboutTerm&Condition/Tream&con.dart';
import 'package:winner11/screen/aboutTerm&Condition/aboutus.dart';
import 'package:winner11/screen/aboutTerm&Condition/faq.dart';
import 'package:winner11/screen/auth/login.dart';
import 'package:winner11/screen/auth/otpsrceen.dart';
import 'package:winner11/screen/my_home.dart';
import 'package:winner11/screen/notification/enableNotification.dart';
import 'package:winner11/screen/notification/noti.dart';
import 'package:winner11/screen/profile/editProfile.dart';
import 'package:winner11/screen/profile/profile.dart';
import 'package:winner11/screen/setting/Setting.dart';
import 'package:winner11/screen/setting/more.dart';
import 'package:winner11/screen/tap1/gali_game.dart';
import 'package:winner11/screen/tap1/starline_game.dart';
import 'package:winner11/screen/wallet/AllHestory.dart';
import 'package:winner11/screen/wallet/transfer_point.dart';
import 'package:winner11/screen/wallet/winHestory.dart';
import 'package:winner11/screen/wallet/withdraw.dart';
import 'package:winner11/splash/intro.dart';
import 'package:winner11/splash/splash.dart';

import '../screen/aboutTerm&Condition/policy.dart';
import '../screen/auth/pinset.dart';
import '../screen/tap1/hisrotry/starlinebithestory.dart';
import '../screen/wallet/BitHestory.dart';
import '../screen/wallet/addmoney.dart';

var allRutes = [
  GetPage(
      name: '/signup',
      page: () => SignupPage(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
      transitionDuration: const Duration(milliseconds: 500),
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
      name: '/setpin',
      page: () => PinPage(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/Createsetpin',
      page: () => CreatePinPage(),
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
      name: '/myNoti',
      page: () => MyNoti(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  // GetPage(
  //     name: '/wallet',
  //     page: () => MyWallet(),
  //     transitionDuration: Duration(milliseconds: 500),
  //     transition: Transition.leftToRightWithFade),
  GetPage(
      name: '/addMoney',
      page: () => Addmoney(),
      transition: Transition.leftToRightWithFade),
  //   GetPage(
  // name: '/QRcode',
  // page: () => WebViewExample(),
  // transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/setting",
      page: () => const MySetting(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),

  GetPage(
      name: "/StarlineGame",
      page: () => StarlineGamePage(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/Starlinehisory",
      page: () => BidHistoryPage(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/paymentScreen",
      page: () => PaytmentSreen(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/PaytmScreen",
      page: () => UpdatePaytmPage(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/GooglePayScreen",
      page: () => UpdateGpayPage(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/PhonePayScreen",
      page: () => PhonepayPage(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),

  GetPage(
      name: "/GaliGame",
      page: () => GaliGamePage(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),

  GetPage(
      name: "/BankScreen",
      page: () => BankEdit(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),

  GetPage(
      name: "/showProfile",
      page: () => ShowProfile(),
      transitionDuration: Duration(milliseconds: 200),
      transition: Transition.fadeIn),

  GetPage(
      name: "/bitHistory",
      page: () => const BitHestory(),
      transitionDuration: Duration(milliseconds: 200),
      transition: Transition.fadeIn),
  GetPage(
      name: "/winHistory",
      page: () => const WinHestory(),
      transitionDuration: Duration(milliseconds: 200),
      transition: Transition.fadeIn),

  GetPage(
      name: "/transfer",
      page: () => TransferPage(),
      transitionDuration: Duration(milliseconds: 200),
      transition: Transition.fadeIn),

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
      page: () => const Steps(),
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
      name: "/withdraw",
      page: () => WithdrawPage(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: "/historyWallet",
      page: () => AllHestory(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.leftToRightWithFade),
];
