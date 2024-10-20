import 'package:assignment_flutter_devcamp_api_riverpod/providers/card_providers.dart';
import 'package:assignment_flutter_devcamp_api_riverpod/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CardDetailScreen extends ConsumerWidget {
  const CardDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardDetailAsyncValue = ref.watch(cardDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Detail'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: cardDetailAsyncValue.when(
        data: (card) => CardItem(card: card),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
    );
  }
}
