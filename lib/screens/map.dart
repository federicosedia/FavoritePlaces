import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  LatLng? pickedlocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Pick your location' : "Your Location",
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(pickedlocation);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      // con googlemaps possiamo fare un render della mappa
      //possiamo configurare la posizione iniziale con initialCameraPosition
      //vuole il widget cameraposition e cameraposition vuole target come argomento

      body: GoogleMap(
        //ottiene la posizione in base a dove tocca nella mappa
        onTap: widget.isSelecting == false
            ? null
            : (position) {
                setState(() {
                  pickedlocation = position;
                });
              },

        initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.location.latitude,
              widget.location.longitude,
            ),
            zoom: 16),
        //markers permette di creare un set di markers
        //un set è un elenco di valori ma che non accetta duplicati
        //faccio ugualmente per la position anche per markers
        markers: (pickedlocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId("m1"),
                  //scelgo la posizione pickedlocation se non nulla altrimenti quella di default
                  //la sintassi potrebbe anche essere
                  /* position: pickedlocation!=null ?? LatLng(
              widget.location.latitude,
              widget.location.longitude,
            ),
            */
                  position: pickedlocation != null
                      ? pickedlocation!
                      : LatLng(
                          widget.location.latitude,
                          widget.location.longitude,
                        ),
                ),
              },
      ),
    );
  }
}
