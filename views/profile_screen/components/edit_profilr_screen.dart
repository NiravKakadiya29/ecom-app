import 'dart:io';

import 'package:hands/consts/consts.dart';
import 'package:hands/controllers/profile_controller.dart';
import 'package:hands/widgets_common/bg_widget.dart';
import 'package:hands/widgets_common/custom_textfield.dart';
import 'package:hands/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
// if data image url and controller path is empty
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
//if data is empty but controller path is empty
                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()

// else if controller path is not empty but image url
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,

            //change button
            ourButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change"),
            Divider(),
            20.heightBox,

            //name filed
            customTextField(
                hint: nameHint,
                title: name,
                isPass: false,
                controller: controller.nameController),
            10.heightBox,

            //old pass field
            customTextField(
              hint: passwordHint,
              title: oldpass,
              isPass: true,
              controller: controller.oldpassController,
              suffixIcon: Icons.edit,
            ),

            10.heightBox,

            //new pass field
            customTextField(
                hint: passwordHint,
                title: newpass,
                isPass: true,
                controller: controller.newpassController),

            //save button
            20.heightBox,
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.isloading(true);

                          //if image is not selected
                          if (controller.profileImgPath.value.isNotEmpty)
                            await controller.uploadProfileImage();
                          else {
                            controller.profileImageLink = data['imageUrl'];
                          }

//if old password matches data base
                          if (controller.oldpassController.text ==
                              data['password']) {
                            controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpassController.text,
                                newpassword: controller.newpassController.text);

                            //..
                            await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newpassController.text,
                            );
                            VxToast.show(context, msg: "Updated");
                          } else {
                            VxToast.show(context, msg: "Wrong old Password");
                            controller.isloading(false);
                          }
                        },
                        textColor: whiteColor,
                        title: "Save"),
                  ),
          ],
        )
            .box
            .shadowSm
            .white
            .padding(EdgeInsets.all(16))
            .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
