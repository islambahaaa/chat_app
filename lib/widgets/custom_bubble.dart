import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class CustomBubble extends StatelessWidget {
  const CustomBubble({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    final String date = message.date.toDate().toString();
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                      topLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32))),
              child: Text(
                message.message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              date.substring(11, 16),
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////
class CustomBubbleForFriend extends StatelessWidget {
  const CustomBubbleForFriend({
    super.key,
    required this.message,
  });
  final Message message;

  @override
  Widget build(BuildContext context) {
    final String date = message.date.toDate().toString();
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.id,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: const BoxDecoration(
                  color: Color(0xffcc3d00),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                      topLeft: Radius.circular(32),
                      bottomLeft: Radius.circular(32))),
              child: Text(
                message.message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              date.substring(11, 16),
              style: TextStyle(fontSize: 10),
            ),
            // Text(
            //   date.substring(8, 10) +
            //       "/" +
            //       date.substring(5, 7) +
            //       "/" +
            //       date.substring(0, 4),
            //   style: TextStyle(fontSize: 10),
            // ),
          ],
        ),
      ),
    );
  }
}
