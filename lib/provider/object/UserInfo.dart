class UserInfo extends Object{
  String UserName;
  String UserID;
  String NickName;
  String Avator;
  String RemainMoney;
  String TotalMoney;
  String FrozenMoney;
  String Con;
  String IfAuth;
  String TrueName;
  String IDCard;
  String Sex;
  String Phone;

  UserInfo(
  {this.UserName,
  this.UserID,
  this.NickName,
  this.Avator,
  this.RemainMoney,
  this.TotalMoney,
  this.FrozenMoney,
  this.Con,
  this.IfAuth,
  this.TrueName,
  this.IDCard,
  this.Sex,
  this.Phone
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    UserName = json['UserName'];
    UserID = json['UserID'];
    NickName = json['NickName'];
    Avator = json['Avator'];
    RemainMoney = json['RemainMoney'];
    TotalMoney = json['TotalMoney'];
    FrozenMoney = json['FrozenMoney'];
    Con = json['Con'];
    IfAuth = json['IfAuth'];
    TrueName = json['TrueName'];
    IDCard = json['IDCard'];
    Sex = json['Sex'];
    Phone = json['Phone'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic> ();
    data['UserName'] = this.UserName;
    data['UserID'] = this.UserID;
    data['NickName'] = this.NickName;
    data['Avator'] = this.Avator;
    data['RemainMoney'] = this.RemainMoney;
    data['TotalMoney'] = this.TotalMoney;
    data['FrozenMoney'] = this.FrozenMoney;
    data['Con'] = this.Con;
    data['IfAuth'] = this.IfAuth;
    data['TrueName'] = this.TrueName;
    data['IDCard'] = this.IDCard;
    data['Sex'] = this.Sex;
    data['Phone'] = this.Phone;
    return data;
  }
}