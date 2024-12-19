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
              return Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Search with email',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (filterKey){
                      context.read<PostBloc>().add(SearchItem(filterKey));
                    },
                  ),
                  Expanded(
                    child: state.searchMessage.isNotEmpty ?
                        Center(child: Text(state.searchMessage.toString())) :
                    ListView.builder(
                        itemCount: state.tempPostList.isEmpty ? state.postList.length : state.tempPostList.length,
                        itemBuilder: (context,index){

                          if (state.tempPostList.isNotEmpty) {
                            final item = state.tempPostList[index];
                            return Card(
                              child: ListTile(
                                title: Text(item.email.toString()),
                                subtitle: Text(item.body.toString()),
                              ),
                            );
                          }else{
                            final item = state.postList[index];
                            return Card(
                              child: ListTile(
                                title: Text(item.email.toString()),
                                subtitle: Text(item.body.toString()),
                              ),
                            );
                          }
                        }
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
