import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:netxlif/features/movie/presentations/screens/search_movie_screen.dart';

import '../../../../core/theme.dart';

class WelcomeArea extends StatefulWidget {
  const WelcomeArea({super.key, required this.focusNode});
  final FocusNode focusNode;

  @override
  State<WelcomeArea> createState() => _WelcomeAreaState();
}

class _WelcomeAreaState extends State<WelcomeArea> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 75),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.4),
            blurRadius: 20,
            spreadRadius: 4,
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/images/red-image.png'),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's go,",
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black, blurRadius: 10)],
            ),
          ),
          Text(
            "Find thousands of your favorite movies here easily and quickly.",
            style: textTheme.titleMedium,
          ),
          Gap(20),
          TextField(
            controller: _controller,
            focusNode: widget.focusNode,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.5),
              hintText: "Search movies by keywords",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                style: IconButton.styleFrom(backgroundColor: Colors.white),
                onPressed: _goSearchPage,
                icon: Icon(Icons.arrow_right_alt, color: Colors.black),
              ),
            ),
            onSubmitted: (value) => _goSearchPage(),
          ),
        ],
      ),
    );
  }

  void _goSearchPage() {
    final query = _controller.text;
    log(query);
    if (query.isEmpty || query.length <= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Search keywords must not be empty and more than 3 letters',
            style: textTheme.bodyMedium?.copyWith(color: primaryColor),
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SearchMovieScreen(query: query),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
