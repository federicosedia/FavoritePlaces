import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql ;
import 'package:sqflite/sqlite_api.dart' as  ;

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
  //utilizziamo sql per memorizzare gli altri dati del place che voglio salvare
    //questo metodo restituisce un futuro che restituisce un percorso del database sul dispositivo

    final dbpath = await sql.getDatabasesPath();
    //ottenuto il path chiamiamo opendatabase
    //ma non utilizziamo dbpath ma un path simile a quanto fatto per l'immagine
    //con questo metodo possiamo utilizzare il metodo join sul path
    //quindi si specifica il path e il nome del database e se non è ancora esistente allora lo crea
  //deve terminare con ".db"
  //inoltre bisogna specificare anche oncreate. Oncreate accetta come valore una funzione che viene eseguita quando viene creato il db la prima volta
  //quindi mi salvo il db che andrò a creare in una nuova variabile
    //essendo un future allora metto anche await
    final db = await sql.openDatabase(path.join(dbpath, "places.db",), 
    onCreate: (db, version){
      //verrà tornata una funzione che in pratica è una query che verrà eseguita nel db quando viene creato
      //real= numero con valori decimali
      //string =text
      return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    //la versione dovrebbe aggiornarsi ogni volta che si modifica la query
    version: 1
    );

//prima parte di insert il nome della tabella
//seconda parte una mappa dove le chiavi sono i nomi delle colonne e i valori sono i dati da inserire
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image':newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    },);

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
