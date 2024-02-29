import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/contact_us_controller.dart';
import '../../Utils/colors.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ContactUsController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle : true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back,color: AppColors.whit,)),
          backgroundColor: AppColors.primary,
          title:const Text('Contact Us',style:TextStyle(color: AppColors.white),),
        ),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20),
              child: Text(
                'Contact Us:',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 8),
            const ListTile(
              leading: Icon(Icons.location_on,color: AppColors.black,),
              title: Text('Indore Madhya Pradesh',style:TextStyle(color: AppColors.black),),
              subtitle: Text('Palasiya,South tukoganj'),
            ),
            const ListTile(
              leading: Icon(Icons.phone,color: AppColors.black,),
              title: Text('(123) 456-7890',style: TextStyle(color: AppColors.black),),
            ),
            ListTile(
              leading: const Icon(Icons.email,color: AppColors.black,),
              title: const Text('siondatamatics@company.com'),
              onTap: () {
                controller.launchInBrowser(controller.url);
              },
            ),
            Container(
                width:200,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Follow Us:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.facebook_outlined,color:Colors.blue,),
                      title: const Text('Facebook'),
                      onTap: () {

                      },
                      ),

                    ListTile(
                      leading: const Icon(Icons.link),
                      title: const Text('Twitter'),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.link),
                      title: const Text('Instagram'),
                      onTap: () {

                      },
                    ),
                  ],
                )
            ),
          ],
        )
      );
    },);
  }
}




