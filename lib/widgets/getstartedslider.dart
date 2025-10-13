import 'package:coffeshop/models/hero.dart';
import 'package:flutter/material.dart';

class GetStartedSlider extends StatefulWidget {
  const GetStartedSlider({super.key, required this.model});
  final HeroModel model;
  @override
  State<GetStartedSlider> createState() => _GetStartedSliderState();
}

class _GetStartedSliderState extends State<GetStartedSlider> {
  double _dragX = 0; // arrow position
  final double _maxDrag = 207; // max slide distance

  @override
  Widget build(BuildContext context) {
    double progress = (_dragX / _maxDrag).clamp(0.0, 1.0);
    return Container(
      width: 280,
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [progress, progress],
          colors: [
            Colors.amber[900]!.withAlpha(150),
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withAlpha(70),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          const Center(
            child: Text(
              ">> Get Start",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),

          // Draggable arrow
          Positioned(
            left: _dragX,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragX += details.delta.dx;
                  if (_dragX < 0) _dragX = 0;
                  if (_dragX > _maxDrag) _dragX = _maxDrag;
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragX > _maxDrag * 0.8) {
                  widget.model.triggerShow();
                  setState(() {
                    _dragX = _maxDrag;
                  });
                } else {
                  setState(() {
                    _dragX = 0;
                  });
                }
              },
              child: Container(
                width: 65,
                height: 65,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber[900]!,
                      spreadRadius: 4,
                      blurRadius: 10,
                    ),
                  ],
                  color: Colors.amber[900],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_ios_outlined,
                    color: Colors.white), // matches your theme
              ),
            ),
          ),
        ],
      ),
    );
  }
}
