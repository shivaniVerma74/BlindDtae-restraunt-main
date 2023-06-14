/// error : false
/// message : "Wallet Transactions Get successfully"
/// data : [{"id":"4","user_id":"76","type":"credit","amount":"50","message":"credit","status":"1","date_created":"2023-04-27 10:54:29","last_updated":"0000-00-00 00:00:00"},{"id":"5","user_id":"76","type":"credit","amount":"100","message":"credit","status":"1","date_created":"2023-04-27 11:32:04","last_updated":"0000-00-00 00:00:00"}]

class WalletTransactionsModel {
  WalletTransactionsModel({
      bool? error, 
      String? message, 
      List<WalletTransactions>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  WalletTransactionsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WalletTransactions.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<WalletTransactions>? _data;
WalletTransactionsModel copyWith({  bool? error,
  String? message,
  List<WalletTransactions>? data,
}) => WalletTransactionsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<WalletTransactions>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "4"
/// user_id : "76"
/// type : "credit"
/// amount : "50"
/// message : "credit"
/// status : "1"
/// date_created : "2023-04-27 10:54:29"
/// last_updated : "0000-00-00 00:00:00"

class WalletTransactions {
  WalletTransactions({
      String? id, 
      String? userId, 
      String? type, 
      String? amount, 
      String? message, 
      String? status, 
      String? dateCreated, 
      String? lastUpdated,}){
    _id = id;
    _userId = userId;
    _type = type;
    _amount = amount;
    _message = message;
    _status = status;
    _dateCreated = dateCreated;
    _lastUpdated = lastUpdated;
}

  WalletTransactions.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _type = json['type'];
    _amount = json['amount'];
    _message = json['message'];
    _status = json['status'];
    _dateCreated = json['date_created'];
    _lastUpdated = json['last_updated'];
  }
  String? _id;
  String? _userId;
  String? _type;
  String? _amount;
  String? _message;
  String? _status;
  String? _dateCreated;
  String? _lastUpdated;
WalletTransactions copyWith({  String? id,
  String? userId,
  String? type,
  String? amount,
  String? message,
  String? status,
  String? dateCreated,
  String? lastUpdated,
}) => WalletTransactions(  id: id ?? _id,
  userId: userId ?? _userId,
  type: type ?? _type,
  amount: amount ?? _amount,
  message: message ?? _message,
  status: status ?? _status,
  dateCreated: dateCreated ?? _dateCreated,
  lastUpdated: lastUpdated ?? _lastUpdated,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get type => _type;
  String? get amount => _amount;
  String? get message => _message;
  String? get status => _status;
  String? get dateCreated => _dateCreated;
  String? get lastUpdated => _lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['amount'] = _amount;
    map['message'] = _message;
    map['status'] = _status;
    map['date_created'] = _dateCreated;
    map['last_updated'] = _lastUpdated;
    return map;
  }

}