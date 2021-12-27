import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmzm/models/login_model.dart';
import 'package:zmzm/modules/register/cubit/states.dart';
import 'package:zmzm/shared/network/end_points.dart';
import 'package:zmzm/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister( {
    required String? email,
    required String? password,
    required String? name,
    required String? phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data:
    {
     'email':'$email',
      'password':'$password',
      'name':'$name',
      'phone':'$phone',
    }).then((value) {
      loginModel =ShopLoginModel.formJson(value.data);
      print(loginModel!.data?.token);
      emit(ShopRegisterSuccessState(loginModel!));

      print(value.data);


    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
      print(error.toString());

    });
  }
}