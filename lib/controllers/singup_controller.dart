import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:lucknowichickenkari_app/models/sign_up_model_response.dart';
import '../Services/api_client.dart';
import '../Services/request_keys.dart';
import '../Utils/colors.dart';
import '../Widgets/app_button.dart';
import '../Widgets/cropped_container.dart';
import '../Widgets/my_Clippath.dart';
import '../Widgets/show_message.dart';
import '../session/Session.dart';

class SignUpController extends AppBaseController{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  bool _isVisible = true;

  onTapLogin(){
    Get.toNamed(loginScreen);
  }

  onTapVisiblityUpdate(){
    _isVisible=!_isVisible;
    update();
  }

 /// Sign up Api Integration --------------->

  Future<void> registerUser() async {
    setBusy(true);
    try {

      Map<String, String> body = {};
      body[RequestKeys.name] = nameController.text.trim();
      body[RequestKeys.email] = emailController.text.trim();
      body[RequestKeys.password] = passController.text.trim();
      body[RequestKeys.mobile] = mobileController.text.trim();
      body[RequestKeys.uniqueClientId] = ApiClient.uniqueKey;

      RegisterUserResponse res = await api.registerUserApi(body);
      print('${res.message}_____gggg_');

      if (res.error==true) {

        ShowMessage.showSnackBar('Server Res', res.message);
        setBusy(false);
        Get.toNamed(loginScreen);
        update();

      }else{

        ShowMessage.showSnackBar('Server Res', res.message);
        setBusy(false);
        update();

      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }




  getSignUpContainer(context) {
    return Positioned.directional(
      start: MediaQuery.of(context).size.width * 0.025,
      // end: width * 0.025,
      // top: width * 0.45,
      top: MediaQuery.of(context).size.height * 0.2, //original
      //    bottom: height * 0.1,
      textDirection: Directionality.of(context),
      child: ClipPath(
        clipper: ContainerClipper(),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * 0.8),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.95,
          color: AppColors.whit,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 2,
                ),
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20,top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0,right: 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text('Sign Up',style: TextStyle(color:AppColors.red,fontWeight: FontWeight.bold,fontSize:30),)),
                          ),
                          const SizedBox(height:30,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:AppColors.textFieldClr,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                controller:nameController,
                                validator: (value) => value!.isEmpty ? 'Name Can not empty':null,
                                decoration: const InputDecoration(
                                    border:InputBorder.none,
                                    counterText: '',
                                    hintText: 'Full Name',
                                    prefixIcon: Icon(Icons.person,color:AppColors.primary,)
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height:20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:AppColors.textFieldClr,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) => validateEmail(
                                    val!,
                                    'Email Id Is Required',
                                    'Please Enter Valid Email'),
                                decoration: const InputDecoration(
                                    border:InputBorder.none,
                                    hintText: 'Enter Email Id',
                                    prefixIcon: Icon(Icons.email_outlined,color:AppColors.primary,)
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height:20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:AppColors.textFieldClr,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                controller: passController,
                                obscureText: _isVisible ? false : true,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => value!.isEmpty ? "Password can't empty":null,
                                decoration:InputDecoration(
                                    border:InputBorder.none,
                                    hintText: 'Password',
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          onTapVisiblityUpdate();
                                        },
                                        child: Icon(_isVisible ? Icons.visibility : Icons.visibility_off)),
                                    prefixIcon: const Icon(Icons.lock,color:AppColors.primary,)
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height:20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:AppColors.textFieldClr,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                controller: mobileController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                validator: (value) => value!.isEmpty ? "Mobile can't be blank":null,
                                decoration: const InputDecoration(
                                    border:InputBorder.none,
                                    hintText: 'Mobile No.',
                                    counterText: '',
                                    prefixIcon: Icon(Icons.phone,color:AppColors.primary,)
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height:20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,right:20),
                            child: AppBtn(
                              title: 'Sign Up',
                              height:45,
                              width: MediaQuery.of(context).size.width/1.2,
                              onPress: () {
                                if (nameController.text.isEmpty) {
                                  ShowMessage.showSnackBar('Name Error', 'Name is Empty');
                                } else if (passController.text.isEmpty) {
                                  ShowMessage.showSnackBar('Password Error', 'Password is Empty');
                                } else if (mobileController.text.isEmpty) {
                                  ShowMessage.showSnackBar('Mobile Error', 'Mobile is Empty');
                                } else if (emailController.text.isEmpty) {
                                  ShowMessage.showSnackBar('Email Error', 'Email is Empty');
                                } else {
                                  registerUser();
                                }

                              },

                            ),
                          ),
                          const SizedBox(height:40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an Account?",style: TextStyle(color:AppColors.primary,fontWeight: FontWeight.bold,fontSize:15),),
                              InkWell(
                                  onTap: () {
                                    onTapLogin();
                                  },
                                  child: const Text("Login",style: TextStyle(color:AppColors.red,fontWeight: FontWeight.bold,fontSize:17),)),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

   getLogo(context) {
    return Positioned(
      // textDirection: Directionality.of(context),
      left: (MediaQuery.of(context).size.width / 2) -55,
      // right: ((MediaQuery.of(context).size.width /2)-55),
      top: (MediaQuery.of(context).size.height * 0.2) -55,
      //  bottom: height * 0.1,
      child: ClipPath(
        clipper: MyPolygon(),
        child: Container(
          color: AppColors.primary,
          width: 110,
          height: 110,
          child: Image.asset('assets/images/splashImage.jpg',fit: BoxFit.fill,),
        ),
      ),
    );
  }


  String? validateEmail(String value, String? msg1, String? msg2) {
    if (value.length == 0) {
      return msg1;
    } else if (!RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
        r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+"
        r"[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return msg2;
    } else {
      return null;
    }


    // validator: (val) => validateEmail(
    //     val!,
    //     'Email Id Is Required',
    //     'Please Enter Valid Email'),


  }




}