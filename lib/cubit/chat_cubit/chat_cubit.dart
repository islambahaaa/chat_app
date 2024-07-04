import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  void addMessage({required String message, required String email}) {
    try {
      messages.add(
        {
          'message': message,
          kcreatedAt: DateTime.now(),
          'id': email,
        },
      );
    } catch (e) {
      // TODO
    }
  }

  void getMessages() {
    messages.orderBy(kcreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messageList = [];
      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messageList: messageList));
    });
  }
}
