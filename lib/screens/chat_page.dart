import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/custom_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  TextEditingController controller = TextEditingController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kcreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              automaticallyImplyLeading: false,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.black),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/images/animation1.json',
                    height: 50,
                  ),
                  const Text('Chat')
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? CustomBubble(
                              message: messageList[index],
                            )
                          : CustomBubbleForFriend(message: messageList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: controller,
                    // onSubmitted: (data) {
                    //   messages.add(
                    //     {
                    //       'message': data,
                    //       kcreatedAt: DateTime.now(),
                    //       'id': email,
                    //     },
                    //   );
                    //   controller.clear();
                    //   _controller.animateTo(0,
                    //       curve: Curves.easeIn,
                    //       duration: Duration(milliseconds: 400));
                    // },
                    decoration: InputDecoration(
                      hintText: 'Send a message',
                      suffixIcon: IconButton(
                        onPressed: () {
                          messages.add(
                            {
                              'message': controller.text,
                              kcreatedAt: DateTime.now(),
                              'id': email,
                            },
                          );
                          controller.clear();
                          _controller.animateTo(0,
                              curve: Curves.easeIn,
                              duration: const Duration(milliseconds: 400));
                        },
                        icon: const Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text(
                'Loading...',
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
            ),
          );
        }
      },
    );
  }
}


//widget(child: widget)
//widget(appbar)
