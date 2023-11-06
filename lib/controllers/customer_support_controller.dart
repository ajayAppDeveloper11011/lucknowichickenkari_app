import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';

import '../session/Session.dart';

class CustomerSupportController extends AppBaseController{
  String? type, email, title, desc, status, id;
  FocusNode? nameFocus, emailFocus, descFocus;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();


  List items = [
    'Test Ticket',
    'Order Canceled',
    'RTO',
    'Canceled my order'
  ];


  Widget setType() {
    return DropdownButtonFormField(
      iconEnabledColor:AppColors.black,
      isDense: true,
      hint:const Text('Select type',style: TextStyle(color:AppColors.black),
      ),
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        fillColor: AppColors.whit,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        focusedBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color:AppColors.primary ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide:
          const BorderSide(color:AppColors.primary),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      value: type,
      style: const TextStyle(color: AppColors.primary),
      onChanged: (String? newValue) {
            type = newValue;
           update();
      },
      items:items.map((val) {
        return DropdownMenuItem<String>(
          value: val,
          child: Text('${val}'
          ),
        );
      }).toList(),
    );
  }

  setEmail() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 10.0,
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        focusNode: emailFocus,
        textInputAction: TextInputAction.next,
        controller: emailController,
        style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.normal),
        validator: (val) => validateEmail(
            val!,
            'Email Is Require',
            'Enter valid Email Id'
        ),
        onSaved: (String? value) {
          email = value;
        },
        onFieldSubmitted: (v) {

        },
        decoration: InputDecoration(
          hintText: 'Enter Email id',
          hintStyle:const TextStyle(color: AppColors.primary),
          filled: true,
          fillColor: AppColors.whit,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color:AppColors.primary),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
            const BorderSide(color:AppColors.primary),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  setTitle(context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 10.0,
      ),
      child: TextFormField(
        focusNode: nameFocus,
        textInputAction: TextInputAction.next,
        controller: nameController,
        style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.normal),
        validator: (val) =>
            validateField(val!, 'Fill Required'),
        onSaved: (String? value) {
          title = value;
        },
        onFieldSubmitted: (v) {
          _fieldFocusChange(context, emailFocus!, nameFocus);
        },
        decoration: InputDecoration(
          hintText: 'Enter Name',
          hintStyle: const TextStyle(
              fontWeight: FontWeight.normal),
          filled: true,
          fillColor: AppColors.whit,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color:AppColors.primary),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
            const BorderSide(color:AppColors.primary),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  setDesc(context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 10.0,
      ),
      child: TextFormField(
        focusNode: descFocus,
        controller: descController,
        maxLines: null,
        style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.normal),
        validator: (val) =>
            validateField(val!,'Fill Require'),
        onSaved: (String? value) {
          desc = value;
        },
        onFieldSubmitted: (v) {
          _fieldFocusChange(context, emailFocus!, nameFocus);
        },
        decoration: InputDecoration(
          hintText: 'Description',
          hintStyle: TextStyle(
              fontWeight: FontWeight.normal),
          filled: true,
          fillColor: AppColors.whit,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color:AppColors.primary),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
            const BorderSide(color:AppColors.primary),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }


  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode? nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

}