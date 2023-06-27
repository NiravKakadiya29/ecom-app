import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hands/consts/consts.dart';
import 'package:hands/controllers/auth_controller.dart';
import 'package:hands/controllers/profile_controller.dart';
import 'package:hands/services/firestore_services.dart';
import 'package:hands/views/auth_screen/login_screen.dart';
import 'package:hands/views/profile_screen/components/details_card.dart';
import 'package:hands/views/profile_screen/components/edit_profilr_screen.dart';
import 'package:hands/widgets_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                  child: Column(
                children: [
                  //edit profile button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        )).onTap(() {
                      controller.nameController.text = data['name'];
                      Get.to(() => EditProfileScreen(data: data));
                    }),
                  ),

                  //user Details Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Row(
                      children: [
                        data['imageUrl'] == ''
                            ? Image.asset(imgProfile2,
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(data['imageUrl'],
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                        10.heightBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            "${data['email']}".text.white.make()
                          ],
                        ).marginOnly(left: 5)),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.white)),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context);
                            Get.offAll(() => LoginScreen());
                          },
                          child: "Logout".text.fontFamily(semibold).make(),
                        )
                      ],
                    ),
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      detailsCard(
                          count: data['cart_count'],
                          title: "in your cart",
                          width: context.screenWidth / 3.45),
                      detailsCard(
                          count: data['wishlist_count'],
                          title: "in your Wishlist",
                          width: context.screenWidth / 3.45),
                      detailsCard(
                          count: data['order_count'],
                          title: "in your orders",
                          width: context.screenWidth / 3.45),
                    ],
                  ),
                  //button Section

                  ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: profileButtonList.count(),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.asset(
                                profileButtonIcon[index],
                                width: 22,
                              ),
                              title: profileButtonList[index]
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          })
                      .box
                      .white
                      .rounded
                      .margin(EdgeInsets.all(12))
                      .padding(EdgeInsets.symmetric(horizontal: 16))
                      .make()
                      .box
                      .color(Colors.red)
                      .make()
                ],
              ));
            }
          }),
    ));
  }
}
