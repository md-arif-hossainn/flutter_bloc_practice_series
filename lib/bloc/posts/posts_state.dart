import 'package:equatable/equatable.dart';

import '../../model/post_model.dart';
import '../../utils/enums.dart';

class PostState extends Equatable {

  const PostState({
    this.postStatus = PostStatus.loading,
    this.postList = const <PostModel>[],
    this.tempPostList = const <PostModel>[],
    this.message = '',
    this.searchMessage = '',
  });

  final PostStatus postStatus;
  final List<PostModel> postList;
  final List<PostModel> tempPostList;
  final String message;
  final String searchMessage;


  PostState copyWith({
    PostStatus? postStatus,
    List<PostModel>? postsList,
    List<PostModel>? tempPostList,
    String? message,
    String? searchMessage,
  }) {
    return PostState(
      postStatus: postStatus ?? this.postStatus,
      postList: postsList ?? this.postList,
      tempPostList: tempPostList ?? this.tempPostList,
      message: message ?? this.message,
      searchMessage: searchMessage ?? this.searchMessage,
    );
  }


  @override
  List<Object> get props => [postStatus, postList, tempPostList, message, searchMessage];
}