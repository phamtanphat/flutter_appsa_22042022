/// email : "demo2204@gmail.com"
/// name : "phat"
/// phone : "12345678910"
/// userGroup : 0
/// registerDate : "2022-06-13T13:59:59.061Z"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjI0MzI5MDAwNDUsImRhdGEiOnsiX2lkIjoiNjJhNzQyZGZlZGJlZTY3ZWJmNTNmOGVjIiwiZW1haWwiOiJkZW1vMjIwNEBnbWFpbC5jb20iLCJwYXNzd29yZCI6IiQyYiQxMCRDN1dDNno2SXhxM2RpSzRQLnZ3ZE5PMHFNMnVNaS5ib2NzZFc4MXhWVElXckVVNExmU1BZNiIsIm5hbWUiOiJwaGF0IiwicGhvbmUiOiIxMjM0NTY3ODkxMCIsInVzZXJHcm91cCI6MCwicmVnaXN0ZXJEYXRlIjoiMjAyMi0wNi0xM1QxMzo1OTo1OS4wNjFaIiwiX192IjowfSwiaWF0IjoxNjU1MzAwMDQ1fQ.5r-Ss3Yw3yNz2fvl0Y1QayvcH3aO0CM0NxAW7sWIeTs"

class UserResponse {
  UserResponse({
      String? email, 
      String? name, 
      String? phone, 
      int? userGroup, 
      String? registerDate, 
      String? token,}){
    _email = email;
    _name = name;
    _phone = phone;
    _userGroup = userGroup;
    _registerDate = registerDate;
    _token = token;
}

  UserResponse.fromJson(dynamic json) {
    _email = json['email'];
    _name = json['name'];
    _phone = json['phone'];
    _userGroup = json['userGroup'];
    _registerDate = json['registerDate'];
    _token = json['token'];
  }
  String? _email;
  String? _name;
  String? _phone;
  int? _userGroup;
  String? _registerDate;
  String? _token;

  String? get email => _email;
  String? get name => _name;
  String? get phone => _phone;
  int? get userGroup => _userGroup;
  String? get registerDate => _registerDate;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['name'] = _name;
    map['phone'] = _phone;
    map['userGroup'] = _userGroup;
    map['registerDate'] = _registerDate;
    map['token'] = _token;
    return map;
  }


  @override
  String toString() {
    return 'UserResponse{_email: $_email, _name: $_name, _phone: $_phone, _userGroup: $_userGroup, _registerDate: $_registerDate, _token: $_token}';
  }

  static UserResponse parseJson(Map<String, dynamic> json) => UserResponse.fromJson(json);
}