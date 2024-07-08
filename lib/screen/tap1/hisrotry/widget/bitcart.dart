import 'package:flutter/material.dart';

import '../controller/SartlineBidHistoryController.dart';

class BidHistoryCard extends StatelessWidget {
  final BidHistory bid;

  const BidHistoryCard({Key? key, required this.bid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
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
            '${bid.gameName} - ${bid.gameType}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text('Left Digit: ${bid.leftDigit}'),
          Text('Right Digit: ${bid.rightDigit.isEmpty ? "N/A" : bid.rightDigit}'),
          Text('Bid Points: ${bid.bidPoints}'),
          const SizedBox(height: 8.0),
          Text(
            'Bidded At: ${bid.biddedAt}',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
