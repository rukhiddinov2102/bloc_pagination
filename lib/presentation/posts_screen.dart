import 'dart:async';


import 'package:bloc_pagination/cubit/posts_cubit.dart';
import 'package:bloc_pagination/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PostsView extends StatelessWidget {
  final scrollcontroller = ScrollController();

   PostsView({Key? key}) : super(key: key);

  void setupScrollController(context) async {
    scrollcontroller.addListener(() {
      scrollcontroller.addListener(() {
        if (scrollcontroller.position.atEdge) {
          if (scrollcontroller.position.pixels != 0) {
            BlocProvider.of<PostsCubit>(context).loadPosts();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<PostsCubit>(context).loadPosts();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: const Text("Bloc pagination",style: TextStyle(color: Colors.black),),
      ),
      body: _postList(),
    );
  }

  Widget _postList() {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsLoading && state.isFirstFetch) {
          return _loadingIndicator();
        }

        List<Post> posts = [];
        bool isLoading = false;

        if (state is PostsLoading) {
          posts = state.oldPosts;
          isLoading = true;
        } else if (state is PostsLoaded) {
          posts = state.posts;
        }

        return ListView.builder(
          controller: scrollcontroller,
          itemBuilder: (context, index) {
            if (index < posts.length) {
              return _post(posts[index], context);
            } else {
              Timer(const Duration(microseconds: 30), () {
                scrollcontroller
                    .jumpTo(scrollcontroller.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          
          itemCount: posts.length + (isLoading ? 1 : 0),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _post(Post post, BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(post.id.toString()),
        title: Text(post.title),
        subtitle: Text(post.body),
      ),
    );
  }
}
