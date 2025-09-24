import 'package:flutter/material.dart';
import 'package:netxlif/features/movie/domain/entities/genre_entity.dart';

import '../core/theme.dart';

class GenreButton extends StatefulWidget {
  const GenreButton({
    super.key,
    required this.genre,
    required this.valueChanged,
  });
  final GenreEntity genre;
  final Function(bool) valueChanged;

  @override
  State<GenreButton> createState() => _GenreButtonState();
}

class _GenreButtonState extends State<GenreButton> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor.withValues(alpha: isSelected ? 1 : 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: primaryColor),
        ),
      ),
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.valueChanged(isSelected);
      },
      child: Text(
        widget.genre.name,
        style: TextStyle(color: isSelected ? Colors.white : primaryColor),
      ),
    );
  }
}
