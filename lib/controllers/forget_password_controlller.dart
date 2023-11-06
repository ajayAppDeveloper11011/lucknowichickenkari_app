import 'package:flutter/cupertino.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';

class ForgetPassController extends AppBaseController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  String email = '';


}