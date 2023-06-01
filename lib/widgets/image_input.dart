import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  //verrà fatto con il pacchetto image picker tramite il quale verrà aperta la fotocamera oppure sarà possibile
  //scegliere foto dalla galleria. Oltre l'import per ios è necessario fare altre configurazioni in ios/runner/info.plist
  void _takePicture() async {
    //salviamo in una variabile le immagini
    final imagePicker = ImagePicker();
    //imagepicker è un ImagePicker ha come metodo pickimage che aspetta un source che ha Imagesourse che è un enum e come valore ha camera
    //pickedimage sarà il nostro file ridimensionato (maxwidth)
    final pickedimage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedimage == null) return;
    //dobbiamo convertire il xfile in un file normale quindi utilizzo l'istanza di File(pickedimage.path)
    setState(() {
      _selectedImage = File(pickedimage.path);
    });
    //per richiamare la funzione uso widget perchè è definito nella classw widget
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.camera),
      label: const Text(
        'Take Picture',
      ),
    );

    if (_selectedImage != null) {
      //quindi in content salvo e voglio far vedere l'immagine. Utilizzo il widget image che ha come metodo file che mi permetterà di vedere quel file
      //wrappo Image con GestureDetector per permettere di ascoltare ogni tipo di tocco per i child
      content = GestureDetector(
          onTap: _takePicture,
          child: Image.file(
            _selectedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ));
    } else
      return content;
    //voglio creare un icona in modo tale che se premuta apre la fotocamera e permette di scattare la foto
    //dopo aver scattato la foto ho la possibilità di salvarla e vedere la miniatura
    return Container(
      //aggiungo il border con dell'opacità
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      //per assicurarmi che il pulsante sia centrato nel contenitore
      alignment: Alignment.center,
      child: content,
    );
  }
}
