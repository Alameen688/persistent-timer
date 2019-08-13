import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/pomo.dart';

class AppLifecycleManager extends StatefulWidget {
  final Widget child;

  AppLifecycleManager({@required this.child});

  @override
  _AppLifecycleManagerState createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('state = $state');
    debugPrint('${new DateTime.now().millisecond}');
    debugPrint('${new DateTime.now().millisecond}');
    debugPrint('${new DateTime.now().millisecond}');
    debugPrint('${new DateTime.now().millisecond}');
    debugPrint('${new DateTime.now().millisecond}');
    debugPrint('${new DateTime.now().millisecond}');
    debugPrint('${new DateTime.now().millisecond}');
    if (state == AppLifecycleState.paused) {
      debugPrint('pause time');
      debugPrint('${Provider
          .of<PomoModel>(context)
          .currentTime}');
      debugPrint('${new DateTime.now().millisecond}');
      debugPrint('pause time end');
      saveCurrentTime();
    }
    if(state == AppLifecycleState.resumed){
      debugPrint('resume time');
      debugPrint('${Provider
          .of<PomoModel>(context)
          .currentTime}');
      debugPrint('${new DateTime.now().millisecond}');
      debugPrint('resume time end');
      getCurrentTime();
    }
  }

  void saveCurrentTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("pauseDuration", Provider
        .of<PomoModel>(context)
        .currentTime.inMilliseconds);
    prefs.setInt("timePaused", new DateTime.now().millisecond);
  }

  void getCurrentTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int pauseDuration = prefs.getInt("pauseDuration");
    int timePaused = prefs.getInt("timePaused");
    int timeResumed = new DateTime.now().millisecond;
    debugPrint('time difference from app ${pauseDuration - Provider
        .of<PomoModel>(context)
        .currentTime.inMilliseconds}');
    debugPrint('time difference from date ${timeResumed - timePaused}');


    debugPrint('resumeTime');
    debugPrint('$pauseDuration');
    debugPrint('resumeTime end');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
