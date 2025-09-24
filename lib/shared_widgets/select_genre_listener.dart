import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netxlif/features/movie/presentations/screens/genre_movie_screen.dart';

import '../features/movie/presentations/provider/selected_genre_provider.dart';
import 'primary_button.dart';

class SelectGenreListener extends ConsumerWidget {
  const SelectGenreListener({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGenres = ref.watch(selectedGenreProvider(label: label));
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: selectedGenres.isNotEmpty
          ? Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              child: PrimaryButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return GenreMovieScreen(label: label);
                      },
                    ),
                  );
                },
                text: 'Search by ${selectedGenres.length} genres',
              ),
            )
          : const SizedBox(),
    );
  }
}
