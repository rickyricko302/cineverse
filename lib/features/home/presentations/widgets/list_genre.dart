import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:netxlif/features/movie/presentations/provider/genre_provider.dart';
import 'package:netxlif/features/movie/presentations/provider/selected_genre_provider.dart';
import 'package:netxlif/shared_widgets/genre_button.dart';
import 'package:netxlif/shared_widgets/select_genre_listener.dart';
import 'package:netxlif/shared_widgets/shimmer_genre_movie.dart';

import '../../../../core/theme.dart';

class ListGenre extends ConsumerWidget {
  const ListGenre({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genres = ref.watch(genreProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Genres', style: textTheme.titleMedium),
          Gap(4),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: genres.when(
              data: (data) => List.generate(
                data.length,
                (index) => GenreButton(
                  genre: data[index],
                  valueChanged: (value) {
                    ref
                        .read(selectedGenreProvider(label: 'home').notifier)
                        .toggle(genre: data[index], isSelected: value);
                  },
                ),
              ),
              error: (error, stack) {
                return [
                  Center(
                    child: Text(
                      'Error: $error',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.red),
                    ),
                  ),
                ];
              },
              loading: () => List.generate(8, (_) => ShimmerGenreMovie()),
            ),
          ),
          SelectGenreListener(label: 'home'),
        ],
      ),
    );
  }
}
