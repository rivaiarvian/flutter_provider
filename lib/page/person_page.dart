import 'package:d_input/d_input.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_testing/provider/person_provider.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    final edtName = TextEditingController();
    final edtAge = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Person'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: DInput(
                  controller: edtName,
                  fillColor: Colors.blue[100],
                  hint: 'Name',
                ),
              ),
              IconButton(
                onPressed: () {
                  DMethod.log('-' * 40);
                  context.read<PersonProvider>().updateName(edtName.text);
                },
                icon: Icon(Icons.save),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: DInput(
                  controller: edtAge,
                  fillColor: Colors.blue[100],
                  hint: 'Age',
                ),
              ),
              IconButton(
                onPressed: () {
                  String ageText = edtAge.text.trim();
                  if (ageText.isNotEmpty && int.tryParse(ageText) != null) {
                    DMethod.log('-' * 40);
                    context
                        .read<PersonProvider>()
                        .updateAge(int.parse(ageText));
                  } else {
                    // Jika nilai tidak valid, beri tahu pengguna
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Usia harus berupa bilangan bulat.'),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.save),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Builder(builder: (context) {
            DMethod.log('Build Name');
            String name =
                context.select((PersonProvider value) => value.data.name);
            return Text('Name : $name');
          }),
          Builder(builder: (context) {
            DMethod.log('Build Age');
            int age = context.select((PersonProvider value) => value.data.age);
            return Text('Age : $age');
          })
        ],
      ),
    );
  }
}
