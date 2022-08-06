import 'package:flutter/material.dart';
import 'package:pattern_scoped_model_architecture4/pages/create_post.dart';
import 'package:pattern_scoped_model_architecture4/scopes/home_scoped.dart';
import 'package:scoped_model/scoped_model.dart';

import '../views/item_of_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeScoped scoped = HomeScoped();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scoped.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scoped Model",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: ScopedModel<HomeScoped>(
        model: scoped,
        child: ScopedModelDescendant<HomeScoped>(
          builder: (ctx, child, model) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: scoped.items.length,
                  itemBuilder: (ctx, index) {
                    return itemOfPost(scoped,scoped.items[index]);
                  },
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreatePost.id);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
