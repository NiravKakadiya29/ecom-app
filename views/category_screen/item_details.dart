import 'package:hands/chat_screen/chat_screen.dart';
import 'package:hands/consts/consts.dart';
import 'package:hands/controllers/product_controller.dart';
import 'package:hands/widgets_common/our_button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemDetails({Key? key, required this.title, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id, context);
                  } else {
                    controller.addToWishlist(data.id, context);
                  }
                },
                icon: controller.isFav.value
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(Icons.favorite_border),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    //Swiper Sectiom
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        itemCount: data['p_images'].length,
                        aspectRatio: 16 / 9,

                        //for show one fit image in slider
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_images'][index],
                            width: double.infinity,
                            fit: BoxFit.contain,
                          );
                        }),

                    10.heightBox,

                    //title And Detail Section
                    title!.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,

                    //rating
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      size: 25,
                      count: 5,
                      maxRating: 5,
                    ),

                    10.heightBox,
                    "${data['p_price']}"
                        .text
                        .color(Colors.red)
                        .fontFamily(bold)
                        .size(18)
                        .make(),

                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['p_seller']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make()
                          ],
                        )),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message,
                            color: darkFontGrey,
                          ),
                        ).onTap(() {
                          Get.to(
                            () => ChatScreen(),
                            arguments: [data['p_seller'], data['vendor_id']],
                          );
                        })
                      ],
                    )
                        .box
                        .height(60)
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),

                    //color Selection
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .shadowSm
                                                .color(Color(
                                                        data['p_colors'][index])
                                                    .withOpacity(1.0))
                                                .margin(EdgeInsets.symmetric(
                                                    horizontal: 4))
                                                .make()
                                                .onTap(() {
                                              controller.colorIndex(index);
                                            }),
                                            Visibility(
                                                visible: index ==
                                                    controller.colorIndex.value,
                                                child: Icon(
                                                  Icons.done,
                                                  color: data['p_colors']
                                                              [index] ==
                                                          4294967295
                                                      ? Colors.black
                                                      : Colors.white,
                                                ))
                                          ],
                                        )),
                              )
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                          //Quntity Selection

                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Quantity".text.color(textfieldGrey).make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calcuateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: Icon(Icons.remove)),
                                    controller.quantity.value.text
                                        .size(16)
                                        .color(textfieldGrey)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              int.parse(data['p_quantity']));
                                          controller.calcuateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: Icon(Icons.add)),
                                    "(${data['p_quantity']} available)"
                                        .text
                                        .color(textfieldGrey)
                                        .make()
                                  ],
                                ),
                              )
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                          //totle Price
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Totla Price"
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              controller.totalPrice.value.numCurrency.text
                                  .color(Colors.red)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    //Description Section
                    10.heightBox,
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    "${data['p_description']}".text.color(darkFontGrey).make(),

                    10.heightBox,

                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          itemDetailButtonsList.length,
                          (index) => ListTile(
                                title: itemDetailButtonsList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: Icon(Icons.arrow_forward),
                              )),
                    ),
                    10.heightBox,
                    productyoulike.text
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .size(16)
                        .make(),

                    10.heightBox,

                    // I copied this Wigget From home screen featured products

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "Laptop 4GB/64GB"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "\$600"
                                        .text
                                        .color(Colors.red)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make()
                                  ],
                                )
                                    .box
                                    .margin(EdgeInsets.symmetric(horizontal: 4))
                                    .white
                                    .roundedSM
                                    .padding(EdgeInsets.all(8))
                                    .make()),
                      ),
                    ),
                  ])),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                  color: redColor,
                  onPress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                          context: context,
                          title: data['p_name'],
                          color: data['p_colors'][controller.colorIndex.value],
                          img: data['p_images'][0],
                          qty: controller.quantity.value,
                          sellername: data['p_seller'],
                          tprice: controller.totalPrice.value);
                      VxToast.show(context, msg: "Added To Cart");
                    } else {
                      VxToast.show(context, msg: "Please Select Quntity");
                    }
                  },
                  title: "Add To Cart",
                  textColor: whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
