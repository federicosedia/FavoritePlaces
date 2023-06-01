import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/providers/user_places.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();

//chiamo il metodo dispose per il titlecontroller quando verrà inviato
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle == null || enteredTitle.isEmpty) {
      return;
    } else {
      //con ref mi richiamo il provider e con read leggo una sola volta il provider(quando aggiungo l'oggetto)
      //accediamo alla classe e con notifier collegata posso utilizzare un metodo di quella classe e quindi utilizzo addplace
      ref.read(userPlacesProvider.notifier).addPlace(enteredTitle);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      //avvolgo in singlechildscrollview per permetter che sia sempre scrollabile
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.background),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            )
          ],
        ),
      ),
    );
  }
}
