import 'package:hive/hive.dart';

import '../../../hive_helper/fields/fixer_account_model_fields.dart';
import '../../../hive_helper/hive_adapters.dart';
import '../../../hive_helper/hive_types.dart';


part 'fixer_account_model.g.dart';


@HiveType(typeId: HiveTypes.fixerAccountModel, adapterName: HiveAdapters.fixerAccountModel)
class FixerAccountModel extends HiveObject{
  FixerAccountModel({
    required this.address,
    required this.age,
    required this.email,
    required this.imgAcc,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.numberPhone,
    required this.status,
    required this.uid,
  });

	@HiveField(FixerAccountModelFields.address)
  final String? address;
	@HiveField(FixerAccountModelFields.age)
  final int? age;
	@HiveField(FixerAccountModelFields.email)
  final String? email;
	@HiveField(FixerAccountModelFields.imgAcc)
  final String? imgAcc;
	@HiveField(FixerAccountModelFields.latitude)
  final double? latitude;
	@HiveField(FixerAccountModelFields.longitude)
  final double? longitude;
	@HiveField(FixerAccountModelFields.name)
  final String? name;
	@HiveField(FixerAccountModelFields.numberPhone)
  final String? numberPhone;
	@HiveField(FixerAccountModelFields.status)
  final bool? status;
	@HiveField(FixerAccountModelFields.uid)
  final String? uid;

  factory FixerAccountModel.fromJson(Map<String, dynamic> json){
    return FixerAccountModel(
      address: json["Address"],
      age: json["Age"],
      email: json["Email"],
      imgAcc: json["ImgAcc"],
      latitude: json["Latitude"],
      longitude: json["Longitude"],
      name: json["Name"],
      numberPhone: json["NumberPhone"],
      status: json["Status"],
      uid: json["UID"],
    );
  }

}