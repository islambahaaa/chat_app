import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.hintText,
    this.action = TextInputAction.go,
    this.onchanged,
    this.pass = false,
  });
  String? hintText;
  var action;
  bool pass;
  Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.25),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
              color: Colors.grey[100],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: TextFormField(
            obscureText: pass,
            validator: (data) {
              if (data!.isEmpty) {
                return 'This field is Required';
              }
            },
            onChanged: onchanged,
            textInputAction: action,
            decoration: InputDecoration(
              hintText: hintText,
              // hintStyle: const TextStyle(color: kPrimaryColor),
              border: InputBorder.none,
            ),
          ),
        ),
      ]),
    );
  }
}
