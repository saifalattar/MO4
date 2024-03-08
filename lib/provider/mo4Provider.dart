import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mo4/models/commentModel.dart';
import 'package:mo4/models/postModels.dart';

class Mo4Provider extends ChangeNotifier {
  List<Post> posts = [];
  final List<Widget> commentsOfPost = [];
  // List<Widget> get _posts => posts;

  Future<void> getPosts() async {
    posts.clear();
    var response =
        await Dio().get("https://jsonplaceholder.typicode.com/posts");
    for (var data in response.data) {
      Post post = Post(
          userId: data["userId"],
          postId: data["id"],
          title: data["title"],
          body: data["body"]);

      posts.add(post);
    }
    notifyListeners();
  }

  Future<void> getPostComments(int postId) async {
    var response = await Dio()
        .get("https://jsonplaceholder.typicode.com/posts/$postId/comments");
    for (var data in response.data) {
      Comment comment = Comment(
        name: data["name"],
        email: data["email"],
        body: data["body"],
      );
      commentsOfPost.add(comment);
    }
  }

  Future deletePost(BuildContext context, Post post) async {
    await Dio()
        .delete("https://jsonplaceholder.typicode.com/posts/${post.postId}")
        .then((value) {
      posts.remove(post);
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Post number (${post.postId}) has been deleted"),
        backgroundColor: Colors.green,
      ));
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Post number (${post.postId}) can't be deleted"),
        backgroundColor: Colors.red,
      ));
    });
  }
}
