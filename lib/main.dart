import 'package:flutter/material.dart';
import 'package:mo4/models/postModels.dart';
import 'package:mo4/provider/mo4Provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Mo4Provider()..getPosts(),
    child: MaterialApp(
      home: Home(),
    ),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Mo4Provider>(builder: (context, provider, widget) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Center(child: Text("Posts")),
          ),
          body: ListView.separated(
              itemBuilder: (context, index) {
                return provider.posts[index];
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
              itemCount: provider.posts.length));
    });
  }
}
