import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLocation location) async {
    //creo prima il percorso dove verrà salvato l'elemento e poi l'elemento place
    //il metodo produce un future che ci da un oggetto directory
    final appDir = await syspaths.getApplicationSupportDirectory();
    //ora dobbiamo copiare l'immagine nel nuovo path
    //utilizzo image come parametro e chiamo il metodo copy
    //vuole come argomento una stringa e anche il nome del file che andremo a salvare
    //verrà quindi scelto l'ultimo pezzo della directory di dove andrà salvato
    final fileName = path.basename(image.path);
    //quindi il primo pezzo verrà scelto da appidir e lpultimo da filename

    final copiedImage = await image.copy("${appDir.path}/$fileName");
    //ed ora con l'immagine copiata la salvo nell'oggetto place e quindi verrà salvata anche nella directory
    final newPlace = Place(
      title: title,
      image: image,
      location: location,
    );
    state = [newPlace, ...state];
  }
  //Per memorizzare la foto in modo più persistente sfrutto la classe notifier e il pacchetto path_provider
  //path provider ci da l'accesso al percorso dove memorizzare in modo tale che il SO non la cancella
  //mentre il pacchetto path semplifica il processo di lavoro con i percorsi dei file.
  //questo perchè altrimenti dovremmo creare noi manualmente i path
  //il pacchetto sqflite ci permette di memorizzare dati utilizzando comandi sql
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
