class GetMessageResponseEntity {
	GetMessageResponseData data;
	String info;
	int statusCode;

	GetMessageResponseEntity({this.data, this.info, this.statusCode});

	GetMessageResponseEntity.fromJson(Map<String, dynamic> json) {
		data = json['Data'] != null ? new GetMessageResponseData.fromJson(json['Data']) : null;
		info = json['Info'];
		statusCode = json['StatusCode'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
		data['Info'] = this.info;
		data['StatusCode'] = this.statusCode;
		return data;
	}
}

class GetMessageResponseData {
	String msg;
	String code;
	List<GetMessageResponseDataData> data;
	String count;

	GetMessageResponseData({this.msg, this.code, this.data, this.count});

	GetMessageResponseData.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<GetMessageResponseDataData>();(json['data'] as List).forEach((v) { data.add(new GetMessageResponseDataData.fromJson(v)); });
		}
		count = json['count'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['count'] = this.count;
		return data;
	}
}

class GetMessageResponseDataData {
	int subType;
	String isLook;
	String isUse;
	int orderID;
	String nowtime;
	int type;
	int version;
	String userID;
	String content;
	int limit;
	int id;
	int page;
	int messageID;

	GetMessageResponseDataData({this.subType, this.isLook, this.isUse, this.orderID, this.nowtime, this.type, this.version, this.userID, this.content, this.limit, this.id, this.page, this.messageID});

	GetMessageResponseDataData.fromJson(Map<String, dynamic> json) {
		subType = json['SubType'];
		isLook = json['IsLook'];
		isUse = json['IsUse'];
		orderID = json['OrderID'];
		nowtime = json['Nowtime'];
		type = json['Type'];
		version = json['Version'];
		userID = json['UserID'];
		content = json['Content'];
		limit = json['limit'];
		id = json['Id'];
		page = json['page'];
		messageID = json['MessageID'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['SubType'] = this.subType;
		data['IsLook'] = this.isLook;
		data['IsUse'] = this.isUse;
		data['OrderID'] = this.orderID;
		data['Nowtime'] = this.nowtime;
		data['Type'] = this.type;
		data['Version'] = this.version;
		data['UserID'] = this.userID;
		data['Content'] = this.content;
		data['limit'] = this.limit;
		data['Id'] = this.id;
		data['page'] = this.page;
		data['MessageID'] = this.messageID;
		return data;
	}
}
