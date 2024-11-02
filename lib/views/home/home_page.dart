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
          int.parse(textController.text == "" ? "0" : textController.text),
          1,
        );
        controller.showPokes(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            return Column(
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
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF0070B6),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: DropdownMenu(
                        controller: textController,
                        initialSelection: 1,
                        width: 90,
                        onSelected: (value) {
                          setState(() {
                            controller.getAll(
                                context, int.parse(textController.text), 1);
                            controller.showPokes(context);
                          });
                        },
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: 20, label: "20"),
                          DropdownMenuEntry(value: 35, label: "35"),
                          DropdownMenuEntry(value: 50, label: "50"),
                        ],
                      ),
                    )
                  ]),
                ),
                controller.loading
                    ? Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFFFFCC01),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).padding.top + 5),
                        child: Expanded(
                          child: Wrap(runSpacing: 10, spacing: 10, children: [
                            ListView.builder(
                                itemCount: controller.pokemons.length,
                                itemBuilder: (_, index) {
                                  var pokemon = controller.pokemons[index];
                                  return PokemonCard(
                                    image: pokemon?.sprites?.frontDefault ?? "",
                                    name: pokemon?.name ?? "",
                                    type: pokemon?.types![0].type?.name ?? "",
                                  );
                                }),
                            /*Row(
                            children: [
                              Icon(Icons.arrow_back),
                              Icon(Icons.arrow_forward),
                            ],
                          ),*/
                          ]),
                        ),
                      ),
              ],
            );
          }),
    );
  }
}

class PokemonCard extends StatelessWidget {
  final String image;
  final String name;
  final String type;
  const PokemonCard(
      {super.key, required this.image, required this.name, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Image.network(image),
          Text(name),
          Text(type),
        ],
      ),
    );
  }
}
