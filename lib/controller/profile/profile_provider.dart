import 'package:ecommerce/controller/bottom_nav/bottom_nav_provider.dart';
import 'package:ecommerce/controller/sign_in/sign_in_provider.dart';
import 'package:ecommerce/model/user_%20model/user_mode.dart';
import 'package:ecommerce/services/account_service/account_service.dart';
import 'package:ecommerce/services/user_service/user_service.dart';
import 'package:ecommerce/view/sign_in/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  final SignInProvider signInProvider = SignInProvider();
  bool loading = false;
  bool isLoading = false;
  UserModel? userDetials;

  void getUser() async {
    isLoading = true;
    notifyListeners();
    final email = await storage.read(key: 'email');
    await UserProfileService().getUserDetials(email.toString()).then((value) {
      if (value != null) {
        isLoading = false;
        notifyListeners();
        userDetials = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void logOut(context) async {
    loading = true;
    notifyListeners();
    await AccountService().logOutUser(context).then((value) async {
      if (value != null) {
        await storage.delete(key: 'token');
        await storage.delete(key: 'refreshToken');
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const SignInScreen(),
          ),
          (route) => false,
        );
        notifyListeners();
        Provider.of<BottomNavProvider>(context, listen: false).currentIndex = 0;

        loading = false;
        notifyListeners();
      } else {
        loading = false;
        notifyListeners();
      }
    });
  }
}
