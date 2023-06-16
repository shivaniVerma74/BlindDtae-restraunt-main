import 'dart:async';
import 'dart:convert';
import 'package:eshopmultivendor/Helper/ApiBaseHelper.dart';
import 'package:eshopmultivendor/Helper/AppBtn.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Constant.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/SimBtn.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:eshopmultivendor/Model/NewModel/wallet_transactions_model.dart';
import 'package:eshopmultivendor/Model/getWithdrawelRequest/getWithdrawelmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';

class WalletHistory extends StatefulWidget {
  const WalletHistory({Key? key}) : super(key: key);

  @override
  _WalletHistoryState createState() => _WalletHistoryState();
}

bool _isLoading = true;
bool isLoadingmore = true;
int offset = 0;
int total = 0;
List<GetWithdrawelReq> tranList = [];

class _WalletHistoryState extends State<WalletHistory>
    with TickerProviderStateMixin {
  TextEditingController amountController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isNetworkAvail = true;
  String? amount, msg;
  ScrollController controller = new ScrollController();
  TextEditingController? amtC, bankDetailC;
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<GetWithdrawelReq> tempList = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  Razorpay _razorpay =  Razorpay();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserDetails();
    getWalletTransactions();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    getWithdrawalRequest();
    getSallerBalance();
    controller.addListener(_scrollListener);
    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(new CurvedAnimation(
      parent: buttonController!,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ));
    amtC = new TextEditingController();
    bankDetailC = new TextEditingController();

  }

  List<WalletTransactions> walletTransactions = [];

  getWalletTransactions() async{

    CUR_USERID = await getPrefrence(Id);
    var headers = {
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request = http.MultipartRequest('POST', Uri.parse(walletTransactionsApi.toString()));
    request.fields.addAll({
      UserId : CUR_USERID.toString()
    });

    print("this is refer request ${request.fields.toString()}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = WalletTransactionsModel.fromJson(result);
      setState(() {
        _isLoading = false;
        walletTransactions = finalResponse.data!;
      });
      print("this is referral data ${walletTransactions.length}");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  ///RAZORPAY/////////////////////////////

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    addMoneyWallet();
    //placeOrder(response.paymentId);
    // sendRequest(response.paymentId, "RazorPay");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setSnackbar(response.message!);
    // if (mounted)
      // setState(() {
      //   _isProgress = false;
      // });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: " + response.walletName!);
  }

  addMoneyWallet() async{
    CUR_USERID = await getPrefrence(Id);
    var headers = {
      // 'Token': jwtToken.toString(),
      // 'Authorisedkey': authKey.toString(),
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };

    var request = http.MultipartRequest('POST', Uri.parse(addMoneyWalletApi.toString()));
    request.fields.addAll({
      UserId : CUR_USERID.toString(),
      'amount': amtC!.text.toString()
    });

    print("this is add money request ${request.fields.toString()}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: result['message'].toString());
      // _refresh();

      getWalletTransactions();
      getSallerBalance();


    }
    else {
      print(response.reasonPhrase);
    }
  }

  String? mobile, name, email;

  getUserDetails() async {
    CUR_USERID = await getPrefrence(Id);
    mobile = await getPrefrence(Mobile);
    name = await getPrefrence(Username);
    email = await getPrefrence(Email);
    setState(() {});
  }

  razorpayPayment(double price) async {
    // SettingProvider settingsProvider =
    // Provider.of<SettingProvider>(this.context, listen: false);
    //
    // String? contact = settingsProvider.mobile;
    // String? email = settingsProvider.email;

    double amt = price * 100;

    if (mobile != '' && email != '') {
      if (mounted)
        // setState(() {
        //   _isProgress = true;
        // });

      // var req = {
      //   'key': 'rzp_test_1spO8LVd5ENWfO',
      //   'amount': amt.toString(),
      //   'name': name.toString(),
      //   'prefill': {'contact': '${mobile.toString()}', 'email': '${email.toString()}'},
      // };

      try {
        _razorpay.open({
          'key': 'rzp_test_1spO8LVd5ENWfO',
          'amount': amt.toString(),
          'name': name.toString(),
          'prefill': {'contact': '${mobile.toString()}', 'email': '${email.toString()}'},
        });
      } catch (e) {
        debugPrint(e.toString());
      }

    } else {
      if (email == '')
        setSnackbar(getTranslated(context, 'emailWarning')!);
      else if (mobile == '')
        setSnackbar(getTranslated(context, 'phoneWarning')!);
    }
  }

  ///RAZORPAY/////////////////////////////


  _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (this.mounted) {
        setState(() {
          isLoadingmore = true;

          if (offset < total) getWithdrawalRequest();
        });
      }
    }
  }

  getSallerBalance() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      CUR_USERID = await getPrefrence(Id);

      var parameter = {Id: CUR_USERID};
      apiBaseHelper.postAPICall(getSellerDetails, parameter).then(
        (getdata) async {
          bool error = getdata["error"];
          String? msg = getdata["message"];

          if (!error) {
            var data = getdata["data"][0];
            CUR_BALANCE = double.parse(data[BALANCE]).toStringAsFixed(2);
          }
          setState(() {
            _isLoading = false;
          });
        },
        onError: (error) {
          setSnackbar(error.toString());
          setState(() {
            _isLoading = false;
          });
        },
      );
    } else {
      if (mounted)
        setState(
          () {
            _isNetworkAvail = false;
            _isLoading = false;
          },
        );
    }
    return null;
  }

  Future<Null> getWithdrawalRequest() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      var parameter = {UserId: CUR_USERID};
      apiBaseHelper.postAPICall(getWithDrawalRequestApi, parameter).then(
        (getdata) async {
          bool error = getdata["error"];
          String? msg = getdata["message"];
          print("WithDraw Api....${getWithDrawalRequestApi.toString()}");
          print(parameter.toString());

          if (!error) {
            total = int.parse(
              getdata["total"],
            );
            if ((offset) < total) {
              tempList.clear();
              var data = getdata["data"];

              tempList = (data as List)
                  .map((data) => new GetWithdrawelReq.fromReqJson(data))
                  .toList();

              tranList.addAll(tempList);

              offset = offset + perPage;
            }
            await getSallerBalance();
          }
          setState(() {
            _isLoading = false;
          });
        },
        onError: (error) {
          setSnackbar(error.toString());
          setState(
            () {
              _isLoading = false;
              isLoadingmore = false;
            },
          );
        },
      );
    } else
      setState(() {
        _isNetworkAvail = false;
      });
    return null;
  }

  getBalanceShower() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: primary,
                  ),
                  Text(
                    " " + getTranslated(context, "CURBAL_LBL")!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: grey,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Text(CUR_CURRENCY + " " + CUR_BALANCE,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: black, fontWeight: FontWeight.bold)),
              SimBtn(
                size: 0.8,
                title: getTranslated(context, "ADD_MONEY")!,
                onBtnSelected: () {
                  _showDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _refresh() async {
    Completer<Null> completer = new Completer<Null>();
    await Future.delayed(Duration(seconds: 1)).then(
      (onvalue) {
        completer.complete();
        offset = 0;
        total = 0;
        tranList.clear();
        setState(
          () {
            _isLoading = true;
          },
        );
        tranList.clear();
        getWithdrawalRequest();
        getSallerBalance();
      },
    );
    return completer.future;
  }
  
  StateSetter? dialogState;

  _showDialog() async {
    bool payWarn = false;
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
          dialogState = setStater;
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                    child: Text(
                    "Add Money",
                      style: Theme.of(this.context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: fontColor),
                    ),
                  ),
                  Divider(color: Colors.black),
                  Form(
                    key: _formkey,
                    child: Flexible(
                      child: SingleChildScrollView(
                          child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (val) => validateAmount(val!, context),
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      style: TextStyle(
                                        color: fontColor,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Enter Amount",
                                        hintStyle: Theme.of(this.context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      controller: amtC,
                                    )),
                                // Padding(
                                //     padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                //     child: TextFormField(
                                //       autovalidateMode:
                                //       AutovalidateMode.onUserInteraction,
                                //       style: TextStyle(
                                //         color: fontColor,
                                //       ),
                                //       decoration: new InputDecoration(
                                //         hintText: getTranslated(context, 'MSG'),
                                //         hintStyle: Theme.of(this.context)
                                //             .textTheme
                                //             .subtitle1!
                                //             .copyWith(
                                //             color: Colors.black,
                                //             fontWeight: FontWeight.normal),
                                //       ),
                                //       controller: messageController,
                                //     )),
                                //Divider(),
                                // Padding(
                                //   padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                                //   child: Text(
                                //    "Select Payment",
                                //     style: Theme.of(context).textTheme.subtitle2,
                                //   ),
                                // ),
                                // Divider(),
                                payWarn
                                    ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    getTranslated(context, 'payWarning')!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.red),
                                  ),
                                )
                                    : Container(),

                                // paypal == null
                                //     ? Center(child: CircularProgressIndicator())
                                //     : Column(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: getPayList()),
                              ])),
                    ),
                  )
                ]),
            actions: <Widget>[
              new TextButton(
                  child: Text(
                    "Cancel",
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new TextButton(
                  child: Text(
                  "Add",
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: fontColor,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    final form = _formkey.currentState!;
                    if (form.validate() && amtC!.text != '0') {
                      form.save();
                      double amount = double.parse(amtC!.text.toString());
                      razorpayPayment((amount));
                    }

                  })
            ],
          );
        }));
  }

  // send withdrawel request

  Future<Null> sendRequest() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      //    try {
      var parameter = {
        UserId: CUR_USERID,
        Amount: amtC!.text.toString(),
        PaymentAddress: bankDetailC!.text.toString()
      };

      apiBaseHelper.postAPICall(sendWithDrawalRequestApi, parameter).then(
        (getdata) {
          bool error = getdata["error"];
          String? msg = getdata["message"];
          print("Send WithDraw Api ${sendWithDrawalRequestApi.toString()}");
          print(parameter.toString());
          print(sendWithDrawalRequestApi.toString());

          if (!error) {
            setSnackbar(msg!);
            print("we are here");
            setState(
              () {
                _isLoading = true;
              },
            );
            tranList.clear();
            getWithdrawalRequest();
          } else {
            setSnackbar(msg!);
          }
        },
      );
    } else {
      if (mounted)
        setState(
          () {
            _isNetworkAvail = false;
            _isLoading = false;
          },
        );
    }

    return null;
  }

  setSnackbar(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: primary,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  // _showDialog() async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setStater) {
  //           return AlertDialog(
  //             contentPadding: const EdgeInsets.all(0.0),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(5.0))),
  //             content: SingleChildScrollView(
  //               scrollDirection: Axis.vertical,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
  //                     child: Text(
  //                       getTranslated(context, "SEND_REQUEST")!,
  //                       style: Theme.of(this.context)
  //                           .textTheme
  //                           .subtitle1!
  //                           .copyWith(color: fontColor),
  //                     ),
  //                   ),
  //                   Divider(color: lightBlack),
  //                   Form(
  //                     key: _formkey,
  //                     child: new Column(
  //                       children: <Widget>[
  //                         Padding(
  //                           padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
  //                           child: TextFormField(
  //                             keyboardType: TextInputType.number,
  //                             validator: (val) => validateField(val, context),
  //                             autovalidateMode:
  //                                 AutovalidateMode.onUserInteraction,
  //                             decoration: InputDecoration(
  //                               hintText:
  //                                   getTranslated(context, "WITHDRWAL_AMT")!,
  //                               hintStyle: Theme.of(this.context)
  //                                   .textTheme
  //                                   .subtitle1!
  //                                   .copyWith(
  //                                       color: lightBlack,
  //                                       fontWeight: FontWeight.normal),
  //                             ),
  //                             controller: amtC,
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
  //                           child: TextFormField(
  //                             validator: (val) => validateField(val, context),
  //                             keyboardType: TextInputType.multiline,
  //                             maxLines: null,
  //                             autovalidateMode:
  //                                 AutovalidateMode.onUserInteraction,
  //                             decoration: new InputDecoration(
  //                               hintText: BANK_DETAIL,
  //                               hintStyle: Theme.of(this.context)
  //                                   .textTheme
  //                                   .subtitle1!
  //                                   .copyWith(
  //                                       color: lightBlack,
  //                                       fontWeight: FontWeight.normal),
  //                             ),
  //                             controller: bankDetailC,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             actions: <Widget>[
  //               new ElevatedButton(
  //                 child: Text(
  //                   getTranslated(context, "CANCEL")!,
  //                   style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
  //                       color: lightBlack, fontWeight: FontWeight.bold),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //               new ElevatedButton(
  //                 child: Text(
  //                   getTranslated(context, "SEND_LBL")!,
  //                   style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
  //                       color: fontColor, fontWeight: FontWeight.bold),
  //                 ),
  //                 onPressed: () {
  //                   final form = _formkey.currentState!;
  //                   if (form.validate()) {
  //                     form.save();
  //                     sendRequest();
  //                     Navigator.pop(context);
  //                     offset = 0;
  //                     total = 0;
  //                     tranList.clear();
  //                   }
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightWhite,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: white,
        leading: Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.all(10),
              decoration: shadow(),
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () => Navigator.of(context).pop(),
                child: Center(
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: primary,
                    size: 30,
                  ),
                ),
              ),
            );
          },
        ),
        title: Text(
          "Wallet History",
          style: TextStyle(
            color: grad2Color,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: primary, size: 30,),
            onPressed: (){
              getWalletTransactions();
              // _refresh();
            },
          ),
        ],
      ),
      body: _isNetworkAvail
          ? _isLoading
              ? shimmer()
              : RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        getBalanceShower(),
                        walletTransactions.isEmpty
                            ? Center(
                                child: Text(
                                  getTranslated(context, "noItem")!,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:  walletTransactions.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return
                                    // (index == walletTransactions.length &&
                                    //       isLoadingmore)
                                    //   ? Center(
                                    //       child: CircularProgressIndicator())
                                    //   :
                                  listItem(index);
                                },
                              ),
                      ],
                    ),
                  ),
                )
          : noInternet(context),
    );
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  Widget noInternet(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            noIntImage(),
            noIntText(context),
            noIntDec(context),
            AppBtn(
              title: getTranslated(context, "TRY_AGAIN_INT_LBL")!,
              btnAnim: buttonSqueezeanimation,
              btnCntrl: buttonController,
              onBtnSelected: () async {
                _playAnimation();

                Future.delayed(Duration(seconds: 2)).then(
                  (_) async {
                    _isNetworkAvail = await isNetworkAvailable();
                    if (_isNetworkAvail) {
                      await getWithdrawalRequest();
                    } else {
                      await buttonController!.reverse();
                      setState(
                        () {},
                      );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  listItem(int index) {
    print("STATUS============= ${walletTransactions[index].status}");
    Color back;
    if (walletTransactions[index].status == "1" || walletTransactions[index].status == ACCEPTEd) {
      back = Colors.green;
    } else if (walletTransactions[index].status == "0")
      back = Colors.orange;
    else
      back = red;
    if (walletTransactions[index].status == "1" || walletTransactions[index].status == ACCEPTEd) {
      back = Colors.green;
    } else if (walletTransactions[index].status == "1" || walletTransactions[index].status == PENDINg)
      back = Colors.yellow;
    else
      back = red;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(13), topRight: Radius.circular(13))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(walletTransactions[index].dateCreated!,  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, ),),
                ],
              ),
            ),
            // Text(tranList[index].
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/transactions.png', height: 50, width: 50,),
                  SizedBox(width: 15,),
                  SizedBox(
                    width: 200,
                    child: Text(
                      walletTransactions[index].message.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: black, fontWeight: FontWeight.normal, fontSize: 14, ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                        "₹ " +
                            double.parse(walletTransactions[index].amount!).toStringAsFixed(0),
                    style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8, bottom: 8),
                   padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                  decoration: BoxDecoration(
                    color: back,
                    borderRadius: new BorderRadius.all(
                      const Radius.circular(4.0),
                    ),
                  ),
                  child: walletTransactions[index].status == "1"
                      ? Text("Completed",
                    style: TextStyle(color: white),
                  )
                      : Text(
                    "Pending",
                    style: TextStyle(color: white),
                  ),
                ),
              ],
            )
              ],
            ),
      ),
      //     // walletTransactions[index].paymentAddress != null &&
      //     //     walletTransactions[index].paymentAddress!.isNotEmpty
      //     //     ? Text(getTranslated(context, "PaymentAddress")! +
      //     //         " : " +
      //     //         tranList[index].paymentAddress! +
      //     //         ".")
      //     //     : Container(),
      //     // tranList[index].paymentType != null &&
      //     //         tranList[index].paymentType!.isNotEmpty
      //     //     ? Text(getTranslated(context, "PaymentType")! +
      //     //         " : " +
      //     //         tranList[index].paymentType!)
      //     //     : Container(),
      //   ],
      // ),
    );
  }

}
