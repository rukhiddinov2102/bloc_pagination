import 'package:bloc_pagination/cubit/posts_cubit.dart';
import 'package:bloc_pagination/data/repositories/posts_repository.dart';
import 'package:bloc_pagination/data/repositories/services/posts_service.dart';
import 'package:bloc_pagination/presentation/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  return  runApp(MyApp(
    repository: PostsRepository(PostsService()),
  ));
}

class MyApp extends StatelessWidget {
  final PostsRepository repository;
  const MyApp({Key? key,required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PostsCubit(repository),
        child: PostsView(),
      ),
    );
  }
}
