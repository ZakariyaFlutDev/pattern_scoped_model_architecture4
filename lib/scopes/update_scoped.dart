import 'package:flutter/material.dart';
import 'package:pattern_scoped_model_architecture4/service/http_service.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model/post_model.dart';

class UpdateScoped extends Model{

  bool isLoading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future apiUpdatePost(Post post) async {
    isLoading = true;
    notifyListeners();

    String title = titleController.text.toString().trim();
    String content = contentController.text.toString().trim();

    post.title = title;
    post.body = content;

    var response = await Network.PUT(
        Network.API_UPDATE + post.id.toString(),
        Network.paramsUpdate(post));

    isLoading = false;
    notifyListeners();

    return response!=null;
  }

}