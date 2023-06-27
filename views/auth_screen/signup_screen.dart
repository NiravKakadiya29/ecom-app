import 'package:hands/consts/consts.dart';
import 'package:hands/controllers/auth_controller.dart';
import 'package:hands/views/home_screen/home.dart';
import 'package:hands/widgets_common/applogo_widget.dart';
import 'package:hands/widgets_common/bg_widget.dart';
import 'package:hands/widgets_common/custom_textfield.dart';
import 'package:hands/widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPass: false),
                  customTextField(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPass: false),
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: passwordController,
                      isPass: true),
                  customTextField(
                      title: retypepassword,
                      hint: passwordHint,
                      controller: passwordRetypingController,
                      isPass: true),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: Colors.red,
                          checkColor: Colors.white,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                    color: fontGrey, fontFamily: regular)),
                            TextSpan(
                                text: termsAndCondition,
                                style: TextStyle(
                                    color: Colors.red, fontFamily: regular)),
                            TextSpan(
                                text: " & ",
                                style: TextStyle(
                                    color: fontGrey, fontFamily: regular)),
                            TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                    color: Colors.red, fontFamily: regular)),
                          ]),
                        ),
                      )
                    ],
                  ),
                  5.heightBox,
                  controller.isloading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.red),
                        )
                      : ourButton(
                          title: signup,
                          textColor: whiteColor,
                          color: isCheck == true ? redColor : lightGrey,
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isloading(true);
                              try {
                                await controller
                                    .signupMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  return controller.storeUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text);
                                }).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isloading(false);
                              }
                            }
                          }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyHaveAccount.text.color(fontGrey).make(),
                      login.text
                          .color(Colors.red)
                          .fontFamily(bold)
                          .make()
                          .onTap(() {
                        Get.back();
                      })
                    ],
                  ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
