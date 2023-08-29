import 'package:bloc/bloc.dart';
import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference message =
      FirebaseFirestore.instance.collection(kMessagesController);
  List<Message> messagesData = [];
  void sendMessage({required String messages, required var email}) {
    message.add({
      kMessages: messages,
      kCreatedAt: DateTime.now(),
      'id': email,
    });
  }

  void resiveMessage() {
    message.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesData.clear();
      for (var doc in event.docs) {
        messagesData.add(Message.fromjson(doc));
      }
      emit(ChatSuccess(messagesData: messagesData));
    });
  }
}
