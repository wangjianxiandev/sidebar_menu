import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  final List<String> imageUrls = [
    "assets/imagecar.jpg",
    "assets/imagecar.jpg",
    "assets/imagecar.jpg"
  ];
  final TextStyle textStyle =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300);
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _pagescaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  SwiperController _swiperController;

  @override
  void initState() {
    super.initState();
    // 初始化动画控制器
    _controller = AnimationController(vsync: this, duration: duration);
    // 初始化banner控制器
    _swiperController = SwiperController();
    _swiperController.autoplay = true;
    // 初始化page缩放动画，从1.0缩小至0.8
    _pagescaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    // 初始化menu缩放动画，从0.5放大至1.0
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    // 初始化page平移动画，从-1水平移至0
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[menu(context), homePage(context)],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // 设置用户头像部分
                      Expanded(
                          child: UserAccountsDrawerHeader(
                            margin: EdgeInsets.only(top: 48),
                        accountName: Text("wjxbless"),
                        accountEmail: Text("xxx@qq.com"),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://profile.csdnimg.cn/B/0/A/1_qq_39424143"),
                        ),
                        decoration: BoxDecoration(color: backgroundColor),
                      ))
                    ],
                  ),
                  // 设置navigation
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "我的空间",
                      style: textStyle,
                    ),
                    onTap: () {
                      setState(() {
                        if (isCollapsed) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                        isCollapsed = !isCollapsed;
                      });
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.people,
                      color: Colors.white,
                    ),
                    title: Text(
                      "用户中心",
                      style: textStyle,
                    ),
                    onTap: () {
                      setState(() {
                        if (isCollapsed) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                        isCollapsed = !isCollapsed;
                      });
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: Text(
                      "设置中心",
                      style: textStyle,
                    ),
                    onTap: () {
                      setState(() {
                        if (isCollapsed) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                        isCollapsed = !isCollapsed;
                      });
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                onTap: () {
                  setState(() {
                    if (isCollapsed) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                    isCollapsed = !isCollapsed;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget homePage(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      child: ScaleTransition(
        scale: _pagescaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            if (isCollapsed) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }
                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text(
                        "Slide Menu Demo",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 200,
                    child: Swiper(
                      autoplayDelay: 5000,
                      controller: _swiperController,
                      itemHeight: 200,
                      pagination: pagination(),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(
                          imageUrls[index],
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: imageUrls.length,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "Hello",
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "world",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          "1:30PM",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 16,
                      );
                    },
                    itemCount: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 设置banner的标题，以及指示器
  SwiperPagination pagination() => SwiperPagination(
      margin: EdgeInsets.all(0.0),
      builder: SwiperCustomPagination(
          builder: (BuildContext context, SwiperPluginConfig config) {
        return Container(
          color: Color(0x599E9E9E),
          height: 40,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: <Widget>[
              Text(
                "title",
                style: TextStyle(fontSize: 12.0, color: Colors.white),
              ),
              Expanded(
                flex: 1,
                child: new Align(
                  alignment: Alignment.centerRight,
                  child: new DotSwiperPaginationBuilder(
                          color: Colors.black12,
                          activeColor: backgroundColor,
                          size: 6.0,
                          activeSize: 6.0)
                      .build(context, config),
                ),
              )
            ],
          ),
        );
      }));
}
