import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/person_detail_model.dart';
import '../services/the_movie_service.dart';
class PersonDetailScreen extends StatefulWidget {
  final String personId;

  const PersonDetailScreen(this.personId, {super.key});

  @override
  State<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Person Detail")),
      body: _buildBody(),
    );
  }

  final TheMovieService _service = TheMovieService();

  late Future<PersonDetail> _futureData = _service.getPersonDetail(widget.personId);

  Widget _buildBody() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureData = _service.getPersonDetail(widget.personId);
          });
        },
        child: FutureBuilder<PersonDetail>(
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
                        _futureData = _service.getPersonDetail(widget.personId);
                      });
                    },
                    child: Text("RETRY"),
                  ),
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return _buildListView(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView(PersonDetail? item) {
    if (item == null) {
      return Center(child: Icon(Icons.list));
    }

    double screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 1000 ? (screenWidth - 1000) / 2 : 8,
      ),
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(8),
          child: CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/w500/${item.profilePath}",
            placeholder: (_, _) => Container(color: Colors.grey),
            errorWidget: (_, _, _) => Container(color: Colors.grey.shade800),
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Card(
            child: ListTile(
              leading: Icon(
                Icons.person,
               color: Theme.of(context).colorScheme.primary,),
              title: Text(item.name),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Card(child: ListTile(title: Text(item.biography))),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Card(
            child: ListTile(
              leading: Icon(Icons.date_range
              , color: Theme.of(context).colorScheme.primary,),
              title: Text(
                "${item.birthday.day}/${item.birthday.month}/${item.birthday.year}",
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Card(
            child: ListTile(
              leading: Icon(
                Icons.home,
               color: Theme.of(context).colorScheme.primary,),
              title: Text(item.placeOfBirth),
            ),
          ),
        ),
         Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Card(
            child: ListTile(
              leading: Icon(
                Icons.work,
                color: Theme.of(context).colorScheme.primary,
                ),
              title: Text(item.knownForDepartment),
            ),
          ),
        ),
      ],
    );
  }
}