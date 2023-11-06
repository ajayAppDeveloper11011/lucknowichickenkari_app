import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../Utils/colors.dart';
import '../../controllers/payment_method_controller.dart';
import '../Cart/cart_view.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? nameOfPayment;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PaymentMethodController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Payment Method'),
            backgroundColor: AppColors.primary,
          ),
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Select Payment',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.paymentMethods.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: InkWell(
                        onTap: () {
                          controller.toggleSelection(index);
                          nameOfPayment = controller.paymentMethods[index].name;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: controller.paymentMethods[index].isSelected
                                ? AppColors.primary.withOpacity(0.1)
                                : AppColors.white,
                            border: Border.all(
                              color: controller.paymentMethods[index].isSelected
                                  ? AppColors.primary
                                  : AppColors.red,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    SizedBox(
                                      width:50,
                                      height:50,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image.asset(controller.paymentMethods[index].image,fit: BoxFit.fill,)),
                                    ),
                                    const SizedBox(width:15,),
                                    Text(
                                      controller.paymentMethods[index].name,
                                      style: const TextStyle(
                                        color: AppColors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30.0,
                                  width: 30.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller
                                        .paymentMethods[index].isSelected
                                        ? AppColors.primary
                                        : AppColors.white,
                                    border: Border.all(color: AppColors.primary),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 18.0,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CartScreen(
                    nameOfPayment: nameOfPayment,
                  )));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.white, backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
