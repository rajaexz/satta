// views/win_history_card.dart
import 'package:flutter/material.dart';

import '../controller/WinSartlineBidHistoryController.dart';

class WinHistoryCard extends StatelessWidget {
  final WinHistory win;

  const WinHistoryCard({Key? key, required this.win}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${win.gameName} - ${win.gameType}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text('Digit: ${win.digit}'),
          Text('Panna: ${win.panna.isEmpty ? "N/A" : win.panna}'),
          Text('Bid Points: ${win.bidPoints}'),
          const SizedBox(height: 8.0),
          Text(
            'Bidded At: ${win.biddedAt}',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class WinHistoryCardR extends StatelessWidget {
  final WinHistory win;

  const WinHistoryCardR({Key? key, required this.win}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${win.gameName} - ${win.gameType}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text('Digit: ${win.digit}'),
          Text('Panna: ${win.panna.isEmpty ? "N/A" : win.panna}'),
          Text('Bid Points: ${win.bidPoints}'),
          const SizedBox(height: 8.0),
          Text(
            'Bidded At: ${win.biddedAt}',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
