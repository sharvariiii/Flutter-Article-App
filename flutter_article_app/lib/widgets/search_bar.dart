import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const AnimatedSearchBar({super.key, required this.onChanged});

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  final TextEditingController _controller =
      TextEditingController(); // Controller to handle input
  Timer? _debounce; // Timer for debouncing search input

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to avoid memory leaks
    _debounce?.cancel(); // Cancel the debounce timer
    super.dispose();
  }

  // Handle when the search input changes with debouncing
  void _onChangedDebounced(String query) {
    if (_debounce?.isActive ?? false)
      _debounce!.cancel(); // Cancel if the debounce is active
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onChanged(
          query); // Call the callback with the query after the debounce
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 44,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(22), // Rounded corners
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(
              Icons.search_outlined,
              size: 22,
              color: Colors.grey[700],
            ),
            const SizedBox(width: 10),

            // Expandable input field for typing the search term
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: _onChangedDebounced, // Apply debounced on change
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            _controller.clear();
                            widget.onChanged('');
                            setState(() {});
                          },
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
