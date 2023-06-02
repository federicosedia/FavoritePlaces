import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

//per capire dove è situata una determinata posizione
class PlaceLocation {
  const PlaceLocation(
      {required this.address, required this.latitude, required this.longitude});
  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  //elenco inizializzatori per la gestione dell'id tramite uuid che genera id generico univoco
  Place({
    required this.title,
    required this.image,
    //required this.location,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  // final PlaceLocation location;
}
