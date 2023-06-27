import 'package:hands/consts/consts.dart';
import 'package:hands/controllers/cart_controller.dart';
import 'package:hands/views/cart_screen/payment_method.dart';
import 'package:hands/widgets_common/custom_textfield.dart';
import 'package:hands/widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          onPress: () {
            if (controller.addressController.text.length > 10 ||
                controller.phoneController.text.length > 9 ||
                controller.stateController.text.length > 3 ||
                controller.postalcodeController.text.length > 6 ||
                controller.cityController.text.length > 4) {
              Get.to(() => PaymentMethods());
            } else {
              VxToast.show(context, msg: "Please Fill The Form");
            }
          },
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            customTextField(
                hint: "Adress",
                isPass: false,
                title: "Adress",
                controller: controller.addressController),
            customTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            customTextField(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalcodeController),
            customTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
