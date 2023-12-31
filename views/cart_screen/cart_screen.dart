import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hands/consts/consts.dart';
import 'package:hands/controllers/cart_controller.dart';
import 'package:hands/services/firestore_services.dart';
import 'package:hands/views/cart_screen/shipping_screen.dart';
import 'package:hands/widgets_common/loading_indicator.dart';
import 'package:hands/widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
              color: redColor,
              title: "Proceed To Shipping",
              textColor: whiteColor,
              onPress: () {
                Get.to(() => ShippingDetails());
              })),
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart Is Empt!".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnashot = data;
              return Padding(
                padding: EdgeInsets.all(8),
                child: Column(children: [
                  Expanded(
                      child: Container(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.network("${data[index]['img']}"),
                            title:
                                "${data[index]['title']} (X${data[index]['qty']})"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                            subtitle: "${data[index]['tprice']}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ).onTap(() {
                              FirestoreServices.deleteDocument(data[index].id);
                            }));
                      },
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Totla Price"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(
                        () => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(Colors.red)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(EdgeInsets.all(12))
                      .color(lightGolden)
                      .width(context.screenWidth - 60)
                      .roundedSM
                      .make(),
                  // SizedBox(
                  //     width: context.screenWidth - 60,
                  //     child: ourButton(
                  //         color: redColor,
                  //         title: "Proceed To Shipping",
                  //         textColor: whiteColor,
                  //         onPress: () {})),
                ]),
              );
            }
          }),
    );
  }
}
