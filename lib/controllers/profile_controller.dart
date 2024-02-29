
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucknowichickenkari_app/Services/api_client.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:lucknowichickenkari_app/models/user_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Route_managements/routes.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import '../models/user_update_response.dart';


class ProfileController extends AppBaseController{
  bool skipLogin= true;
  String? fileName;
  File? image;
  final picker = ImagePicker();
  UpdateUserResponseModel? updateUser;
  List<UserDetailsData> userData =[];

 @override
  void onInit() {
   super.onInit();
   userDetails();
 }

  void checkLogin() {
   Get.toNamed(loginScreen);
  }



  void onTapBackforAsk(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: const Text("Are you sure you want to Logout.??"),
          actions: <Widget>[
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(primary: AppColors.primary),
              child: const Text("YES",style: TextStyle(color: AppColors.white),),
              onPressed: () {
                onTapDelete();
                // exit(0);
                // SystemNavigator.pop();
              },
            ),
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(primary: AppColors.primary),
              child: const Text("NO",style: TextStyle(color: AppColors.white
              ),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> onTapDelete() async {
    // Remove the user token from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('user_id');
    prefs.remove('user_id');
    Get.offAllNamed(loginScreen);

  }



  final GlobalKey<FormState> _changeUserDetailsKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final mobileFocusNode = FocusNode();
  String name = "";  // To store the name
  String email = ""; // To store the email
  String mobile = ""; // To store the mobile number


  void openChangeUserDetailsBottomSheet(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: _changeUserDetailsKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    bottomSheetHandle(context),
                    const SizedBox(height:8,),
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {
                        showOptions(context);
                      },
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(end: 20),
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1.0, color:AppColors.whit)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child:imageFile == null ? Image.asset("assets/images/man_image1.jpg",fit: BoxFit.fill,): Image.file(imageFile!,fit:BoxFit.fill,)

                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width/1,
                      color: AppColors.whit,
                      child: TextFormField(
                        focusNode: nameFocusNode,
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name',
                          prefixIcon: Icon(Icons.person,color:AppColors.black,),
                        ),),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width/1,
                      color: AppColors.whit,
                      child: TextFormField(
                        focusNode: emailFocusNode,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email,color:AppColors.black,),
                        ),),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width/1,
                      color: AppColors.whit,
                      child: TextFormField(
                        focusNode: mobileFocusNode,
                        controller: mobController,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                          hintText: 'Mobile',
                          prefixIcon: Icon(Icons.phone,color:AppColors.black,),
                        ),),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width/1.5,
                      child: ElevatedButton(
                          onPressed: () {
                            if (imageFile == null || nameController.text.isEmpty || emailController.text.isEmpty || mobController.text.isEmpty) {
                              ShowMessage.showSnackBar('Name Error', 'All Field is require');
                            }  else {
                              userUpdate();
                            }
                          },style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                          child:const Text('Update',style:TextStyle(color:AppColors.white),)),
                    ),
                    const SizedBox(height: 15.0),

                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  Widget bottomSheetHandle(context) {
    return Padding(
      padding: const EdgeInsets.only(top:2.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color:AppColors.black.withOpacity(0.2)),
        height:3,
        width: MediaQuery.of(context).size.width * 0.27,
      ),
    );
  }




  File? imageFile;

  //Show options to get image from camera or gallery
  Future showOptions(context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {

              getImageCamera(ImageSource.gallery,1);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {

              getImage(ImageSource.camera,1);
            },
          ),
        ],
      ),
    );
  }




  Future getImage(ImageSource source, int i) async {
    var image = await ImagePicker().pickImage(
      source: source,
    );
    getCropImage(i,image);
    Get.back();
  }
  Future getImageCamera(ImageSource source, int i) async {
    var image = await ImagePicker().pickImage(
      source: source,
    );
    getCropImage(i,image);
    Get.back();
  }
  Future getCropImage(int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );

      if (i == 1) {
        print('_____1_____${i}_________');
        imageFile = File(croppedFile!.path);
        print('----------rrrrrr-------${imageFile}');
        update();
      }
    update();
  }






  /// User Details Update Api integration------>
  Future<void> userDetails() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.uniqueClientId] =ApiClient.uniqueKey;
      body[RequestKeys.userId] = user_id.toString();
      GetUserDetailsResponse res = await api.userDetailsDataApi(body);
      print('${res.message}_____message_');
      print('${body}_____parameter_');
      if (res.error==true) {
        userData = res.data;
        ShowMessage.showSnackBar('Server Res', res.message);
        setBusy(false);
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

  Future<void>userUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    var headers = {
      'Authorization': 'Bearer 18|9YbuJIMOShqyW1EHHiZPptgq9pu37fCtzHY5QmHK55c819d5'
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse('${ApiClient.baseAppUrl}user/update'));
      request.fields.addAll({
        'user_id': userId.toString(),
        'email': emailController.text,
        'mobile':mobController.text
      });
      request.files.add(await http.MultipartFile.fromPath(
          'image',imageFile!.path
      ));
      print('------ttt-----------${request.fields}');
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var myRequest = await response.stream.bytesToString();
        final finalResult = UpdateUserResponseModel.fromJson(json.decode(myRequest));

        updateUser = finalResult;

        ShowMessage.showSnackBar('msgTitle', 'User Profile Update');
        userDetails();
        update();
        Get.toNamed(profileScreen);
      }
      else {
        print(response.reasonPhrase);
      }


    } catch (e) {
     ShowMessage.showSnackBar('msgTitle', '$e');
    }
  }

}