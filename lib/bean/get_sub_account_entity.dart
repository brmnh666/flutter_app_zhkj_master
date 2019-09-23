class GetSubAccountEntity {
	List<GetSubAccountData> data;
	String info;
	int statusCode;

	GetSubAccountEntity({this.data, this.info, this.statusCode});

	GetSubAccountEntity.fromJson(Map<String, dynamic> json) {
		if (json['Data'] != null) {
			data = new List<GetSubAccountData>();(json['Data'] as List).forEach((v) { data.add(new GetSubAccountData.fromJson(v)); });
		}
		info = json['Info'];
		statusCode = json['StatusCode'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['Data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['Info'] = this.info;
		data['StatusCode'] = this.statusCode;
		return data;
	}
}

class GetSubAccountData {
	String cityCode;
	int serviceTotalOrderNum;
	String address;
	String topRank;
	dynamic sex;
	dynamic lastLoginDate;
	dynamic ifAuth;
	dynamic isNew;
	String createDate;
	dynamic roleID;
	String passWord;
	double waitMoney;
	double remainMoney;
	double serviceTotalMoney;
	double depositMoney;
	String parentUserID;
	double frozenMoney;
	dynamic skills;
	String serviceStart;
	int version;
	String userID;
	dynamic phone;
	int limit;
	int conDeposit;
	String payPassWord;
	int loginCount;
	dynamic authMessage;
	dynamic trueName;
	double distance;
	String districtCode;
	int accountID;
	int con;
	dynamic iDCard;
	String isUse;
	double depositFrozenMoney;
	String dimension;
	String nickName;
	String longitude;
	String type;
	String areaCode;
	double totalMoney;
	int id;
	String provinceCode;
	int serviceComplaintNum;
	int page;
	String avator;

	GetSubAccountData({this.cityCode, this.serviceTotalOrderNum, this.address, this.topRank, this.sex, this.lastLoginDate, this.ifAuth, this.isNew, this.createDate, this.roleID, this.passWord, this.waitMoney, this.remainMoney, this.serviceTotalMoney, this.depositMoney, this.parentUserID, this.frozenMoney, this.skills, this.serviceStart, this.version, this.userID, this.phone, this.limit, this.conDeposit, this.payPassWord, this.loginCount, this.authMessage, this.trueName, this.distance, this.districtCode, this.accountID, this.con, this.iDCard, this.isUse, this.depositFrozenMoney, this.dimension, this.nickName, this.longitude, this.type, this.areaCode, this.totalMoney, this.id, this.provinceCode, this.serviceComplaintNum, this.page, this.avator});

	GetSubAccountData.fromJson(Map<String, dynamic> json) {
		cityCode = json['CityCode'];
		serviceTotalOrderNum = json['ServiceTotalOrderNum'];
		address = json['Address'];
		topRank = json['TopRank'];
		sex = json['Sex'];
		lastLoginDate = json['LastLoginDate'];
		ifAuth = json['IfAuth'];
		isNew = json['IsNew'];
		createDate = json['CreateDate'];
		roleID = json['RoleID'];
		passWord = json['PassWord'];
		waitMoney = json['WaitMoney'];
		remainMoney = json['RemainMoney'];
		serviceTotalMoney = json['ServiceTotalMoney'];
		depositMoney = json['DepositMoney'];
		parentUserID = json['ParentUserID'];
		frozenMoney = json['FrozenMoney'];
		skills = json['Skills'];
		serviceStart = json['ServiceStart'];
		version = json['Version'];
		userID = json['UserID'];
		phone = json['Phone'];
		limit = json['limit'];
		conDeposit = json['ConDeposit'];
		payPassWord = json['PayPassWord'];
		loginCount = json['LoginCount'];
		authMessage = json['AuthMessage'];
		trueName = json['TrueName'];
		distance = json['Distance'];
		districtCode = json['DistrictCode'];
		accountID = json['AccountID'];
		con = json['Con'];
		iDCard = json['IDCard'];
		isUse = json['IsUse'];
		depositFrozenMoney = json['DepositFrozenMoney'];
		dimension = json['Dimension'];
		nickName = json['NickName'];
		longitude = json['Longitude'];
		type = json['Type'];
		areaCode = json['AreaCode'];
		totalMoney = json['TotalMoney'];
		id = json['Id'];
		provinceCode = json['ProvinceCode'];
		serviceComplaintNum = json['ServiceComplaintNum'];
		page = json['page'];
		avator = json['Avator'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['CityCode'] = this.cityCode;
		data['ServiceTotalOrderNum'] = this.serviceTotalOrderNum;
		data['Address'] = this.address;
		data['TopRank'] = this.topRank;
		data['Sex'] = this.sex;
		data['LastLoginDate'] = this.lastLoginDate;
		data['IfAuth'] = this.ifAuth;
		data['IsNew'] = this.isNew;
		data['CreateDate'] = this.createDate;
		data['RoleID'] = this.roleID;
		data['PassWord'] = this.passWord;
		data['WaitMoney'] = this.waitMoney;
		data['RemainMoney'] = this.remainMoney;
		data['ServiceTotalMoney'] = this.serviceTotalMoney;
		data['DepositMoney'] = this.depositMoney;
		data['ParentUserID'] = this.parentUserID;
		data['FrozenMoney'] = this.frozenMoney;
		data['Skills'] = this.skills;
		data['ServiceStart'] = this.serviceStart;
		data['Version'] = this.version;
		data['UserID'] = this.userID;
		data['Phone'] = this.phone;
		data['limit'] = this.limit;
		data['ConDeposit'] = this.conDeposit;
		data['PayPassWord'] = this.payPassWord;
		data['LoginCount'] = this.loginCount;
		data['AuthMessage'] = this.authMessage;
		data['TrueName'] = this.trueName;
		data['Distance'] = this.distance;
		data['DistrictCode'] = this.districtCode;
		data['AccountID'] = this.accountID;
		data['Con'] = this.con;
		data['IDCard'] = this.iDCard;
		data['IsUse'] = this.isUse;
		data['DepositFrozenMoney'] = this.depositFrozenMoney;
		data['Dimension'] = this.dimension;
		data['NickName'] = this.nickName;
		data['Longitude'] = this.longitude;
		data['Type'] = this.type;
		data['AreaCode'] = this.areaCode;
		data['TotalMoney'] = this.totalMoney;
		data['Id'] = this.id;
		data['ProvinceCode'] = this.provinceCode;
		data['ServiceComplaintNum'] = this.serviceComplaintNum;
		data['page'] = this.page;
		data['Avator'] = this.avator;
		return data;
	}
}
