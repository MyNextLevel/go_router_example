import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

/// Person data class.
class Person {
  /// Creates a [Person].
  Person({required this.id, required this.name, required this.age});

  /// The id of the person.
  final String id;

  /// The name of the person.
  final String name;

  /// The age of the person.
  final int age;
}

/// Family data class.
class Family {
  /// Creates a [Family].
  Family({required this.id, required this.name, required this.people});

  /// The id of the family.
  final String id;

  /// The name of the family.
  final String name;

  /// The list of [Person]s in the family.
  final List<Person> people;

  /// Gets the [Person] with the given id in this family.
  Person person(String pid) => people.singleWhere(
        (Person p) => p.id == pid,
        orElse: () => throw Exception('unknown person $pid for family $id'),
      );
}

/// The mock of families data.
class Families {
  Families._();

  /// The data.
  static final List<Family> data = <Family>[
    Family(
      id: 'f1',
      name: 'Sells',
      people: <Person>[
        Person(id: 'p1', name: 'Chris', age: 52),
        Person(id: 'p2', name: 'John', age: 27),
        Person(id: 'p3', name: 'Tom', age: 26),
      ],
    ),
    Family(
      id: 'f2',
      name: 'Addams',
      people: <Person>[
        Person(id: 'p1', name: 'Gomez', age: 55),
        Person(id: 'p2', name: 'Morticia', age: 50),
        Person(id: 'p3', name: 'Pugsley', age: 10),
        Person(id: 'p4', name: 'Wednesday', age: 17),
      ],
    ),
    Family(
      id: 'f3',
      name: 'Hunting',
      people: <Person>[
        Person(id: 'p1', name: 'Mom', age: 54),
        Person(id: 'p2', name: 'Dad', age: 55),
        Person(id: 'p3', name: 'Will', age: 20),
        Person(id: 'p4', name: 'Marky', age: 21),
        Person(id: 'p5', name: 'Ricky', age: 22),
        Person(id: 'p6', name: 'Danny', age: 23),
        Person(id: 'p7', name: 'Terry', age: 24),
        Person(id: 'p8', name: 'Mikey', age: 25),
        Person(id: 'p9', name: 'Davey', age: 26),
        Person(id: 'p10', name: 'Timmy', age: 27),
        Person(id: 'p11', name: 'Tommy', age: 28),
        Person(id: 'p12', name: 'Joey', age: 29),
        Person(id: 'p13', name: 'Robby', age: 30),
        Person(id: 'p14', name: 'Johnny', age: 31),
        Person(id: 'p15', name: 'Brian', age: 32),
      ],
    ),
  ];

  /// Looks up a family in the data.
  static Family family(String fid) => data.family(fid);
}

extension on List<Family> {
  Family family(String fid) => singleWhere(
        (Family f) => f.id == fid,
        orElse: () => throw Exception('unknown family $fid'),
      );
}
