import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    //non required ma se non selezionato allora di default sarà:
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: "",
    ),
    this.isSelecting = true,
  });
  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Pick your location' : "Your Location",
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(onPressed: () {}, icon: const Icon(Icons.save))
        ],
      ),
      // con googlemaps possiamo fare un render della mappa
      //possiamo configurare la posizione iniziale con initialCameraPosition
      //vuole il widget cameraposition e cameraposition vuole target come argomento

      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.location.latitude,
              widget.location.longitude,
            ),
            zoom: 16),
        //markers permette di creare un set di markers
        //un set è un elenco di valori ma che non accetta duplicati
        markers: {
          Marker(
            markerId: MarkerId("m1"),
            position: LatLng(
              widget.location.latitude,
              widget.location.longitude,
            ),
          ),
        },
      ),
    );
  }
}
