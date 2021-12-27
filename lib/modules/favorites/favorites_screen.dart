import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmzm/layout/cubit/cubit.dart';
import 'package:zmzm/layout/cubit/states.dart';
import 'package:zmzm/models/favorites_model.dart';
import 'package:zmzm/shared/components/components.dart';
import 'package:zmzm/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: ( context) =>ListView.separated(
              itemBuilder: (context, index) =>
                  buildFavItem(cubit.favoritesModel!.data!.favoritesData![index],context),
              separatorBuilder: (context, index) => myDivivder(),
              itemCount: cubit.favoritesModel!.data!.favoritesData!.length),
          fallback: ( context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildFavItem(FavoritesData model,context) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                 Image(
                  image: NetworkImage('${model.product!.image}'),
                  width: 120.0,
                  height: 120.0,
                ),
                 if (model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${model.product!.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16.0, color: Colors.black, height: 1.0),
                  ),
                 SizedBox(height: 15.0,),
                 // const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product!.price} LE',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.product!.discount != 0)
                      Text(
                        '${model.product!.oldPrice}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          height: 1.0,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopCubit.get(context).favorites[model.product!.id]??true ? defaultColor:Colors.grey,
                        child: IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavorite(model.product!.id);
                            },
                            icon:const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
