import 'package:flutter/material.dart';
import 'package:pattern_scoped_model_architecture4/model/post_model.dart';
import 'package:pattern_scoped_model_architecture4/pages/home_page.dart';
import 'package:pattern_scoped_model_architecture4/scopes/create_scoped.dart';
import 'package:pattern_scoped_model_architecture4/service/http_service.dart';
import 'package:scoped_model/scoped_model.dart';
class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  static const String id = "create_post";

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  CreateScoped scoped = CreateScoped();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post", style: TextStyle(color: Colors.white, fontSize: 28),),
      ),
      body: ScopedModel<CreateScoped>(
        model: scoped,
        child: ScopedModelDescendant<CreateScoped>(
          builder: (ctx,child,model){
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 55,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade300
                          ),
                          child: TextField(
                            controller: scoped.titleController,
                            decoration: InputDecoration(
                                hintText: "Title",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 55,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade300
                          ),
                          child: TextField(
                            controller:scoped.contentController,
                            decoration: InputDecoration(
                                hintText: "Content",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),

                        Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue
                          ),
                          child: Center(
                              child: GestureDetector(
                                onTap: (){
                                  scoped.apiCreatePost().then((value) => {
                                    if(value) Navigator.pop(context),
                                  });
                                  print("ADD");
                                },
                                child: Text("Add Post", style: TextStyle(color: Colors.white, fontSize: 22),),
                              )
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                scoped.isLoading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : SizedBox.shrink(),
              ],
            );
          },
        ),
      )
    );
  }
}
