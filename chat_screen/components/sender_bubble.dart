import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hands/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t = data['created_on'] == null
      ? DateTime.now()
      : (data['created_on'] as Timestamp).toDate();
// .toString();
  var time = intl.DateFormat("h:mma").format(t);

  return
      // this is for text direction but i dont want its already working without it so...
      // Directionality(
      // textDirection:
      //     data['uid'] == currentUser!.uid ? TextDirection.ltr : TextDirection.ltr,
      // child:
      Container(
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid ? Colors.red : darkFontGrey,
        borderRadius: data['uid'] == currentUser!.uid
            ? BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        "${data['msg']}".text.white.size(16).make(),
        10.heightBox,
        time.text.color(Colors.white.withOpacity(0.5)).make(),
      ],
    ),
    // ),
  );
}
