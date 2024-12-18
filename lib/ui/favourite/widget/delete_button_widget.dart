import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/favoruite/favourite_bloc.dart';
import '../../../bloc/favoruite/favourite_event.dart';
import '../../../bloc/favoruite/favourite_state.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteItemState>(
      buildWhen: (previous, current) =>  previous.temFavouriteItemList != current.temFavouriteItemList,
      builder: (context, state) {
        return Visibility(
            visible: state.temFavouriteItemList.isNotEmpty ?  true : false ,
            child: IconButton(onPressed: () {
              context.read<FavouriteBloc>().add(DeleteItem());
            },
                icon: const Icon(Icons.delete_outline , color: Colors.red,))
        );
      },
    );
  }
}