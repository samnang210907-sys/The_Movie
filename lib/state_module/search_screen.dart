// import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
// import 'package:http/http.dart' as http;

import 'detail_screen.dart';
import 'product_service.dart';
import 'product_model.dart';
import 'gridstyle_logic.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // bool _gridStyle = false;

  bool _showUpIcon = false;
  final ScrollController _scroller = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroller.addListener(() {
      if (_scroller.position.pixels < 500) {
        setState(() {
          _showUpIcon = false;
        });
      } else {
        setState(() {
          _showUpIcon = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _showUpIcon ? _buildFloating() : null,
      drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildSkeletonizer(){
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    double screenWidth = MediaQuery.of(context).size.width;

    return Skeletonizer(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth > 1000 ? (screenWidth - 1000) / 2 : 8,
          vertical: 8,
        ),
        // controller: _scroller,
        // physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _gridStyle ? (isLandscape ? 4 : 2) : 1,
          childAspectRatio: _gridStyle ? 3 / 5 : 3 / 3,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "asd asd asd sd asd sad asd",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(8.0),
                  child: Text("asdasd sa d", textAlign: TextAlign.right),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  bool _gridStyle = true;

  final _searchCtrl = TextEditingController();  

  AppBar _buildAppBar() {
    _gridStyle = context.watch<GridStyleLogic>().gridStyle;

    return AppBar(
      title: TextField(
        controller: _searchCtrl,
        style: TextStyle(color: const Color.fromARGB(255, 195, 72, 72)),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: const Color.fromARGB(153, 189, 49, 49),),
          hintText: "Search products...",
          hintStyle: TextStyle(
            color: const Color.fromARGB(153, 207, 73, 73),
            ),
        ),
        onSubmitted: (value) {
          setState(() {
            _futureData = ProductService().search(_searchCtrl.text.trim());
          });
        },
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       context.read<ThemeLogic>().toggleDark();
      //     },
      //     icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
      //   ),
      //   IconButton(
      //     onPressed: () {
      //       context.read<CounterLogic>().decrease();
      //     },
      //     icon: Icon(Icons.remove),
      //   ),
      //   IconButton(
      //     onPressed: () {
      //       context.read<CounterLogic>().increase();
      //     },
      //     icon: Icon(Icons.add),
      //   ),
      //   IconButton(
      //     onPressed: () {
      //       context.read<GridStyleLogic>().toggleStyle();
      //     },
      //     icon: Icon(_gridStyle ? Icons.list : Icons.grid_view),
      //   ),
      // ],
    );
  }

  late Future<List<ProductModel>> _futureData =
      ProductService().search(_searchCtrl.text.trim());

  Widget _buildBody() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureData = ProductService().search(_searchCtrl.text.trim());
          });
        },
        child: FutureBuilder<List<ProductModel>>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.error.toString()),
                  FilledButton(
                    onPressed: () {
                      setState(() {
                        _futureData = ProductService().search(_searchCtrl.text.trim());
                      });
                    },
                    child: Text("RETRY"),
                  ),
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return _buildGridView(snapshot.data);
            } else {
              return _buildSkeletonizer();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  Widget _buildFloating() {
    return FloatingActionButton(
      onPressed: () {
        _scroller.animateTo(
          0,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      child: Icon(Icons.arrow_upward),
    );
  }

  Widget _buildGridView(List<ProductModel>? items) {
    if (items == null) {
      return Center(child: Icon(Icons.list));
    }

    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      constraints: BoxConstraints(
        maxWidth: 1000,
      ),
      // color: Colors.amber,

      child: GridView.builder(
        controller: _scroller,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _gridStyle ? (isLandscape ? 4 : 2) : 1,
          childAspectRatio: _gridStyle ? 3 / 5 : 4 / 3,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailScreen(item: item),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: item.images[0],
                        placeholder: (_, _) =>
                            Container(color: Colors.grey),
                        errorWidget: (_, _, _) => Container(
                          color: Colors.grey.shade800,
                        ),
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "USD ${item.price}",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}