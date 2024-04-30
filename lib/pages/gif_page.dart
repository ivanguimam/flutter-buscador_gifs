import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  final Map _gifData;

  const GifPage(this._gifData, {super.key});

  void _share() {
    Share.share(_gifData["images"]['fixed_height']["url"]);
  }

  @override
  Widget build(BuildContext context) {
    Image image = Image.network(_gifData["images"]['fixed_height']["url"]);
    Center body = Center(
      child: image,
    );

    Text title = Text(_gifData["title"]);

    IconButton shareButton = IconButton(
      onPressed: _share,
      icon: Icon(Icons.share)
    );

    AppBar appBar = AppBar(
      backgroundColor: Colors.black,
      actions: [shareButton],
      title: title,
    );

    Scaffold scaffold = Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar,
      body: body,
    );

    return scaffold;
  }
}
