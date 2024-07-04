import 'package:chat_app/constants.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/custom_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  List<Message> messagesList = [];
  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.black),
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
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messageList;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: _controller,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? CustomBubble(
                            message: messagesList[index],
                          )
                        : CustomBubbleForFriend(message: messagesList[index]);
                  },
                );
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
                    String data = controller.text;
                    if (data.isEmpty || data.trim().isEmpty) {
                      return;
                    }
                    BlocProvider.of<ChatCubit>(context)
                        .addMessage(message: data.trim(), email: email);
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
  }
}
