import 'package:equatable/equatable.dart';

import '../../model/post_model.dart';
import '../../utils/enums.dart';

class PostState extends Equatable {

  const PostState({
    this.postStatus = PostStatus.loading,
    this.postList = const <PostModel>[],
    this.message = '',
  });

  final PostStatus postStatus;
  final List<PostModel> postList;
  final String message;


  PostState copyWith({
    PostStatus? postStatus,
    List<PostModel>? postsList,
    String? message,
  }) {
    return PostState(
      postStatus: postStatus ?? this.postStatus,
      postList: postsList ?? this.postList,
      message: message ?? this.message,
    );
  }


  @override
  List<Object> get props => [postStatus, postList, message];
}