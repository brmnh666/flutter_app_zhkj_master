class GetNotifucationResponseEntity {
	GetNotifucationResponseData data;
	String info;
	int statusCode;

	GetNotifucationResponseEntity({this.data, this.info, this.statusCode});

	GetNotifucationResponseEntity.fromJson(Map<String, dynamic> json) {
		data = json['Data'] != null ? new GetNotifucationResponseData.fromJson(json['Data']) : null;
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

class GetNotifucationResponseData {
	String msg;
	String code;
	List<GetNotifucationResponseDataData> data;
	String count;

	GetNotifucationResponseData({this.msg, this.code, this.data, this.count});

	GetNotifucationResponseData.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<GetNotifucationResponseDataData>();(json['data'] as List).forEach((v) { data.add(new GetNotifucationResponseDataData.fromJson(v)); });
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

class GetNotifucationResponseDataData {
	int categoryID;
	String isUse;
	String createTime;
	String title;
	dynamic source;
	String url;
	int version;
	dynamic content;
	int categoryContentID;
	int limit;
	String author;
	int id;
	int page;
	int parentCategoryID;

	GetNotifucationResponseDataData({this.categoryID, this.isUse, this.createTime, this.title, this.source, this.url, this.version, this.content, this.categoryContentID, this.limit, this.author, this.id, this.page, this.parentCategoryID});

	GetNotifucationResponseDataData.fromJson(Map<String, dynamic> json) {
		categoryID = json['CategoryID'];
		isUse = json['IsUse'];
		createTime = json['CreateTime'];
		title = json['Title'];
		source = json['Source'];
		url = json['Url'];
		version = json['Version'];
		content = json['Content'];
		categoryContentID = json['CategoryContentID'];
		limit = json['limit'];
		author = json['Author'];
		id = json['Id'];
		page = json['page'];
		parentCategoryID = json['ParentCategoryID'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['CategoryID'] = this.categoryID;
		data['IsUse'] = this.isUse;
		data['CreateTime'] = this.createTime;
		data['Title'] = this.title;
		data['Source'] = this.source;
		data['Url'] = this.url;
		data['Version'] = this.version;
		data['Content'] = this.content;
		data['CategoryContentID'] = this.categoryContentID;
		data['limit'] = this.limit;
		data['Author'] = this.author;
		data['Id'] = this.id;
		data['page'] = this.page;
		data['ParentCategoryID'] = this.parentCategoryID;
		return data;
	}
}
