
import 'package:assignment_flutter_devcamp_api_riverpod/networking/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final allCardsProvider = FutureProvider<List<dynamic>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchAllCards();
});

final cardByIdProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, id) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchCardById(id);
});

final cardByNameProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, name) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchCardByName(name);
});

final cardsByArchetypeProvider = FutureProvider.family<List<dynamic>, String>((ref, archetype) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchCardsByArchetype(archetype);
});

final cardsWithFiltersProvider = FutureProvider.family<List<dynamic>, Map<String, String?>>((ref, filters) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchCardsWithFilters(
    level: filters['level'],
    attribute: filters['attribute'],
    sort: filters['sort'],
  );
});

final cardDetailProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, id) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.fetchCardById(id);
});

