import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/my_order_controller.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyOrderController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back,color: AppColors.whit,)),
          backgroundColor: AppColors.primary,
          title: const Text('My Order',style: TextStyle(color: AppColors.white),),
        ),
        body: SingleChildScrollView(
          child:controller.orderListData.isEmpty?const Padding(
            padding: EdgeInsets.only(top:50.0,left:140,right: 140),
            child: Text('Data Not Found'),
          ):
          Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height:MediaQuery.of(context).size.height/1.2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    // controller: scrollController,
                    itemCount:controller.orderListData.isEmpty?0:controller.orderListData.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation:4,
                        //margin: EdgeInsets.all(5.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                              ClipRRect(
                                borderRadius:const BorderRadius.only(
                                    bottomLeft: Radius.circular(7.0),
                                    topLeft: Radius.circular(7.0)),
                                child:Image.asset('assets/images/kurta_image7.jpeg',height:130,width:110,fit: BoxFit.fill,)

                              ),
                           
                              Expanded(
                                  flex: 9,
                                  child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start:30.0, end: 5.0, bottom: 8.0, top: 8.0),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text('Date : '),
                                            const Text('Time : '),
                                            Text(
                                              "${controller.orderListData[index].paymentMode}",
                                              style: const TextStyle(color: AppColors.black),
                                            ),
                                            Padding(
                                                padding:
                                                const EdgeInsetsDirectional.only(top: 10.0),
                                                child: Text(
                                                  'Order Id : ${controller.orderListData[index].orderId}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontWeight: FontWeight.normal),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                )),
                                          ]))),
                              const Spacer(),
                              const Padding(
                                padding: EdgeInsets.only(right: 3.0),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color:AppColors.primary,
                                  size: 15,
                                ),
                              )
                            ]),
                          ]),
                          onTap: () async {
                            controller.onTapOrderDetailsScreen(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      );
    },);
  }
}
