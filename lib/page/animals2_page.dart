import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_testing/model/animals2.dart';
import 'package:provider_testing/provider/animals2_provider.dart';

class Animals2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animals'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<Animals2Provider>(builder: (context, todoProvider, child) {
        List<Animals2> animals = todoProvider.animals;
        if (animals.isEmpty) {
          return Center(
            child: Text('Empty'),
          );
        }
        return ListView.builder(
          itemCount: animals.length,
          itemBuilder: (context, index) {
            Animals2 animal = animals[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(
                  '${index + 1}',
                ),
              ),
              title: Text(animal.name),
              subtitle: Text(animal.species),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      buildUpdateAnimal(context, animal);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<Animals2Provider>().remove(animal);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {buildAddAnimal(context)},
        child: const Icon(Icons.add),
      ),
    );
  }

  buildAddAnimal(BuildContext context) {
    final edtName = TextEditingController();
    final edtSpecies = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add new animal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: edtName,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: edtSpecies,
                decoration: InputDecoration(labelText: 'Species'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => {
                context
                    .read<Animals2Provider>()
                    .add(edtName.text, edtSpecies.text),
                Navigator.pop(context)
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  buildUpdateAnimal(BuildContext context, Animals2 oldsAnimals) {
    final edtName = TextEditingController();
    final edtSpecies = TextEditingController();

    edtName.text = oldsAnimals.name;
    edtSpecies.text = oldsAnimals.species;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update animal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: edtName,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: edtSpecies,
                decoration: InputDecoration(labelText: 'Species'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => {
                context.read<Animals2Provider>().update(
                      oldsAnimals.id,
                      edtName.text,
                      edtSpecies.text,
                    ),
                Navigator.pop(context)
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
