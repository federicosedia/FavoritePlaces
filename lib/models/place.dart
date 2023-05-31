import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  //elenco inizializzatori per la gestione dell'id tramite uuid che genera id generico univoco
  Place({required this.title}) : id = uuid.v4();

  final String id;
  final String title;
}
