import "dart:io";

import "package:favorite_places/models/place.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

//notifier class è una classe in cui vengono aggiunti metodi che servono
//per manipolare lo stato. Quindi la mia classe estende statenotifier
class UserPlacesNotifier extends StateNotifier<List<Place>> {
  //costruttore con super dopo passo lo stato iniziale
  //lo stato non cambia in memoria ma si aggiunge solo qualcosa
  //quindi si crea un nuovo oggeto stato di list place
  UserPlacesNotifier() : super(const []);

//creiamo un nuovo oggeto place e lo aggiungiamo alla nostra lista in super
//dato che non posso modificare la lista originaria mi richiamo lo state e cambio la lista
  void addPlace(String title, File image) {
    final newPlace = Place(title: title, image: image);
    state = [newPlace, ...state];
  }
}

//ora impostiamo il provider
//si ottiene un oggetto ref che serve per ascoltare altri provider
final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
