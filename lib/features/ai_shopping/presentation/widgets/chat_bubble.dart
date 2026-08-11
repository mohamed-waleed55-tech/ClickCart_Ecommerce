import 'package:ecommerce_app/features/ai_shopping/model/chat_message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {

  final ChatMessage message;


  const ChatBubble({
    super.key,
    required this.message,
  });


  @override
  Widget build(BuildContext context) {


    final isUser =
        message.type == MessageType.user;


    return Align(

      alignment: isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,


      child: Container(

        margin: const EdgeInsets.only(
          bottom: 12,
        ),


        padding: const EdgeInsets.all(14),


        constraints:
        const BoxConstraints(
          maxWidth: 280,
        ),


        decoration: BoxDecoration(

          color: isUser
              ? Colors.blue
              : Colors.white,


          borderRadius:
          BorderRadius.circular(18),

          boxShadow: [

            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            )

          ],

        ),



        child: Text(

          message.text,

          style: TextStyle(

            color: isUser
                ? Colors.white
                : Colors.black87,

            fontSize: 15,

          ),

        ),

      ),

    );

  }
}