import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmzm/models/search_model.dart';
import 'package:zmzm/modules/search/cubit/states.dart';

import 'package:zmzm/shared/network/end_points.dart';
import 'package:zmzm/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<ShopSearchStates> {
  SearchCubit() : super(ShopSearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void getSearchData({
    required String? text,
  }) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        data: {'text' :text}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
      print(value.data);
    }).catchError((error) {
      emit(ShopSearchErrorState(error.toString()));
      print(error.toString());
    });
  }


}