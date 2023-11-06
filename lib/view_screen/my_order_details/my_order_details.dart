import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/my_order_details_controller.dart';

class MyOrderDetails extends StatefulWidget {
  const MyOrderDetails({Key? key}) : super(key: key);



  @override
  State<MyOrderDetails> createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {
  String? pDate, prDate, sDate, dDate, cDate, rDate,aDate;
  double curRating = 0.0;
  TextEditingController commentTextController = TextEditingController();




  List att =[
    'Ajay',
    'Ram'
  ];
  bool _isReturnClick = true;
  bool _isProgress = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyOrderDetailsController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle:true,
          title: const Text('Order Details'),
          backgroundColor: AppColors.primary,
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height:20),
              Container(
                width: MediaQuery.of(context).size.width/1,
                color: AppColors.textFieldClr,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,right: 20),
                      child: Row(
                        children: [
                          Container(
                            height:100,
                            width: 80,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:Image.asset('assets/images/formal_image1.jpg',fit: BoxFit.fill,)),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: att.length,
                                      itemBuilder: (context, index) {
                                        return Row(children: [
                                          Flexible(
                                            child: Text(
                                              att[index].trim() + ":",
                                              overflow: TextOverflow.ellipsis,

                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 5.0),
                                            child: Text(
                                                'Ajay'
                                            ),
                                          )
                                        ]);
                                      }),
                                  const Row(children: [
                                    Text(
                                      'Quantity'":",

                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(start: 5.0),
                                      child: Text(
                                        'Ajay',

                                      ),
                                    )
                                  ]),
                                  const Text(
                                    "Rs 222",

                                  ),
                                  //  Text(orderItem.status)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                        color:AppColors.black
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pDate != null ? getPlaced() :
                          getPlaced(),
                          getProcessed(prDate, cDate),
                          getShipped(sDate, cDate),
                          getDelivered(dDate, cDate),
                          getCanceled(cDate),
                          getReturned(rDate),
                        ],
                      ),
                    ),
                    const Divider(
                        color: AppColors.black
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,right:20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Store Name :",
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "OTP :",
                                style: TextStyle(
                                    color: AppColors.black,fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "Order Remark : ",
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5,),
                              // orderItem.courier_agency! != ""
                              //     ?
                              // Text("Courier agency "),
                              // Text("Tracking Id"),

                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                child: const Text(
                                  "Store Name",
                                  style: TextStyle(
                                      color:
                                      AppColors.primary,
                                      decoration: TextDecoration.underline),
                                ),
                                onTap: () {
                                },
                              ),
                              const SizedBox(height: 5,),
                              const Text(
                                " 8888",

                              ),
                              const SizedBox(height: 5,),
                              // orderItem.courier_agency! != ""
                              //     ?
                              const Text("Courier agency",
                                style: TextStyle(
                                  color: AppColors.black,
                                ),
                              ),
                              // : Container(),
                              // orderItem.tracking_id! != ""
                              //     ?
                              // RichText(
                              //     text: TextSpan(children: [
                              //       const TextSpan(
                              //         text: "kkk",
                              //
                              //       ),
                              //       TextSpan(
                              //           text: "courier agency",
                              //           style: const TextStyle(
                              //               color:AppColors.black,
                              //               decoration: TextDecoration.underline),
                              //           recognizer: TapGestureRecognizer()
                              //             ..onTap = () async {
                              //               var url = "Order tracking url";
                              //
                              //               if (await canLaunch(url)) {
                              //                 await launch(url);
                              //               } else {
                              //                 print('Error');
                              //               }
                              //             })
                              //     ]))
                              // : Container(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:0,right: 10,top:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: _isReturnClick
                                ? () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'ARE_YOU_SURE?'
                                    ),
                                    content: const Text(
                                      "Would you like to cancel this order?",
                                      style: TextStyle(
                                          color: AppColors.primary),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('yes',
                                          style: TextStyle(
                                              color:AppColors.primary),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            _isReturnClick = false;
                                            _isProgress = true;
                                          });
                                          // cancelOrder(
                                          //     CANCLED,
                                          //     updateOrderItemApi,
                                          //     orderItem.id);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                              color:AppColors.primary),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                                : null,
                            child:
                            const Text('Item Cancel'),
                          ),
                          const SizedBox(width:5,),
                          OutlinedButton(
                            onPressed: _isReturnClick
                                ? () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'ARE_YOU_SURE?'
                                    ),
                                    content: const Text(
                                      "Would you like to return this product?",
                                      style: TextStyle(
                                          color: AppColors.primary),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                              color: AppColors.primary),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            // _isReturnClick = false;
                                            // _isProgress = true;
                                          });
                                          // cancelOrder(
                                          //     RETURNED,
                                          //     updateOrderItemApi,
                                          //     orderItem.id);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                              color: AppColors.primary),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                                : null,
                            child: const Text(
                                'Item return'
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // else
              //   (orderItem.listStatus!.contains(DELIVERD) &&
              //           orderItem.isReturn == "1" &&
              //           orderItem.isAlrReturned == "0")
              //       ?

              ///
              const SizedBox(height: 10,),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width/1.1,
                child: OutlinedButton.icon(
                  onPressed: () {
                    openBottomSheet(context);
                  },
                  icon: const Icon(Icons.rate_review_outlined,
                      color: AppColors.primary),
                  label: const Text(
                    'Wright Review',
                    style: TextStyle(color:AppColors.primary),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color:AppColors.primary),
                  ),
                ),
              ),
              // if (!orderItem.listStatus!.contains(PROCESSED) &&
              //     (!orderItem.listStatus!.contains(PLACED)) &&
              //     (!orderItem.listStatus!.contains(SHIPED)) )
              //     &&
              //     orderItem.isCancle == "1" &&
              //     orderItem.isAlrCancelled == "0")
              const SizedBox(height: 20,),
            ],
          ),
        )
      );
    },);
  }

  // downloadInvoice() {
  //   return Card(
  //     elevation: 0,
  //     child: InkWell(
  //         child: const ListTile(
  //           dense: true,
  //           trailing: Icon(
  //             Icons.keyboard_arrow_right,
  //             color:AppColors.primary,
  //           ),
  //           leading: Icon(
  //             Icons.receipt,
  //             color: AppColors.primary,
  //           ),
  //           title: Text(
  //             'Download Invoice',
  //             style:TextStyle(color:AppColors.primary),
  //           ),
  //         ),
  //         onTap: () async {
  //           final status = await Permission.storage.request();
  //
  //           if (status == PermissionStatus.granted) {
  //             if (mounted) {
  //               setState(() {
  //                 _isProgress = true;
  //               });
  //             }
  //             var targetPath;
  //
  //             if (Platform.isIOS) {
  //               var target = await getApplicationDocumentsDirectory();
  //               targetPath = target.path.toString();
  //             } else {
  //               var downloadsDirectory =
  //               await DownloadsPathProvider.downloadsDirectory;
  //               targetPath = downloadsDirectory!.path.toString();
  //             }
  //
  //             var targetFileName = "Invoice_${widget.model!.id}";
  //             var generatedPdfFile, filePath;
  //             try {
  //               generatedPdfFile =
  //               await FlutterHtmlToPdf.convertFromHtmlContent(
  //                   widget.model!.invoice!, targetPath, targetFileName);
  //               filePath = generatedPdfFile.path;
  //             } on Exception {
  //               //  filePath = targetPath + "/" + targetFileName + ".html";
  //               generatedPdfFile =
  //               await FlutterHtmlToPdf.convertFromHtmlContent(
  //                   widget.model!.invoice!, targetPath, targetFileName);
  //               filePath = generatedPdfFile.path;
  //             }
  //
  //             if (mounted) {
  //               setState(() {
  //                 _isProgress = false;
  //               });
  //             }
  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //               content: Text(
  //                 "INVOICE_PATH $targetFileName",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(color: Theme.of(context).colorScheme.black),
  //               ),
  //               action: SnackBarAction(
  //                   label: ,
  //                   textColor: Theme.of(context).colorScheme.fontColor,
  //                   onPressed: () async {
  //                     final result = await OpenFilex.open(filePath);
  //                   }),
  //               backgroundColor: Theme.of(context).colorScheme.white,
  //               elevation: 1.0,
  //             ));
  //           }
  //         }),
  //   );
  // }

  getPlaced() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(
          Icons.circle,
          color: AppColors.primary,
          size: 15,
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 10),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Placed',
                style: TextStyle(fontSize: 8),
              ),
              Text(
                "pDate",
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getProcessed(String? prDate, String? cDate) {
    return cDate == null
        ? Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 30,
                child: VerticalDivider(
                  thickness: 2,
                  color: prDate == null ? Colors.grey : AppColors.red,
                )),
            Icon(
              Icons.circle,
              color: prDate == null ? Colors.grey : AppColors.red,
              size: 15,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Proceed',
                style: TextStyle(fontSize: 8),
              ),
              Text(
                prDate ?? " ",
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ],
    )
        : prDate == null
        ? Container()
        : Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30,
              child: VerticalDivider(
                thickness: 2,
                color: AppColors.red,
              ),
            ),
            Icon(
              Icons.circle,
              color: AppColors.red,
              size: 15,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Proceed',
                style: TextStyle(fontSize: 8),
              ),
              Text(
                prDate,
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getShipped(String? sDate, String? cDate) {
    return cDate == null
        ? Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            Container(
              height: 30,
              child: VerticalDivider(
                thickness: 2,
                color: sDate == null ? Colors.grey : AppColors.primary,
              ),
            ),
            Icon(
              Icons.circle,
              color: sDate == null ? Colors.grey : AppColors.primary,
              size: 15,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Order Shipped',
                style: TextStyle(fontSize: 8),
                textAlign: TextAlign.center,
              ),
              Text(
                sDate ?? " ",
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ],
    )
        : sDate == null
        ? Container()
        : Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            Container(
              height: 30,
              child: const VerticalDivider(
                thickness: 2,
                color: AppColors.primary,
              ),
            ),
            const Icon(
              Icons.circle,
              color: AppColors.primary,
              size: 15,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Shipped",
                style: TextStyle(fontSize: 8),
                textAlign: TextAlign.center,
              ),
              Text(
                sDate,
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getDelivered(String? dDate, String? cDate) {
    return cDate == null
        ? Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            Container(
              height: 30,
              child: VerticalDivider(
                thickness: 2,
                color: dDate == null ? Colors.grey : AppColors.primary,
              ),
            ),
            Icon(
              Icons.circle,
              color: dDate == null ? Colors.grey : AppColors.primary,
              size: 15,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Delivered',
                style: TextStyle(fontSize: 8),
                textAlign: TextAlign.center,
              ),
              Text(
                dDate ?? " ",
                style: TextStyle(fontSize: 8),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    )
        : Container();
  }

  getCanceled(String? cDate) {
    return cDate != null
        ? Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            Container(
              height: 30,
              child: const VerticalDivider(
                thickness: 2,
                color: AppColors.primary,
              ),
            ),
            const Icon(
              Icons.cancel_rounded,
              color: AppColors.primary,
              size: 15,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Cancelled",
                style: TextStyle(fontSize: 8),
              ),
              Text(
                cDate,
                style: TextStyle(fontSize: 8),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    )
        : Container();
  }

  getReturned(String? rDate) {
    return
      // item.listStatus!.contains(RETURNED)
      //   ?
    Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            Container(
              height: 30,
              child: const VerticalDivider(
                thickness: 2,
                color: AppColors.primary,
              ),
            ),
            const Icon(
              Icons.cancel_rounded,
              color: AppColors.primary,
              size: 15,
            ),
          ],
        ),
        Container(
            margin: const EdgeInsetsDirectional.only(start: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Order Return',
                  style: TextStyle(fontSize: 8),
                ),
                Text(
                  rDate ?? " ",
                  style: const TextStyle(fontSize: 8),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ],
    );
        // : Container();
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    bottomSheetHandle(),
                    rateTextLabel(),
                    ratingWidget(),
                    writeReviewLabel(),
                    writeReviewField(),
                    getImageField(),
                    sendReviewButton(),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget bottomSheetHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: AppColors.black),
        height: 5,
        width: MediaQuery.of(context).size.width * 0.3,
      ),
    );
  }

  Widget rateTextLabel() {
    return const Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text('PRODUCT_REVIEW'),
    );
  }

  Widget ratingWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RatingBar.builder(
        initialRating: 0,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemSize: 32,
        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: AppColors.orange,
        ),
        onRatingUpdate: (rating) {
          curRating = rating;
        },
      ),
    );
  }

  Widget writeReviewLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(
        'Review Option',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1!,
      ),
    );
  }

  Widget writeReviewField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: TextField(
          controller: commentTextController,
          style: Theme.of(context).textTheme.subtitle2,
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 1.0)),
            hintText:'Review',
            hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                color:AppColors.primary),
          ),
        ));
  }

  Widget getImageField() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            padding:
            const EdgeInsetsDirectional.only(start: 20.0, end: 20.0, top: 5),
            height: 100,
            child: Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(50.0)),
                        child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: AppColors.whit,
                              size: 25.0,
                            ),
                            onPressed: () {
                              // _reviewImgFromGallery(setModalState);
                            }),
                      ),
                      const Text(
                        "Add Your Photo",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 11),
                      )
                    ],
                  ),
                ),
                // Expanded(
                //     child: ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: reviewPhotos.length,
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (context, i) {
                //         return InkWell(
                //           child: Stack(
                //             alignment: AlignmentDirectional.topEnd,
                //             children: [
                //               Image.file(
                //                 reviewPhotos[i],
                //                 width: 100,
                //                 height: 100,
                //               ),
                //               Container(
                //                   color: Theme.of(context).colorScheme.black26,
                //                   child: const Icon(
                //                     Icons.clear,
                //                     size: 15,
                //                   ))
                //             ],
                //           ),
                //           onTap: () {
                //             if (mounted) {
                //               setModalState(() {
                //                 // reviewPhotos.removeAt(i);
                //               });
                //             }
                //           },
                //         );
                //       },
                //     )),
              ],
            ),
          );
        });
  }

  Widget sendReviewButton() {
    return Row(
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: MaterialButton(
            height: 45.0,
            textColor: AppColors.whit,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            onPressed: () {
              // if (curRating != 0 ||
              //     commentTextController.text != '' ||
              //     (reviewPhotos.isNotEmpty)) {
              //   Navigator.pop(context);
              //   setRating(curRating, commentTextController.text, reviewPhotos,
              //       productID);
              // } else {
              //   Navigator.pop(context);
              //   setSnackbar(getTranslated(context, 'REVIEW_W')!);
              // }
            },
            child: const Text('Sens Review',
            )
          ),
        ),
      ],
    );
  }


}
