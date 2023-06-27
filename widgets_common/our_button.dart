import 'package:hands/consts/consts.dart';

Widget ourButton({color, String? title, onPress, textColor}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.all(12),
      ),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
