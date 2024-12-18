import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_count/bloc/favoruite/favourite_bloc.dart';
import 'package:flutter_bloc_count/bloc/favoruite/favourite_event.dart';
import 'package:flutter_bloc_count/bloc/favoruite/favourite_state.dart';
import 'package:flutter_bloc_count/model/favourite_item_model.dart';
import 'package:flutter_bloc_count/ui/favourite/widget/delete_button_widget.dart';

class FavoriteAppScreen extends StatefulWidget {
  const FavoriteAppScreen({super.key});

  @override
  State<FavoriteAppScreen> createState() => _FavoriteAppScreenState();
}

class _FavoriteAppScreenState extends State<FavoriteAppScreen> {

  @override
  void initState() {
    super.initState();
    context.read<FavouriteBloc>().add(FetchFavouriteList());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite App'),
        actions: const [
          DeleteButtonWidget()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<FavouriteBloc,FavouriteItemState>(
            builder: (context,state){
              switch(state.listStatus){
                case ListStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case ListStatus.failure:
                  return const Text('Something went to wrong');

                case ListStatus.success:
                  return ListView.builder(
                      itemCount: state.favouriteItemList.length,
                      itemBuilder: (context,index){
                        final item = state.favouriteItemList[index];
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                                value: state.temFavouriteItemList.contains(item) ? true : false,
                                onChanged: (value){
                                  if (value!) {
                                    context.read<FavouriteBloc>().add(SelectItem(item: item));
                                  } else {
                                    context.read<FavouriteBloc>().add(UnSelectItem(item: item));
                                  }
                            }),
                            title: Text(item.value.toString()),
                            trailing: IconButton(
                                onPressed: (){
                                  FavouriteItemModel itemModel = FavouriteItemModel(
                                      id: item.id,
                                      value: item.value,
                                      isFavourite: item.isFavourite ? false : true
                                  );
                                  context.read<FavouriteBloc>().add(FavoriteItem(item: itemModel));
                                },
                                icon: Icon(
                                  item.isFavourite ? Icons.favorite : Icons.favorite_outline
                                )
                            ),
                          ),

                        );
                      }
                  );
              }

            }
        ),
      ),
    );
  }
}
