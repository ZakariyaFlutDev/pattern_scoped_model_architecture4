import 'package:flutter/material.dart';
import 'package:pattern_scoped_model_architecture4/model/post_model.dart';
import 'package:pattern_scoped_model_architecture4/pages/home_page.dart';
import 'package:pattern_scoped_model_architecture4/scopes/update_scoped.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdatePost extends StatefulWidget {
  const UpdatePost({Key? key, required this.post}) : super(key: key);

  static const String id = "update_post";
  final Post post;

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  UpdateScoped scoped = UpdateScoped();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scoped.titleController.text = widget.post.title!;
    scoped.contentController.text = widget.post.body!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Update Post",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        body: ScopedModel<UpdateScoped>(
          model: scoped,
          child: ScopedModelDescendant<UpdateScoped>(
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
                                color: Colors.grey.shade300),
                            child: TextField(
                              controller: scoped.titleController,
                              decoration: InputDecoration(
                                  hintText: "Title",
                                  hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: widget.post.body!.length < 50 ? 50 : 100,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade300),
                            child: TextField(
                              maxLines: 20,
                              minLines: 2,
                              controller: scoped.contentController,
                              decoration: InputDecoration(
                                  hintText: "Content",
                                  hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue),
                            child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    scoped.apiUpdatePost(widget.post).then((value) => {
                                      if (value)
                                        Navigator.pop(context),
                                    });
                                  },
                                  child: Text(
                                    "Update Post",
                                    style: TextStyle(color: Colors.white, fontSize: 22),
                                  ),
                                )),
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
            }
          ),
        )
    );
  }
}
