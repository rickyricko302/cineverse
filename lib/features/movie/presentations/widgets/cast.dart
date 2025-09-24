import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:netxlif/features/movie/presentations/provider/credit_provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/theme.dart';

class Cast extends ConsumerWidget {
  const Cast({super.key, required this.movieId});
  final int movieId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credits = ref.watch(creditProvider(movieId: movieId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text('Cast', style: textTheme.titleMedium),
        credits.when(
          data: (credits) => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.4,
            ),
            itemCount: credits.length,
            itemBuilder: (context, index) {
              final credit = credits[index];
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Tutup'),
                            ),
                          ],
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 8,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w200${credit.profilePath}',
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Container(
                                  width: 300,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.2),
                                  ),
                                  child: Icon(Icons.person, color: Colors.red),
                                ),
                              ),
                              Text(credit.name, style: textTheme.bodyMedium),
                              Text(
                                credit.character,
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w92${credit.profilePath}',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.2),
                          ),
                          child: Icon(Icons.person, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Gap(4),
                  SizedBox(
                    child: Text(
                      credit.name,
                      style: textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gap(4),
                  SizedBox(
                    child: Text(
                      credit.character,
                      style: textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),
          error: (_, stacktrace) => Text('Error $stacktrace'),
          loading: () => Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: List.generate(
              6,
              (context) => Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Shimmer(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  Gap(4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Shimmer(
                      child: Container(
                        width: 80,
                        height: 10,
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  Gap(4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Shimmer(
                      child: Container(
                        width: 60,
                        height: 10,
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
