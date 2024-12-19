

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_count/bloc/posts/posts_event.dart';
import 'package:flutter_bloc_count/bloc/posts/posts_state.dart';
import 'package:flutter_bloc_count/model/post_model.dart';
import 'package:flutter_bloc_count/utils/enums.dart';

import '../../repository/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  PostRepository postRepository = PostRepository();

  List<PostModel> temPostList = [];

  PostBloc() : super( const PostState()) {
    on<PostFetched>(fetchPostApi);
    on<SearchItem>(_filterList);
  }

  Future<void> fetchPostApi(PostFetched event, Emitter<PostState> emit) async {
    await postRepository.fetchPost().then((value) {
      emit(state.copyWith(postStatus: PostStatus.success, postsList: value, message: 'success'));
    }).onError((error, stackTrace) {
      emit(state.copyWith(postStatus: PostStatus.failure, message: error.toString()));
    });
  }


  Future<void> _filterList(SearchItem event, Emitter<PostState> emit) async {
    if(event.stSearch.isEmpty){
      emit(state.copyWith(tempPostList: [],searchMessage: ''));
    }else{
     // temPostList = state.postList.where((element) => element.id.toString() == event.stSearch.toString()).toList();
      temPostList = state.postList.where((element) => element.email.toString().toLowerCase().contains(event.stSearch.toLowerCase())).toList();
      print('length--${temPostList.length}');
      //search something you write but that's not exist
      if(temPostList.isEmpty){
        emit(state.copyWith(tempPostList: temPostList,searchMessage: 'No Data found !'));
      }else{
        emit(state.copyWith(tempPostList: temPostList,searchMessage: ''));
      }
    }
  }

}
