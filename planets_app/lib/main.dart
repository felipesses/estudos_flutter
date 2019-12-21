import 'package:flutter/material.dart';
import 'package:planets_app/model/Planet.dart';
import 'package:planets_app/database/db.dart';

import 'database/db.dart';

List _allPlanets;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var db = new DB();

  int neptune = await db.insertPlanet(new Planet(
    1,
    "Neptune",
    "Neptune is about the size of Uranus and is known for supersonic strong winds. Neptune is far out and cold. The planet is more than 30 times as far from the sun as Earth.",
  ));

  int uranus = await db.insertPlanet(new Planet(2, "Uranus",
      "Uranus is an oddball. It has clouds made of hydrogen sulfide, the same chemical that makes rotten eggs smell so foul. It rotates from east to west like Venus."));

  int saturn = await db.insertPlanet(new Planet(3, "Saturn",
      "Saturn is known most for its rings. When polymath Galileo Galilei first studied Saturn in the early 1600s, he thought it was an object with three parts: a planet and two large moons on either side."));

  int jupiter = await db.insertPlanet(new Planet(4, "Jupiter",
      "Jupiter is a giant gas world that is the most massive planet in our solar system — more than twice as massive as all the other planets combined, according to NASA."));

  int mars = await db.insertPlanet(new Planet(5, "Mars",
      "Mars is a cold, desert-like place covered in dust. This dust is made of iron oxides, giving the planet its iconic red hue."));

  int earth = await db.insertPlanet(new Planet(6, "Earth",
      "Earth is a waterworld, with two-thirds of the planet covered by ocean. It's the only world known to harbor life. Earth's atmosphere is rich in nitrogen and oxygen."));

  int venus = await db.insertPlanet(new Planet(7, "Venus",
      "Venus is Earth's twin in size. Radar images beneath its atmosphere reveal that its surface has various mountains and volcanoes."));

  int mercury = await db.insertPlanet(new Planet(8, "Mercury",
      "Zipping around the sun in only 88 days, Mercury is the closest planet to the sun, and it's also the smallest, only a little bit larger than Earth's moon."));

  _allPlanets = await db.getPlanets();

  for (int i = 0; i < _allPlanets.length; i++) {
    Planet planets = Planet.map(_allPlanets[i]);
    debugPrint("Usuario: ${planets.name}, Id: ${planets.id}");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Solar System"),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: _allPlanets.length,
            itemBuilder: (_, int position) {
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.details),
                  ),
                  title: Text("${Planet.fromMap(_allPlanets[position]).name}"),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var db = new DB();
            await db.deletePlanet(1);
          },
        ),
      ),
    );
  }
}
