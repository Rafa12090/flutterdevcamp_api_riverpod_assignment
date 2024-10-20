import 'package:assignment_flutter_devcamp_api_riverpod/providers/card_providers.dart';
import 'package:assignment_flutter_devcamp_api_riverpod/screens/card_detail_screen.dart';
import 'package:assignment_flutter_devcamp_api_riverpod/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CardSearchScreen extends ConsumerStatefulWidget {
  final String name;

  const CardSearchScreen({super.key, required this.name});

  @override
  CardSearchPageState createState() => CardSearchPageState();
}

class CardSearchPageState extends ConsumerState<CardSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    if (widget.name.isNotEmpty) {
      _searchController.text = widget.name;
      _searchCards(widget.name);
    }
  }

  Future<void> _searchCards(String name) async {
    setState(() {
      _searchQuery = name;
      _isSearching = name.isNotEmpty; // Cambiar el estado de búsqueda
    });
  }

  @override
  Widget build(BuildContext context) {
    // Usar el provider correcto basado en si estamos buscando o no
    final cardAsyncValue = _isSearching
        ? ref.watch(cardByNameProvider(_searchQuery))
        : ref.watch(allCardsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yu-Gi-Oh! Card Search'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBarWidget(
              searchController: _searchController,
              onSearch: () {
                _searchCards(_searchController.text);
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: cardAsyncValue.when(
                data: (cards) {
                  if (_isSearching) {
                    // Cuando se busca una sola carta
                    final card = cards as Map<String, dynamic>;

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        // Calcular el ancho para que coincida con el del GridView
                        final width = (constraints.maxWidth - 20) / 2; // Simula dos columnas
                        final height = width * 1.38; // Mantener la proporción 0.72

                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CardDetailScreen(
                                      id: card['id'].toString()),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: width, // Ancho calculado
                              height: height, // Altura basada en el ancho
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.amberAccent, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.black87, // Fondo oscuro
                                elevation: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(8.0),
                                      child: Image.network(
                                        card['card_images'][0]
                                            ['image_url_small'],
                                        fit: BoxFit.cover,
                                        height: height * 0.6, // Ajuste de altura
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        card['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Colors.amberAccent, // Texto dorado
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        card['type'],
                                        style: const TextStyle(
                                          color: Colors.white70, // Texto gris claro
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    // Mostrar todas las cartas, retorna una lista
                    final cardList = cards as List<dynamic>;

                    if (cardList.isEmpty) {
                      return const Center(child: Text('No cards found.'));
                    }

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72, // Mantener proporción
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: cardList.length,
                      itemBuilder: (context, index) {
                        final card = cardList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CardDetailScreen(id: card['id'].toString()),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.amberAccent, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.black87, // Fondo oscuro
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    card['card_images'][0]['image_url_small'],
                                    fit: BoxFit.cover,
                                    height: 120,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    card['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amberAccent, // Texto dorado
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    card['type'],
                                    style: const TextStyle(
                                      color: Colors.white70, // Texto gris claro
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) =>
                    Center(child: Text('Error: ${error.toString()}')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
