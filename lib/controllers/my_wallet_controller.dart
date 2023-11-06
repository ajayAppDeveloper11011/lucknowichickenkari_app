import 'package:flutter/material.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';

import '../Widgets/app_button.dart';

class MyWalletController extends AppBaseController{
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
   GlobalKey<RefreshIndicatorState>();
  ScrollController controller = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  bool _isLoading = true;

  Future<void> _refresh() {
      _isLoading = true;
       update();

    return allApi();
  }

  allApi(){

  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  showContent(context) {
    return RefreshIndicator(
        color:AppColors.primary,
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an amount';
                      }
                      // You can add more validation logic here.
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                    ),
                  ),
                  const SizedBox(height: 16),
                   AppBtn(
                     width: 140,
                     height: 45,
                     title: 'Add Money',
                     onPress: () {
                       if (_formKey.currentState!.validate()) {
                         // Perform the logic to add money to the user's account here.
                         // You can call an API or update a local variable.
                         // For this example, we'll simply display a confirmation dialog.
                         showDialog(
                           context: context,
                           builder: (BuildContext context) {
                             return AlertDialog(
                               title: const Text('Money Added'),
                               content: Text('Successfully added \$${_amountController.text} to your account.'),
                               actions: [
                                 TextButton(
                                   onPressed: () {
                                     Navigator.of(context).pop();
                                   },
                                   child: const Text('OK'),
                                 ),
                               ],
                             );
                           },
                         );
                       }
                     },
                   )
                ],
              ),
            ),
          ),
        )
        );
  }




}