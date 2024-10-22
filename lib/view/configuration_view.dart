import 'package:flutter/material.dart';
import 'package:gg_hanoi/model/rod.dart';
import 'package:gg_hanoi/model/disk.dart';
import 'package:gg_hanoi/values.dart';
import 'package:go_router/go_router.dart';

class ConfigurationView extends StatefulWidget {
  final String title;

  const ConfigurationView({
    super.key,
    required this.title,
  });

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _diskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: portrait ? 0.8 : 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              customSpacer(),
              TextField(
                controller: _diskController,
                decoration: const InputDecoration(
                  labelText: 'Disk',
                ),
              ),
              customSpacer(),
              ElevatedButton(
                onPressed: () {
                  List<Rod> rods = [
                    Rod(
                      color: Colors.yellow,
                      disks: List.generate(
                        int.parse(_diskController.text),
                        (index) {
                          return Disk(
                            color: Colors.yellow,
                            size: (index + 1) * 20,
                          );
                        },
                      ),
                    ),
                    Rod(
                      color: Colors.blue,
                      disks: [],
                    ),
                    Rod(
                      color: Colors.red,
                      disks: [],
                    ),
                  ];

                  context.go(
                    '/game',
                    extra: rods,
                  );
                },
                child: const Text('Start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
