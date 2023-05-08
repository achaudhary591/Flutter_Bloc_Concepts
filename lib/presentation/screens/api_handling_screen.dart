import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concept/logic/cubit/post_cubit/cubit/post_cubit.dart';

import '../../data/post_model.dart';

class ApiHandlingScreen extends StatefulWidget {
  const ApiHandlingScreen({super.key});

  @override
  State<ApiHandlingScreen> createState() => _ApiHandlingScreenState();
}

class _ApiHandlingScreenState extends State<ApiHandlingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("API Handling"),
      ),
      body: SafeArea(
        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {
            if (state is PostErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            if (state is PostLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is PostLoadedState) {
              return buildPostListView(state.posts);
            }

            return const Center(
              child: Text("An error occured!"),
            );
          },
        ),
      ),
    );
  }

  Widget buildPostListView(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        PostModel post = posts[index];

        return Column(
          children: [
            ListTile(
              title: Text(post.title.toString()),
              subtitle: Text(post.body.toString()),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
