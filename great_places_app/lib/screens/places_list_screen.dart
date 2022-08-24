import 'package:flutter/material.dart';
import 'package:great_places_app/provider/great_places.dart';
import 'package:provider/provider.dart';
import '/screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(
                    child: Text('Got no places yet , start adding some!')),
                builder: (context, greatplacevalue, child) => greatplacevalue
                        .item.isEmpty
                    ? child!
                    : ListView.builder(
                        itemCount: greatplacevalue.item.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatplacevalue.item[index].image),
                          ),
                          title: Text(greatplacevalue.item[index].title),
                          subtitle: Text(
                              greatplacevalue.item[index].location.address),
                          onTap: () {},
                        ),
                      ),
              ),
      ),
    );
  }
}
