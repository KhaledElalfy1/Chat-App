import 'package:chat_app/components/chat_buble.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = 'ChatScreen';
  final _controller = ScrollController();
  // List<Message> messagesData = [];
  TextEditingController control = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kImage,
              height: 70,
            ),
            const Text('Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesData =
                    BlocProvider.of<ChatCubit>(context).messagesData;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesData.length,
                  itemBuilder: (context, index) {
                    return messagesData[index].id == email
                        ? ChatBuble(
                            message: messagesData[index],
                          )
                        : ChatBubleForAfriend(message: messagesData[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: control,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(messages: data, email: email!);
                control.clear();
                _controller.animateTo(0,
                    duration: const Duration(seconds: 1), curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                  hintText: 'Message',
                  suffixIcon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                  contentPadding: const EdgeInsets.all(22),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
