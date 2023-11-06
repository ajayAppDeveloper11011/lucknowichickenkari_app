import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';

class MyOrderDetailsController extends AppBaseController{
  int? curIndex = 0;
  List orderListView = [
    'All Details',
    'Processing',
    'Shipped',
    'Delivered',
    'Canceled',
    'Return'

  ] ;

  Widget buildOrderStatusTile(String status, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? Colors.green : Colors.grey,
            ),
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Container(),
          ),
          const SizedBox(width: 20),
          Text(
            status,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isCompleted ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }


}