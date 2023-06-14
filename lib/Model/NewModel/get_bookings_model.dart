/// error : false
/// message : "Booking Lists Successfully!"
/// data : [{"table_name":"High Top Table","restaurant_owner_name":"Shiva","id":"5","unique_id":"1234","res_id":"76","table_type":"1","approx_amount":"700","status":"2","created_at":"2023-04-28 12:24:05","booking_date":"2023-04-28","booking_time":"20:30:00","update_at":"2023-04-28 12:24:05","booking_status":"Accepted","users":[{"id":"3","booking_id":"5","user_id":"65","amount":"100","payment_status":"1","created_at":"2023-04-26 12:51:09","update_at":"2023-04-26 12:51:09","detail":{"username":"Sonam","mobile":"9876543213","gender":"female"}},{"id":"4","booking_id":"5","user_id":"66","amount":"100","payment_status":"1","created_at":"2023-04-26 12:58:16","update_at":"2023-04-26 12:58:16","detail":{"username":"Shiva","mobile":"9104698126","gender":"male"}}]},{"table_name":"Sofas & Coffee Table","restaurant_owner_name":"Shiva","id":"7","unique_id":"12345","res_id":"76","table_type":"2","approx_amount":"100","status":"1","created_at":"2023-04-28 12:16:45","booking_date":"2023-04-28","booking_time":"20:30:00","update_at":"2023-04-28 12:16:45","booking_status":"Processed","users":[{"id":"5","booking_id":"7","user_id":"69","amount":"100","payment_status":"1","created_at":"2023-04-28 12:01:16","update_at":"2023-04-28 12:01:16","detail":{"username":"Anjli","mobile":"788855588","gender":"female"}},{"id":"6","booking_id":"7","user_id":"68","amount":"100","payment_status":"1","created_at":"2023-04-28 12:01:16","update_at":"2023-04-28 12:01:16","detail":{"username":"Harish","mobile":"7899555588","gender":"male"}}]},{"table_name":"High Top Table","restaurant_owner_name":"Shiva","id":"8","unique_id":"12349","res_id":"76","table_type":"1","approx_amount":"700","status":"1","created_at":"2023-04-28 12:16:37","booking_date":"2023-04-28","booking_time":"20:30:00","update_at":"2023-04-28 12:16:37","booking_status":"Processed","users":[{"id":"7","booking_id":"8","user_id":"91","amount":"100","payment_status":"1","created_at":"2023-04-28 12:03:25","update_at":"2023-04-28 12:03:25","detail":{"username":"Rahul R","mobile":"9875641235","gender":"male"}},{"id":"8","booking_id":"8","user_id":"92","amount":"100","payment_status":"1","created_at":"2023-04-28 12:03:25","update_at":"2023-04-28 12:03:25","detail":{"username":"Rashmi","mobile":"654654656","gender":"female"}}]},{"table_name":"High Top Table","restaurant_owner_name":"Shiva","id":"9","unique_id":"3655","res_id":"76","table_type":"1","approx_amount":"700","status":"1","created_at":"2023-04-28 12:16:17","booking_date":"2023-04-28","booking_time":"20:30:00","update_at":"2023-04-28 12:16:17","booking_status":"Processed","users":[{"id":"9","booking_id":"9","user_id":"88","amount":"100","payment_status":"1","created_at":"2023-04-28 12:13:30","update_at":"2023-04-28 12:13:30","detail":{"username":"Devesh","mobile":"7899666632","gender":"male"}},{"id":"10","booking_id":"9","user_id":"89","amount":"100","payment_status":"1","created_at":"2023-04-28 12:13:30","update_at":"2023-04-28 12:13:30","detail":{"username":"Mohini","mobile":"6633002255","gender":"female"}}]},{"table_name":"Sofas & Coffee Table","restaurant_owner_name":"Shiva","id":"10","unique_id":"8996","res_id":"76","table_type":"2","approx_amount":"100","status":"0","created_at":"2023-04-28 12:11:03","booking_date":"2023-04-28","booking_time":"20:30:00","update_at":"2023-04-28 12:11:03","booking_status":"Waiting","users":[{"id":"11","booking_id":"10","user_id":"93","amount":"100","payment_status":"1","created_at":"2023-04-28 12:18:57","update_at":"2023-04-28 12:18:57","detail":{"username":"Nandni","mobile":"7855558848","gender":"female"}},{"id":"12","booking_id":"10","user_id":"94","amount":"100","payment_status":"1","created_at":"2023-04-28 12:18:57","update_at":"2023-04-28 12:18:57","detail":{"username":"Atul","mobile":"7888554477","gender":"male"}}]}]

