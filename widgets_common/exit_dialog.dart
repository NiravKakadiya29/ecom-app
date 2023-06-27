import 'package:flutter/services.dart';
import 'package:hands/consts/consts.dart';
import 'package:hands/widgets_common/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are You Sure You Want To Exit"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: redColor,
                title: "Yes",
                onPress: () {
                  SystemNavigator.pop();
                },
                textColor: whiteColor),
            ourButton(
                color: redColor,
                title: "No",
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: whiteColor),
          ],
        )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}
