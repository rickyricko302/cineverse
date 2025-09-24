import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:netxlif/core/theme.dart';
import 'package:netxlif/features/error/presentations/providers/error_home_provider.dart';
import 'package:netxlif/features/home/presentations/widgets/list_genre.dart';
import 'package:netxlif/features/home/presentations/widgets/list_now_playing.dart';
import 'package:netxlif/features/home/presentations/widgets/list_popular.dart';
import 'package:netxlif/features/home/presentations/widgets/list_upcoming.dart';
import 'package:netxlif/features/home/presentations/widgets/welcome_area.dart';

import '../../../error/presentations/no_connection_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    ref.listenManual(errorHomeProvider, (previous, next) {
      if (next is AsyncError) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NoConnectionScreen(
              onRetry: () {
                ref.read(errorHomeProvider.notifier).retryGet();
              },
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              centerTitle: false,
              backgroundColor: Colors.black,
              title: Text('Cineverse', style: textTheme.titleLarge),
              actions: [
                IconButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(focusNode);
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                WelcomeArea(focusNode: focusNode),
                const ListPopular(),
                Gap(20),
                const ListNowPlaying(),
                Gap(20),
                const ListGenre(),
                Gap(20),
                const ListUpcoming(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
