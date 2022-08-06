import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model/post_model.dart';
import '../service/http_service.dart';

class CreateScoped extends Model{
  bool isLoading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<bool> apiCreatePost() async{

    isLoading = true;
    notifyListeners();

    String title = titleController.text.toString().trim();
    String content = contentController.text.toString().trim();

    Post post =  Post(id: 101, title: title, body: content, userId: 101);

    var response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));

    isLoading = false;
    notifyListeners();

    return response!=null;

  }

}