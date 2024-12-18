

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_count/bloc/posts/posts_event.dart';
import 'package:flutter_bloc_count/bloc/posts/posts_state.dart';
import 'package:flutter_bloc_count/utils/enums.dart';

import '../../repository/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository = PostRepository();

  PostBloc() : super( const PostState()) {
    on<PostFetched>(fetchPostApi);
  }

  Future<void> fetchPostApi(PostFetched event, Emitter<PostState> emit) async {
    await postRepository.fetchPost().then((value) {
      emit(state.copyWith(postStatus: PostStatus.success, postsList: value, message: 'success'));
    }).onError((error, stackTrace) {
      emit(state.copyWith(postStatus: PostStatus.failure, message: error.toString()));
    });
  }

}
