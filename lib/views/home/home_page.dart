import 'package:flutter/material.dart';
import 'package:pokedex/views/home/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        controller.getAll(
          context,
          int.parse(textController.text),
          1,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 5,
              left: 12,
              right: 12,
              bottom: 5,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFFCC01),
            ),
            child: Row(children: [
              Expanded(
                child: Text(
                  "Pokedéx",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                color: Colors.white,
                child: DropdownMenu(
                  controller: textController,
                  initialSelection: 1,
                  width: 90,
                  onSelected: (value) {},
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 20, label: "20"),
                    DropdownMenuEntry(value: 35, label: "35"),
                    DropdownMenuEntry(value: 50, label: "50"),
                  ],
                ),
              )
            ]),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: controller,
              builder: (context, _) {
                return controller.loading
                    ? CircularProgressIndicator(
                        color: Color(0xFFFFCC01),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              controller.pokemons.length,
                              (index) {
                                var pokemon = controller.pokemons[index];
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),
                                  color: Colors.red,
                                  child: Text(
                                    pokemon?.name ?? "Teste",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
