// https://lua-decompiler.ferib.dev/
// POST	/api/decompile/	Decompiles the embedded Lua binary file.
//
// https://flutterawesome.com/how-to-integrate-rest-api-in-flutter/
// https://www.developerlibs.com/2019/01/flutter-get-and-post-http-requests.html

// https://androidkt.com/http-post-request-in-flutter/

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



/*


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  final String userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["userId"] = userId;
    map["title"] = title;
    map["body"] = body;

    return map;
  }
}

Future createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}

class MyApp extends StatelessWidget {
  final Future post;

  MyApp({Key key, this.post}) : super(key: key);
  static final CREATE_POST_URL = 'https://jsonplaceholder.typicode.com/posts';
  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "WEB SERVICE",
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: [
                new TextField(
                  controller: titleControler,
                  decoration: InputDecoration(
                      hintText: "title....", labelText: 'Post Title'),
                ),
                new TextField(
                  controller: bodyControler,
                  decoration: InputDecoration(
                      hintText: "body....", labelText: 'Post Body'),
                ),
                new RaisedButton(
                  onPressed: () async {
                    Post newPost = new Post(
                        userId: "123", id: 0, title: titleControler.text, body: bodyControler.text);
                    Post p = await createPost(CREATE_POST_URL,
                        body: newPost.toMap());
                    print(p.title);
                  },
                  child: const Text("Create"),
                )
              ],
            ),
          )),
    );
  }
}

void main() => runApp(MyApp());

Recent Posts
Calculate Output Size of Convolutional and Pooling layers in CNN.
Create DataLoader with collate_fn() for variable-length input in PyTorch.
Feature extraction from an image using pre-trained PyTorch model
How to add L1, L2 regularization in PyTorch loss function?
Load custom image datasets into PyTorch DataLoader without using ImageFolder.
PyTorch Freeze Layer for fixed feature extractor in Transfer Learning
How to use kernel, bias, and activity Layer Weight regularizers in Keras
PyTorch K-Fold Cross-Validation using Dataloader and Sklearn
Micro and Macro Averages for imbalance multiclass classification
Explain Pooling layers: Max Pooling, Average Pooling, Global Average Pooling, and Global Max pooling.
Categories
Categories
Select Category


Privacy Policy
Copyright © 2021 knowledge Transfer All Rights Reserved.
Powered by WordPress. Designed by Yossy's web service.


}*/
