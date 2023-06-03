import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place({
    required this.title,
    required this.image,
    required this.location,
    //id da non assegnare automaticamente e se non viene fornito allora viene dato tramite la logica
    //riportata dopo
    String? id,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}
