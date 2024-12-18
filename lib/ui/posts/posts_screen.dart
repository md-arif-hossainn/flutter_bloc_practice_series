import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_count/bloc/posts/posts_event.dart';
import 'package:flutter_bloc_count/utils/enums.dart';

import '../../bloc/posts/posts_bloc.dart';
import '../../bloc/posts/posts_state.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(PostFetched());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Api'),
      ),
      body:BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch(state.postStatus){
            case PostStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PostStatus.failure:
              return Center(child: Text(state.message));
            case PostStatus.success:
              return ListView.builder(
                  itemCount: state.postList.length,
                  itemBuilder: (context,index){
                    final item = state.postList[index];
                    return ListTile(
                      title: Text(item.title.toString()),
                      subtitle: Text(item.body.toString()),
                    );
                  }
              );
          }
        },
      ),
    );
  }
}
