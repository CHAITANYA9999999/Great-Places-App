import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_complete_guide/Providers/great_places.dart';
import 'package:flutter_complete_guide/Screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
              icon: Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future:
              Provider.of<GreatPlaces>(context, listen: false).fetchPlaces(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    builder: ((ctx, greatPlaces, ch) {
                      return greatPlaces.items.isEmpty
                          ? ch!
                          : ListView.builder(
                              itemBuilder: ((context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: FileImage(
                                        greatPlaces.items[index].image),
                                  ),
                                  title: Text(greatPlaces.items[index].title),
                                  onTap: () {},
                                );
                              }),
                              itemCount: greatPlaces.items.length,
                            );
                    }),
                    child: Center(
                        child: Text("No place till now, Start adding some"
                            .toUpperCase())),
                  );
          },
        ));
  }
}
