import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmzm/layout/cubit/cubit.dart';
import 'package:zmzm/layout/cubit/states.dart';
import 'package:zmzm/modules/login/shop_login_screen.dart';
import 'package:zmzm/modules/search/search_screen.dart';
import 'package:zmzm/shared/components/components.dart';
import 'package:zmzm/shared/cubit/cubit.dart';
import 'package:zmzm/shared/network/local/cashe_helper.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title:Text( 'ZMZM'),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, SearchScreen());
                }, icon: Icon(Icons.search)),
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (int index){
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.category),label:'category' ),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'favorite'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings'),
              ],
            ),
          );
        },

      );
  }
}
