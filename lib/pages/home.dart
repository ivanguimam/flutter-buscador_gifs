import 'package:buscador_gifs/api/api.dart';
import 'package:buscador_gifs/widgets/gif_table.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _query = "";
  int _page = 1;

  @override
  void initState() {
    super.initState();

    // fetch_trending(1).then((value) => print(value));
  }
  void onSubmitted(String text) {
    setState(() {
      _query = text;
      _page = 1;
    });
  }

  void _onReadMore() {
    setState(() {
      _page = _page + 1;
    });
  }

  void _onTapGiff() {}

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration = const InputDecoration(
      border: OutlineInputBorder(),
      labelStyle: TextStyle(color: Colors.white),
      labelText: 'Pesquise aqui',
    );

    TextField inputSearch = TextField(
      decoration: decoration,
      onSubmitted: onSubmitted,
      style: TextStyle(color: Colors.white, fontSize: 20),
      textAlign: TextAlign.center,
    );
    
    Padding inputSearchContainer = Padding(padding: EdgeInsets.all(10), child: inputSearch);

    FutureBuilder container = FutureBuilder(
      future: _query.isEmpty ? fetch_trending(_page) : search(_query, _page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
          return Container(
            alignment: Alignment.center,
            height: 200,
            width: 200,
            child: const CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Erro ao buscar dados', style: TextStyle(color: Colors.white)),
          );
        }

        return GifTable(
          futureBuilderContext: context,
          futureBuilderSnapshot: snapshot,
          onReadMore: _onReadMore,
          onTapGif: _onTapGiff
        );
      },
    );
    
    Expanded listContainer = Expanded(child: container);

    Column body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [inputSearchContainer, listContainer],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Image.network('https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif'),
      ),
      backgroundColor: Colors.black,
      body: body,
    );
  }
}
