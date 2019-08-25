import 'package:flutter/material.dart';
import 'package:test_online/math.dart';
import 'screens/account.dart';
import 'screens/settings.dart';
import 'math.dart';
import 'chinese.dart';
import 'english.dart';
import 'other.dart';

class NavigationIconView {
  // 创建两个属性，一个是 用来展示 icon， 一个是动画处理
  final BottomNavigationBarItem item;
  final AnimationController controller;

  // 类似于 java 中的构造方法
  // 创建 NavigationIconView 需要传入三个参数， icon 图标，title 标题， TickerProvider
  NavigationIconView({Widget icon, Widget title, TickerProvider vsync})
      : item = new BottomNavigationBarItem(
          icon: icon,
          title: title,
        ),
        controller = new AnimationController(
            duration: kThemeAnimationDuration, // 设置动画持续的时间
            vsync: vsync // 默认属性和参数
            );
}

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController controller;
  int _currentIndex = 0;
  StatefulWidget _currentPage; // 当前的显示页面
  List<NavigationIconView> _navigationViews; // 底部图标按钮区域
  List<StatefulWidget> _pageList; // 用来存放我们的图标对应的页面
  String str_menu = 'show menu context';
  @override
  void initState() {
    super.initState();
    // 初始化导航图标
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
          // icon: Icon(IconData(0xe65f,fontFamily: 'myicon')),
          icon: new Icon(
            Icons.book,
          ),
          title: new Text("数学"),
          vsync: this), // vsync 默认属性和参数
      new NavigationIconView(
          icon: new Icon(Icons.language), title: new Text("语文"), vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.mail_outline),
          title: new Text("英语"),
          vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.devices_other),
          title: new Text("其他"),
          vsync: this),
    ];

    // 给每一个按钮区域加上监听
    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }
    _pageList = <StatefulWidget>[
      new MathPage(),
      new ChinesePage(),
      new EnglishPage(),
      new OtherPage(),
    ];
    _currentPage = _pageList[_currentIndex];
  }

  Drawer getNavDrawer(BuildContext context) {
    // DrawerHeader headerChild = DrawerHeader(child: Text("Header"));
    DrawerHeader headerChild = DrawerHeader(
      padding: EdgeInsets.zero,
      /* padding置为0 */
      child: new Stack(children: <Widget>[
        /* 用stack来放背景图片 */
        new Image.asset(
          'assets/map.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        new Align(
          /* 先放置对齐 */
          alignment: FractionalOffset.bottomLeft,
          child: Container(
            height: 70.0,
            margin: EdgeInsets.only(left: 12.0, bottom: 12.0),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              /* 宽度只用包住子组件即可 */
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new CircleAvatar(
                  backgroundImage: AssetImage('assets/acount.jpg'),
                  radius: 35.0,
                ),
                new Container(
                  margin: EdgeInsets.only(left: 6.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 水平方向左对齐
                    mainAxisAlignment: MainAxisAlignment.center, // 竖直方向居中
                    children: <Widget>[
                      new Text(
                        "Tom",
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      new Text(
                        "What's up",
                        style:
                            new TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );

    AboutListTile aboutChild = AboutListTile(
        child: Text("About"),
        applicationName: "少儿在线考试系统",
        applicationVersion: "v1.0.0",
        applicationIcon: Icon(Icons.assistant_photo),
        icon: Icon(Icons.info));

    ListTile getNavItem(var icon, String s, String routeName) {
      return ListTile(
        leading: Icon(icon),
        title: Text(s),
        onTap: () {
          setState(() {
            // pop closes the drawer
            Navigator.of(context).pop();
            // navigate to the route
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    var myNavChildren = [
      headerChild,
      getNavItem(Icons.settings, "Settings", SettingsScreen.tag),
      getNavItem(Icons.home, "Home", "/"),
      getNavItem(Icons.account_box, "Account", AccountScreen.tag),
      aboutChild
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  // 定义一个空的设置状态值的方法
  void _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      backgroundColor: Colors.orange,
      selectedItemColor: Colors.white,
      items: _navigationViews
          .map((NavigationIconView navigationIconView) =>
              navigationIconView.item)
          .toList(), // 添加 icon 按钮
      currentIndex: _currentIndex, // 当前点击的索引值
      type: BottomNavigationBarType.fixed, // 设置底部导航工具栏的类型：fixed 固定
      onTap: (int index) {
        // 添加点击事件
        setState(() {
          // 点击之后，需要触发的逻辑事件
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
          _currentPage = _pageList[_currentIndex];
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        actions: <Widget>[
          new PopupMenuButton<String>(

              //这是点击弹出菜单的操作，点击对应菜单后，改变屏幕中间文本状态，将点击的菜单值赋予屏幕中间文本
              onSelected: (String value) {
                setState(() {
                  str_menu = value;
                });
              },
              //这是弹出菜单的建立，包含了两个子项，分别是增加和删除以及他们对应的值
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            '更换皮肤',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          new IconButton(
                            icon: Icon(Icons.color_lens),
                            color: Colors.orange,
                            onPressed: null,
                          )
                          // new Icon(Icons.color_lens)
                        ],
                      ),
                      value: 'change theme',
                    ),
                    PopupMenuItem(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text('增加',style: new TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                          Icon(
                            IconData(0xe6ae, fontFamily: 'myicon'),
                            color: Colors.green,
                          ),
                          // new Icon(Icons.remove_circle)
                        ],
                      ),
                      value: '这是删除',
                    ),
                    PopupMenuItem(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text('控制中心'),
                          new Icon(Icons.remove_circle)
                        ],
                      ),
                      value: 'control center',
                    ),
                    PopupMenuItem(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text('创建试卷'),
                          new Icon(Icons.remove_circle)
                        ],
                      ),
                      value: 'examination paper',
                    ),
                    PopupMenuItem(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text('载入题库'),
                          new Icon(Icons.remove_circle)
                        ],
                      ),
                      value: 'load test questions',
                    )
                  ])

          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: null,
          //   color: Colors.white,
          // ),
          // IconButton(
          //   icon: Icon(
          //     Icons.color_lens,
          //     color: Colors.white,
          //   ),
          //   onPressed: null,
          // ),
          // IconButton(
          //   icon: Icon(
          //     Icons.more_vert,
          //     color: Colors.white,
          //   ),
          //   onPressed: _create_menu,
          // )
        ],
      ),
      body: Center(
        child: _currentPage,
      ),
      bottomNavigationBar: bottomNavigationBar,
      drawer: getNavDrawer(context),
    );
  }
}
