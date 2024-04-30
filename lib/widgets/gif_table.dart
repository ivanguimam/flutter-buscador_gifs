import 'package:buscador_gifs/pages/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class GifTable extends StatefulWidget {
  final AsyncSnapshot<dynamic> futureBuilderSnapshot;
  final BuildContext futureBuilderContext;
  final Function onReadMore;
  final Function onTapGif;

  const GifTable({
    super.key,
    required this.futureBuilderContext,
    required this.futureBuilderSnapshot,
    required this.onReadMore,
    required this.onTapGif,
  });

  @override
  State<GifTable> createState() => _GifTableState(
      futureBuilderContext: futureBuilderContext,
      futureBuilderSnapshot: futureBuilderSnapshot,
      onReadMore: onReadMore,
      onTapGif: onTapGif);
}

class _GifTableState extends State<GifTable> {
  final AsyncSnapshot<dynamic> futureBuilderSnapshot;
  final BuildContext futureBuilderContext;
  final Function onReadMore;
  final Function onTapGif;

  _GifTableState(
      {required this.futureBuilderContext,
      required this.futureBuilderSnapshot,
      required this.onReadMore,
      required this.onTapGif});

  @override
  Widget build(BuildContext context) {
    SliverGridDelegateWithFixedCrossAxisCount greDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    );

    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: greDelegate,
      itemBuilder: _itemBuidler,
      itemCount: futureBuilderSnapshot.data["data"].length + 1,
    );
  }

  Widget _itemBuidler(BuildContext context, int index) {
    if (index == futureBuilderSnapshot.data["data"].length) {
      return _buildReadMore();
    }

    var gif = futureBuilderSnapshot.data["data"][index];
    String url = gif["images"]["fixed_height"]["url"];
    FadeInImage image = FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: url,
      height: 300,
      fit: BoxFit.cover,
    );

    GestureDetector gesture = GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (context) => GifPage(gif));
        Navigator.push(context, route);
      },
      onLongPress: () {
        Share.share(gif["images"]['fixed_height']["url"]);
      },
      child: image,
    );

    return gesture;
  }

  Widget _buildReadMore() {
    Icon icon = const Icon(Icons.add, color: Colors.white, size: 70);

    TextStyle style = const TextStyle(
      color: Colors.white,
      fontSize: 22,
    );
    Text text = Text("Carregar mais...", style: style);

    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [icon, text],
    );

    GestureDetector gestureDetector = GestureDetector(
      onTap: () {
        onReadMore();
      },
      child: column,
    );

    Container container = Container(
      child: gestureDetector,
    );

    return container;
  }
}
