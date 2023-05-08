
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_concept/data/post_model.dart';

import 'api/api.dart';

class PostRepository {
  API api = API();

  Future<List<PostModel>> fetchPosts() async {
    try {
      Response response = await api.sendRequest.get('/posts');
      List<dynamic> postMaps = response.data;

      return postMaps.map((map) => PostModel.fromJson(map)).toList();
      // log(response.data);
    } catch (ex) {
      rethrow;      
    }
  }
}
