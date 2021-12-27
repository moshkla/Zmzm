import 'package:zmzm/models/login_model.dart';
import 'package:zmzm/models/search_model.dart';

abstract class ShopSearchStates {}

class ShopSearchInitialState extends ShopSearchStates {}

class ShopSearchLoadingState extends ShopSearchStates {}

class ShopSearchSuccessState extends ShopSearchStates {}

class ShopSearchErrorState extends ShopSearchStates {
  final String error;

  ShopSearchErrorState(this.error);
}
class ShopSearchChangePassState extends ShopSearchStates {}