class GetBookingsModel {
  GetBookingsModel({
      bool? error, 
      String? message, 
      List<Bookings>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetBookingsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Bookings.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Bookings>? _data;
GetBookingsModel copyWith({  bool? error,
  String? message,
  List<Bookings>? data,
}) => GetBookingsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Bookings>? get data => _data;

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

/// table_name : "High Top Table"
/// restaurant_owner_name : "Shiva"
/// id : "5"
/// unique_id : "1234"
/// res_id : "76"
/// table_type : "1"
/// approx_amount : "700"
/// status : "2"
/// created_at : "2023-04-28 12:24:05"
/// booking_date : "2023-04-28"
/// booking_time : "20:30:00"
/// update_at : "2023-04-28 12:24:05"
/// booking_status : "Accepted"
/// users : [{"id":"3","booking_id":"5","user_id":"65","amount":"100","payment_status":"1","created_at":"2023-04-26 12:51:09","update_at":"2023-04-26 12:51:09","detail":{"username":"Sonam","mobile":"9876543213","gender":"female"}},{"id":"4","booking_id":"5","user_id":"66","amount":"100","payment_status":"1","created_at":"2023-04-26 12:58:16","update_at":"2023-04-26 12:58:16","detail":{"username":"Shiva","mobile":"9104698126","gender":"male"}}]

class Bookings {
  Bookings({
      String? tableName, 
      String? restaurantOwnerName, 
      String? id, 
      String? uniqueId, 
      String? resId, 
      String? tableType, 
      String? approxAmount, 
      String? status, 
      String? createdAt, 
      String? bookingDate, 
      String? bookingTime, 
      String? updateAt, 
      String? bookingStatus, 
      List<Users>? users,}){
    _tableName = tableName;
    _restaurantOwnerName = restaurantOwnerName;
    _id = id;
    _uniqueId = uniqueId;
    _resId = resId;
    _tableType = tableType;
    _approxAmount = approxAmount;
    _status = status;
    _createdAt = createdAt;
    _bookingDate = bookingDate;
    _bookingTime = bookingTime;
    _updateAt = updateAt;
    _bookingStatus = bookingStatus;
    _users = users;
}

  Bookings.fromJson(dynamic json) {
    _tableName = json['table_name'];
    _restaurantOwnerName = json['restaurant_owner_name'];
    _id = json['id'];
    _uniqueId = json['unique_id'];
    _resId = json['res_id'];
    _tableType = json['table_type'];
    _approxAmount = json['approx_amount'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _bookingDate = json['booking_date'];
    _bookingTime = json['booking_time'];
    _updateAt = json['update_at'];
    _bookingStatus = json['booking_status'];
    if (json['users'] != null) {
      _users = [];
      json['users'].forEach((v) {
        _users?.add(Users.fromJson(v));
      });
    }
  }
  String? _tableName;
  String? _restaurantOwnerName;
  String? _id;
  String? _uniqueId;
  String? _resId;
  String? _tableType;
  String? _approxAmount;
  String? _status;
  String? _createdAt;
  String? _bookingDate;
  String? _bookingTime;
  String? _updateAt;
  String? _bookingStatus;
  List<Users>? _users;
Bookings copyWith({  String? tableName,
  String? restaurantOwnerName,
  String? id,
  String? uniqueId,
  String? resId,
  String? tableType,
  String? approxAmount,
  String? status,
  String? createdAt,
  String? bookingDate,
  String? bookingTime,
  String? updateAt,
  String? bookingStatus,
  List<Users>? users,
}) => Bookings(  tableName: tableName ?? _tableName,
  restaurantOwnerName: restaurantOwnerName ?? _restaurantOwnerName,
  id: id ?? _id,
  uniqueId: uniqueId ?? _uniqueId,
  resId: resId ?? _resId,
  tableType: tableType ?? _tableType,
  approxAmount: approxAmount ?? _approxAmount,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  bookingDate: bookingDate ?? _bookingDate,
  bookingTime: bookingTime ?? _bookingTime,
  updateAt: updateAt ?? _updateAt,
  bookingStatus: bookingStatus ?? _bookingStatus,
  users: users ?? _users,
);
  String? get tableName => _tableName;
  String? get restaurantOwnerName => _restaurantOwnerName;
  String? get id => _id;
  String? get uniqueId => _uniqueId;
  String? get resId => _resId;
  String? get tableType => _tableType;
  String? get approxAmount => _approxAmount;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get bookingDate => _bookingDate;
  String? get bookingTime => _bookingTime;
  String? get updateAt => _updateAt;
  String? get bookingStatus => _bookingStatus;
  List<Users>? get users => _users;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['table_name'] = _tableName;
    map['restaurant_owner_name'] = _restaurantOwnerName;
    map['id'] = _id;
    map['unique_id'] = _uniqueId;
    map['res_id'] = _resId;
    map['table_type'] = _tableType;
    map['approx_amount'] = _approxAmount;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['booking_date'] = _bookingDate;
    map['booking_time'] = _bookingTime;
    map['update_at'] = _updateAt;
    map['booking_status'] = _bookingStatus;
    if (_users != null) {
      map['users'] = _users?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3"
/// booking_id : "5"
/// user_id : "65"
/// amount : "100"
/// payment_status : "1"
/// created_at : "2023-04-26 12:51:09"
/// update_at : "2023-04-26 12:51:09"
/// detail : {"username":"Sonam","mobile":"9876543213","gender":"female"}

class Users {
  Users({
      String? id, 
      String? bookingId, 
      String? userId, 
      String? amount, 
      String? paymentStatus, 
      String? createdAt, 
      String? updateAt, 
      Detail? detail,}){
    _id = id;
    _bookingId = bookingId;
    _userId = userId;
    _amount = amount;
    _paymentStatus = paymentStatus;
    _createdAt = createdAt;
    _updateAt = updateAt;
    _detail = detail;
}

  Users.fromJson(dynamic json) {
    _id = json['id'];
    _bookingId = json['booking_id'];
    _userId = json['user_id'];
    _amount = json['amount'];
    _paymentStatus = json['payment_status'];
    _createdAt = json['created_at'];
    _updateAt = json['update_at'];
    _detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
  }
  String? _id;
  String? _bookingId;
  String? _userId;
  String? _amount;
  String? _paymentStatus;
  String? _createdAt;
  String? _updateAt;
  Detail? _detail;
Users copyWith({  String? id,
  String? bookingId,
  String? userId,
  String? amount,
  String? paymentStatus,
  String? createdAt,
  String? updateAt,
  Detail? detail,
}) => Users(  id: id ?? _id,
  bookingId: bookingId ?? _bookingId,
  userId: userId ?? _userId,
  amount: amount ?? _amount,
  paymentStatus: paymentStatus ?? _paymentStatus,
  createdAt: createdAt ?? _createdAt,
  updateAt: updateAt ?? _updateAt,
  detail: detail ?? _detail,
);
  String? get id => _id;
  String? get bookingId => _bookingId;
  String? get userId => _userId;
  String? get amount => _amount;
  String? get paymentStatus => _paymentStatus;
  String? get createdAt => _createdAt;
  String? get updateAt => _updateAt;
  Detail? get detail => _detail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['booking_id'] = _bookingId;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['payment_status'] = _paymentStatus;
    map['created_at'] = _createdAt;
    map['update_at'] = _updateAt;
    if (_detail != null) {
      map['detail'] = _detail?.toJson();
    }
    return map;
  }

}

/// username : "Sonam"
/// mobile : "9876543213"
/// gender : "female"

class Detail {
  Detail({
      String? username, 
      String? mobile, 
      String? gender,}){
    _username = username;
    _mobile = mobile;
    _gender = gender;
}

  Detail.fromJson(dynamic json) {
    _username = json['username'];
    _mobile = json['mobile'];
    _gender = json['gender'];
  }
  String? _username;
  String? _mobile;
  String? _gender;
Detail copyWith({  String? username,
  String? mobile,
  String? gender,
}) => Detail(  username: username ?? _username,
  mobile: mobile ?? _mobile,
  gender: gender ?? _gender,
);
  String? get username => _username;
  String? get mobile => _mobile;
  String? get gender => _gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['mobile'] = _mobile;
    map['gender'] = _gender;
    return map;
  }

}