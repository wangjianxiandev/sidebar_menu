import 'package:flutter/material.dart';

class SlideTransitionAnimationWidget extends StatefulWidget {
  @override
  SlideTransitionAnimationWidgetState createState() => new SlideTransitionAnimationWidgetState();
}

class SlideTransitionAnimationWidgetState extends State<SlideTransitionAnimationWidget>
    with SingleTickerProviderStateMixin {
  final Duration _duration = const Duration(milliseconds: 3000);
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _scaleAnimation;
  Animation<double> _fadeAnimation;
  Animation<double> _rotationAnimation;
  Animation<double> _curveAnimation;
  final _opacityTween = Tween<double>(begin: 0.1 ,end: 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text('SlideTransition'),
      ),
      body: Center(
        // 做相应动画可以直接修改此处，看下源码动画的参数是什么即可
        child: SlideTransition(
          // 计算差值,就相当于在自定义的插值器前面设置一个数值转换器
          // 将透明度的设置和弹跳的插值器结合，evaluate作用是使得弹跳的进度即为透明度设置的进度
//          opacity : _opacityTween.evaluate(_curveAnimation),
//          scale: _scaleAnimation,
//        turns: _rotationAnimation,
        position: _slideAnimation,
          child: Container(
            height: 100,
            width: 100,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(_controller);
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _rotationAnimation = Tween<double>(begin: 0.0, end: 15.0).animate(_controller);
    _curveAnimation = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller)
          ..addListener(() {
            // AnimationController产生的数值取决于屏幕刷新情况，一秒60帧
            // 数值生成之后，每个Animation对象都会通过Listener进行回调，下面实现动画监听
            setState(() {
              print(_slideAnimation.value);
            });
          })
          ..addStatusListener((status) {
            // 实现动画循环
            if (status == AnimationStatus.completed) {
              // 正向结束时回调
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              // 反向执行 结束时会回调此方法
              _controller.forward();
            }
          });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
