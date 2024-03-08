import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String? name, email, body;
  const Comment(
      {super.key, required this.name, required this.email, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery.sizeOf(context).width / 3,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "From :-",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("$name")
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "E-Mail :-",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("$email")
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Body :-",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("$body")
            ],
          ),
        ],
      ),
    );
  }
}
