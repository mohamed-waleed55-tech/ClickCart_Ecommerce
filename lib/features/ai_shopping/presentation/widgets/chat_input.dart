import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {

  final TextEditingController controller;
  final VoidCallback onSend;


  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
  });



  @override
  Widget build(BuildContext context) {


    return Container(

      padding: const EdgeInsets.all(12),

      color: Colors.white,


      child: Row(

        children: [


          Expanded(

            child: TextField(

              controller: controller,

              decoration: InputDecoration(

                hintText:
                "Ask me about products...",


                filled: true,

                fillColor:
                Colors.grey.shade100,


                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(30),

                  borderSide:
                  BorderSide.none,

                ),

              ),

            ),

          ),


          const SizedBox(width: 8),


          CircleAvatar(

            radius: 25,

            backgroundColor:
            Colors.blue,


            child: IconButton(

              icon:
              const Icon(
                Icons.send,
                color: Colors.white,
              ),


              onPressed: onSend,

            ),

          )


        ],

      ),

    );

  }
}