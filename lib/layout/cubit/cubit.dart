import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmzm/layout/cubit/states.dart';
import 'package:zmzm/models/categories_model.dart';
import 'package:zmzm/models/change_favorites_model.dart';
import 'package:zmzm/models/favorites_model.dart';
import 'package:zmzm/models/home_model.dart';
import 'package:zmzm/models/login_model.dart';
import 'package:zmzm/modules/categories/categories_screen.dart';
import 'package:zmzm/modules/favorites/favorites_screen.dart';
import 'package:zmzm/modules/products/products_screen.dart';
import 'package:zmzm/modules/settings/settings_screen.dart';
import 'package:zmzm/shared/components/constants.dart';
import 'package:zmzm/shared/network/end_points.dart';
import 'package:zmzm/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?, bool?> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.in_favorites,
        });
      });
      print(favorites.toString());

      emit(ShopSuccessHomeState());
    }).catchError((error) {
      print("الايرور هنا ي لطخ" + error.toString());
      emit(ShopErrorHomeState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(token);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
      print("الايرور هنا ي لطخ" + error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoriteModel;

  void changeFavorite(int? product_id) {
    favorites[product_id] = !(favorites[product_id] ?? false);

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': product_id},
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoritesModel.fromjson(value.data);
      if (changeFavoriteModel!.status == false) {
        favorites[product_id] = !(favorites[product_id] ?? false);
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessFavoritesState(changeFavoriteModel!));
      print(value.data);
    }).catchError((error) {
      if (favorites[product_id] == true) {
        favorites[product_id] = false;
      } else {
        favorites[product_id] = true;
      }
      print("الايرور هنا ي لطخ" + error.toString());
      emit(ShopErrorFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: GET_FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(GET_FAVORITES);
      print(token);

      print(value.statusCode);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
      print("الايرور هنا ي لطخ وانت بتجيب الداتا المفضلة" + error.toString());
    });
  }

  ShopLoginModel? userDataModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userDataModel = ShopLoginModel.formJson(value.data);
      print({userDataModel!.data!.name}.toString());
      print(token);

      print(value.statusCode);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      emit(ShopErrorGetUserDataState());
      print("الايرور هنا ي لطخ وانت بتجيب البروفايل" + error.toString());
    });
  }

  void updateUserData({
    required String? name,
    required String? email,
    required String? phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userDataModel = ShopLoginModel.formJson(value.data);
      print({userDataModel!.data!.name}.toString());
      print(token);

      print(value.statusCode);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      emit(ShopErrorGetUserDataState());
      print("الايرور هنا ي لطخ وانت بتجيب البروفايل" + error.toString());
    });
  }
}
