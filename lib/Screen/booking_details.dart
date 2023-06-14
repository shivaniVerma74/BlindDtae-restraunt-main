import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Model/NewModel/get_bookings_model.dart';
import 'package:eshopmultivendor/Screen/WalletHistory.dart';
import 'package:flutter/material.dart';

class BookingDetails extends StatefulWidget {
  final Bookings? data;

  const BookingDetails({Key? key, this.data}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 80),
        child: AppBar(
          centerTitle: true,
          title: Image.asset('assets/images/homelogo.png', height: 60,),
          backgroundColor: primary,
          iconTheme: IconThemeData(color: white),
          actions: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> WalletHistory()));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0, top: 4),
                child: Column(
                  children: [
                    Icon(Icons.wallet, color: white, size: 30,),
                    Text("Wallet", style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w600
                    ),)
                  ],
                ),
              ),
            )],
        ),
      ),
      body: Stack(
        children: [
      Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset('assets/images/BG.png'),
      decoration: BoxDecoration(
        color: white.withOpacity(0.7)
          // image: DecorationImage(
          //   image: AssetImage('assets/images/BG.png'),
          // )
      ),),
          Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              // image: DecorationImage(
              //   image: AssetImage('assets/images/BG.png'),
              // )
            ),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Booking Date : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fontColor),),
                                Text(widget.data!.updateAt.toString(),
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: fontColor)),
                              ],
                            ),


                            Row(
                              children: [
                                Icon(Icons.access_time_rounded, color: primary, size: 18,),
                                Text(widget.data!.bookingTime.toString(),
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: fontColor)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Dating Date : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fontColor),),
                            Text(widget.data!.bookingDate.toString(),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: fontColor)),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Unique ID : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fontColor),),
                            Text(widget.data!.uniqueId.toString(),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: fontColor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  children: [
                    widget.data!.users![0].detail!.gender.toString() == "Female" ||  widget.data!.users![0].detail!.gender.toString() == "female"?
                    Image.asset('assets/images/girl.png', width: 70, height: 70,)
                        : Image.asset('assets/images/boy.png', width: 70, height: 70,),
                    const SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Name : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fontColor),),
                            Text(widget.data!.users![0].detail!.username.toString(),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: fontColor)),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Contact No.: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fontColor),),
                            Text(widget.data!.users![0].detail!.mobile.toString(),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: fontColor) ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                widget.data!.bookingStatus == "Waiting" ?
                    SizedBox.shrink() :
                Row(
                  children: [
                    widget.data!.users![1].detail!.gender.toString() == "Female" ||  widget.data!.users![1].detail!.gender.toString() == "female"?
                    Image.asset('assets/images/girl.png', width: 70, height: 70,)
                        : Image.asset('assets/images/boy.png', width: 70, height: 70,),
                    const SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Name : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fontColor),),
                            Text(widget.data!.users![1].detail!.username.toString(),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: fontColor)),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Contact No.: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fontColor),),
                            Text(widget.data!.users![1].detail!.mobile.toString(),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: fontColor) ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
             Card(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(15)
               ),
               elevation: 4,
               child: Container(
                 padding: EdgeInsets.all(8),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(15)
                 ),
                 child: Column(
                   children: [
                     const SizedBox(height: 5,),
                     Padding(
                       padding: const EdgeInsets.only(left: 0.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Approx. Amount : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fontColor),),
                           Text(
                               '₹ ${widget.data!.approxAmount.toString()}',
                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,  color: primary) ),
                         ],
                       ),
                     ),
                     const SizedBox(height: 5,),
                     Padding(
                       padding: const EdgeInsets.only(left: 0.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Table Type : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fontColor),),
                           Text(
                               '${widget.data!.tableName.toString()}',
                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,  color: primary) ),
                         ],
                       ),
                     ),
                     const SizedBox(height: 5,),
                     Padding(
                       padding: const EdgeInsets.only(left: 0.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Booking Status : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fontColor),),
                           Container(
                             padding: EdgeInsets.all(8),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: primary
                             ),
                             child: Text(
                                 '${widget.data!.bookingStatus.toString()}',
                                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: white) ),
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(height: 5,),
                   ],
                 ),
               ),
             )




              ],
            ),
          ),
        ],
      ),
    );
  }
}
