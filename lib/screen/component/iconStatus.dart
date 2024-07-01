
   import 'package:flutter/material.dart';

Widget getStatusIcon(String status) {
    switch (status) {
      case 'PENDING':
        return Icon(Icons.hourglass_empty, color: Colors.orange);
      case 'Successful':
        return Icon(Icons.check_circle, color: Colors.green);
      case 'Rejected':
        return Icon(Icons.cancel, color: Colors.red);
      default:
        return Icon(Icons.help, color: Colors.grey);
    }
  }
