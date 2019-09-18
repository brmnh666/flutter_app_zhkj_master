class UserInfo extends Object{
  String UserName;

  UserInfo({this.UserName});

  UserInfo.fromJson(Map<String, dynamic> json) {
    UserName = json['UserName'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic> ();
    data['UserName'] = this.UserName;
    return data;
  }
}