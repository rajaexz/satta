import 'package:flutter/material.dart';
import 'package:Billa/utilis/borderbox.dart';
import 'package:Billa/utilis/fontstyle.dart';

import '../../utilis/AllColor.dart';

MyTab(name) {
  return Tab(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        border: border,
        borderRadius: boRadius5,
      ),
      child: Text(
        name,
        style: CustomStyles.textExternel,
      ),
    ),
  );
}
