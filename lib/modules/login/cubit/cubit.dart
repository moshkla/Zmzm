import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmzm/models/login_model.dart';
import 'package:zmzm/modules/login/cubit/states.dart';
import 'package:zmzm/shared/network/end_points.dart';
import 'package:zmzm/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userLogin({
    required String? email,
    required String? password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {'email': '$email', 'password': '$password'}).then((value) {
      loginModel = ShopLoginModel.formJson(value.data);
      print(loginModel!.data?.token);
      emit(ShopLoginSuccessState(loginModel!));

      print(value.data);
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  bool isSecurePass = true;

  bool changePassShow() {
    emit(ShopLoginChangePassState());
    return isSecurePass = !isSecurePass;
  }
}