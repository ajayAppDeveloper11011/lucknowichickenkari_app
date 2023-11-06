import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/colors.dart';
import '../../controllers/notification_controller.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NotificationController(),
      builder: (controller) {
      return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: const Text('Notification'),

        ),
        body: Column(
          children: [
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width/1.1,
                child: const Text('A notification is a message that Android displays'
                    ' outside your app''s' 'UI to provide the user with reminders, communication '
                    'from other people, or other timely ...',style: TextStyle(fontWeight: FontWeight.w500),),
              ),
            )
          ],
        ),
      );
    },);
  }
}
