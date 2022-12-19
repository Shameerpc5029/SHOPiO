
import 'package:ecommerce/model/otp_model/otp_enum.dart';
import 'package:ecommerce/model/sign_up_model/sign_up_model.dart';

class OtpArgumentModel {
  final SignUpModel model;
  final OtpEnum checkScreen;

  OtpArgumentModel({
    required this.model,
    required this.checkScreen,
  });
}
