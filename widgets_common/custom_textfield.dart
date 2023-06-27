import 'package:hands/consts/consts.dart';

Widget customTextField(
    {String? title, String? hint, controller, isPass, IconData? suffixIcon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(Colors.red).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint!,
          hintStyle: TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon)
              : null, // Adding the suffix icon
        ),
      ),
      10.heightBox
    ],
  );
}
