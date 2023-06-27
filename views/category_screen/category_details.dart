import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hands/consts/consts.dart';
import 'package:hands/controllers/product_controller.dart';
import 'package:hands/services/firestore_services.dart';
import 'package:hands/views/category_screen/item_details.dart';
import 'package:hands/widgets_common/bg_widget.dart';
import 'package:hands/widgets_common/loading_indicator.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;

  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: title!.text.fontFamily(bold).white.make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No Product Found".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;

            return Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children: List.generate(
                          controller.subcat.length,
                          (index) => "${controller.subcat[index]}"
                              .text
                              .size(12)
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .makeCentered()
                              .box
                              .white
                              .size(120, 60)
                              .rounded
                              .margin(EdgeInsets.symmetric(horizontal: 4))
                              .make()),
                    ),
                  ),

                  20.heightBox,

                  //items Container
                  Expanded(
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        itemBuilder: (contex, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                //product image As database
                                data[index]['p_images'][0],
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              5.heightBox,

                              //product name as database name
                              "${data[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,

                              //producrt price as database price name
                              "${data[index]['p_price']}"
                                  .numCurrency
                                  .text
                                  .color(Colors.red)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make()
                            ],
                          )
                              .box
                              .margin(EdgeInsets.symmetric(
                                horizontal: 4,
                              ))
                              .white
                              .roundedSM
                              .outerShadowSm
                              .padding(EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                            controller.checkIffav(data[index]);
                            Get.to(() => ItemDetails(
                                  title: "${data[index]['p_name']}",
                                  data: data[index],
                                ));
                          });
                        }),
                  ),
                ],
              ),
            );
          }
        },
      ),
    ));
  }
}
