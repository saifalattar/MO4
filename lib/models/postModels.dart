import 'package:flutter/material.dart';
import 'package:mo4/provider/mo4Provider.dart';
import "package:provider/provider.dart";

class Post extends StatelessWidget {
  final int userId, postId;
  final String title, body;
  Post(
      {required this.userId,
      required this.postId,
      required this.title,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return Consumer<Mo4Provider>(
      builder: (BuildContext context, provider, Widget? child) {
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => fullPage(context, postId))),
          child: Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(20)),
            width: 200,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2,
                      child: Text(
                        "$postId - $title",
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text("\nView full info>>")
                  ],
                ),
                IconButton(
                    onPressed: () {
                      provider.deletePost(context, this);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fullPage(context, int postId) {
    return Consumer<Mo4Provider>(builder: (context, provider, widget) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Center(child: Text("$postId")),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Title :-",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("$title")
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Body :-",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("$body")
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\n\nComments :-",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                FutureBuilder(
                    future: provider.getPostComments(postId),
                    builder: (context, ss) {
                      if (ss.connectionState != ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height / 2.5,
                        width: MediaQuery.sizeOf(context).width / 1.5,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return provider.commentsOfPost[index];
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: provider.commentsOfPost.length),
                      );
                    })
              ],
            ),
            IconButton(
                onPressed: () async {
                  await provider
                      .deletePost(context, this)
                      .then((value) => Navigator.pop(context));
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
      );
    });
  }
}
