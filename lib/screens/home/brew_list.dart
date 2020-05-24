import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:brew_crew/models/user.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context){
    var brews = Provider.of<List<Brew>>(context);
    final user = Provider.of<User>(context);    
    final List<Brew> filterBrew = [];
        
    for(var x in brews){
      if(x.puid == user.uid){
        filterBrew.add(x);
      }
    }

    brews = filterBrew;
    
//    brews.sort((a, b) => a.checked < b.checked);
    return Row(
      children: <Widget>[
        Expanded(
              child: ListView(
                children: brews.map((brew) => BrewTile(brew: brew)).toList()
          ),
        ),  
        ],
        
    );

  }
}
