import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmzm/layout/cubit/cubit.dart';
import 'package:zmzm/models/search_model.dart';
import 'package:zmzm/modules/search/cubit/cubit.dart';
import 'package:zmzm/modules/search/cubit/states.dart';
import 'package:zmzm/shared/components/components.dart';
import 'package:zmzm/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                toolbarHeight: 60,
                title: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    children: [
                      Container(
                        height: 35,
                        width: 250,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: searchController,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'What are you looking for ?',
                            hintStyle: TextStyle(fontSize: 15),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                          ),
                          onChanged: (value) {
                            cubit.getSearchData(text: value);
                          },
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'CANCEL',
                            style: TextStyle(color: Colors.blue),
                          )),
                    ],
                  ),
                ),
              ),
              body: state is ShopSearchLoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : cubit.searchModel != null
                      ? searchController.text.isEmpty
                          ? Container()
                          : ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  buildFavItem(
                                      cubit.searchModel?.data!
                                          .productData![index],
                                      context),
                              separatorBuilder: (context, index) =>
                                  myDivivder(),
                              itemCount: cubit
                                      .searchModel?.data!.productData!.length ??
                                  0,
                            )
                      : Container());
        },
      ),
    );
  }
  Widget buildFavItem(Product? model,context) => Padding(
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
                image: NetworkImage('${model!.image}'),
                width: 120.0,
                height: 120.0,
              ),
              if (model.oldPrice != null)
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
                  '${model.name}',
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
                      '${model.price} LE',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != null)
                      Text(
                        '${model.oldPrice}',
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
                      backgroundColor: ShopCubit.get(context).favorites[model.id]??true ? defaultColor:Colors.grey,
                      child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorite(model.id);
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

  // Widget searchItemBuilder(Product? model, context) {
  //   return Container(
  //     height: 120,
  //     padding: const EdgeInsets.all(10),
  //     child: Row(
  //       children: [
  //         Image(
  //           image: NetworkImage('${model!.image}'),
  //           width: 100,
  //           height: 100,
  //         ),
  //         const SizedBox(
  //           width: 10,
  //         ),
  //         Expanded(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 '${model.name}',
  //                 style: TextStyle(
  //                   fontSize: 15,
  //                 ),
  //                 maxLines: 3,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //               Spacer(),
  //               Text(
  //                 'EGP ' + '${model.price}',
  //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
