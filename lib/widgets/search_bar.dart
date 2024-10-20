import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;

  const SearchBarWidget({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black54, 
        borderRadius: BorderRadius.circular(30), 
        border: Border.all(color: Colors.amberAccent, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), 
            blurRadius: 8,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Enter card name',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search, color: Colors.amberAccent),
            onPressed: onSearch,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        onSubmitted: (value) => onSearch(),
      ),
    );
  }
}
