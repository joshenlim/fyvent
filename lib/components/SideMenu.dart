import 'package:flutter/material.dart';
import 'package:fyvent/app_state_container.dart';
import 'package:fyvent/screens/favourites_screen.dart';
import 'package:fyvent/screens/search_nearby_screen.dart';

class SideMenu extends StatelessWidget {
  final String name;
  final String email;
  final String imgUrl;

  SideMenu({this.name, this.email, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    final container = AppStateContainer.of(context);

    void _signOut() {
      container.signOut().then((_) {
        Navigator.pushReplacementNamed(context, '/');
      });
    }

    void _viewFavourites() {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => FavouritesScreen()
      ));
    }

    void _searchNearby(){
      Navigator.of(context).pop(); //the back button
      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => SearchNearbyScreen(null, true)
      ));
    }

    return new Drawer(
      child:ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
            child: new Row(
              children: [
                new Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(right: 20.0),
                  decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(const Radius.circular(100.0)),
                    image: new DecorationImage(
                      image: new NetworkImage(imgUrl),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )
                  ),
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: new TextStyle(fontFamily: 'Greycliff', fontSize: 18.0)),
                    Text(email, style: new TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, fontSize: 14.0))
                  ]
                )
              ]
            )
          ),
          ListTile(
            title: Text("Search Nearby"),
            leading: Icon(Icons.search),
            onTap: () => _searchNearby(),
          ),
          ListTile(
            title: Text("Favourites"),
            leading: Icon(Icons.favorite_border),
            onTap: () => _viewFavourites(),
          ),
          ListTile(
            title: Text("Log out"),
            leading: Icon(Icons.arrow_forward),
            onTap: () => _signOut(),
          ),
        ]
      )
    );
  }
}