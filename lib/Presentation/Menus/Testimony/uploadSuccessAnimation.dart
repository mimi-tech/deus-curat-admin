import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:flutter/material.dart';

class UploadSuccessAnimation extends StatefulWidget {
  const UploadSuccessAnimation({super.key});

  @override
  _UploadSuccessAnimationState createState() => _UploadSuccessAnimationState();
}

class _UploadSuccessAnimationState extends State<UploadSuccessAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.elasticOut,
        ),
      ),
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration:  BoxDecoration(
          color: kOrangeColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}



class UploadInProgressIndicator extends StatefulWidget {
  @override
  _UploadInProgressIndicatorState createState() =>
      _UploadInProgressIndicatorState();
}

class _UploadInProgressIndicatorState extends State<UploadInProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _colorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.green).animate(_controller);
    _sizeAnimation = Tween(begin: 20.0, end: 50.0).animate(_controller);

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: _sizeAnimation.value,
          height: _sizeAnimation.value,
          child: CircularProgressIndicator(
            valueColor: _colorAnimation,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

