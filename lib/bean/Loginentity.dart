class LoginResultEntity {
	LoginResultData data;
	String info;
	int statusCode;

	LoginResultEntity({this.data, this.info, this.statusCode});

	LoginResultEntity.fromJson(Map<String, dynamic> json) {
		data = json['Data'] != null ? new LoginResultData.fromJson(json['Data']) : null;
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

class LoginResultData {
	bool item1;
	String item2;

	LoginResultData({this.item1, this.item2});

	LoginResultData.fromJson(Map<String, dynamic> json) {
		item1 = json['Item1'];
		item2 = json['Item2'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Item1'] = this.item1;
		data['Item2'] = this.item2;
		return data;
	}
}
