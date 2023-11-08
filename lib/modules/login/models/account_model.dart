import 'package:hive/hive.dart';

import '../../../hive_helper/fields/account_model_fields.dart';
import '../../../hive_helper/hive_adapters.dart';
import '../../../hive_helper/hive_types.dart';


part 'account_model.g.dart';


@HiveType(typeId: HiveTypes.accountModel, adapterName: HiveAdapters.accountModel)
class AccountModel extends HiveObject{
  AccountModel({
    required this.auth,
    required this.latitude,
    required this.longitude,
    required this.nameAccout,
    required this.numberPhone,
    required this.uid,
    required this.email,
    required this.address,
    required this.imgUser,
    required this.token
  });

	@HiveField(AccountModelFields.auth)
  int? auth;
	@HiveField(AccountModelFields.latitude)
  double? latitude;
	@HiveField(AccountModelFields.longitude)
  double? longitude;
	@HiveField(AccountModelFields.nameAccout)
  String? nameAccout;
	@HiveField(AccountModelFields.numberPhone)
  String? numberPhone;
	@HiveField(AccountModelFields.uid)
  String? uid;
	@HiveField(AccountModelFields.email)
  String email;
	@HiveField(AccountModelFields.address)
  String address;
	@HiveField(AccountModelFields.imgUser)
  String imgUser;
  @HiveField(AccountModelFields.imgUser)
  String? token;

  factory AccountModel.fromJson(Map<String, dynamic> json){
    return AccountModel(
      auth: json["Auth"],
      latitude: json["Latitude"],
      longitude: json["Longitude"],
      nameAccout: json["NameAccout"],
      numberPhone: json["NumberPhone"],
      uid: json["UID"],
      email: json["Email"],
      address: json["Address"],
      imgUser: json["ImgAcc"],
      token: json["Token"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Auth": auth,
      "Latitude": latitude,
      "Longitude": longitude,
      "NameAccout": nameAccout,
      "NumberPhone": numberPhone,
      "UID": uid,
      "Email": email,
      "Address": address,
      "ImgAcc": imgUser,
      "Token": token,
    };
  }


}