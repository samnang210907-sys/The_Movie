import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/person.model.dart';
import 'person_detail.dart';
import '../services/the_movie_service.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../logics/movie_gridstyle_logic.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  bool _showUpIcon = false;

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
      floatingActionButton: _showUpIcon ? _builFloating() : null,
      // drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildSkeletonizer() {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
                    borderRadius: BorderRadiusGeometry.circular(8),
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

  bool _gridStyle = true;

  AppBar _buildAppBar() {
    _gridStyle = context.watch<MovieGridstyleLogic>().gridStyle;

    return AppBar(
      leading: Icon(Icons.people),
      title: Text("Stars"),
    );
  }

  final TheMovieService _service = TheMovieService();

  late Future<PersonPopular> _futureData = _service.getPopularPeople();

  Widget _buildBody() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureData = _service.getPopularPeople();
          });
        },
        child: FutureBuilder<PersonPopular>(
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
                        _futureData = _service.getPopularPeople();
                      });
                    },
                    child: Text("RETRY"),
                  ),
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return _buildGridView( snapshot.data);
            } else {
              return _buildSkeletonizer();
            }
          },
        ),
      ),
    );
  }

  Widget _builFloating() {
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

  final _scroller = ScrollController();

  Widget _buildGridView(PersonPopular? data) {
    if (data == null) {
      return Center(child: Icon(Icons.list));
    }

    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    double screenWidth = MediaQuery.of(context).size.width;

    final items = data.results;

    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 1000 ? (screenWidth - 1000) / 2 : 8,
        vertical: 8,
      ),
      controller: _scroller,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _gridStyle ? (isLandscape ? 4 : 2) : 1,
        childAspectRatio: _gridStyle ? 3 / 5 : 3 / 3,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PersonDetailScreen(item.id.toString()),
              ),
            );
          },
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: item.profilePath != null
                        ? CachedNetworkImage(
                            imageUrl:
                                "https://image.tmdb.org/t/p/w500${item.profilePath}",
                            placeholder: (_, _) => Container(color: Colors.grey),
                            errorWidget: (_, _, _) =>
                                Container(color: Colors.grey.shade800),
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          )
                        : Container(color: Colors.grey.shade800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}