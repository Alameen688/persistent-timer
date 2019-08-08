import 'package:flutter/material.dart';
import 'package:fluttery_seekbar/fluttery_seekbar.dart';
import 'package:provider/provider.dart';
import 'model/pomo.dart';

final Color accent = Color(0XFFF09E8C);

class PomoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 15.0),
        child: Consumer<PomoModel>(builder: (context, timer, child) {
            debugPrint('${timer.currentTime}');
            return Column(
              children: <Widget>[TimerWidget(timer), Control(timer)],
            );
          }),
      );
}

class TimerWidget extends StatelessWidget {
  TimerWidget(this.timer);

  final timer;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 300.0,
      height: 350.0,
      child: Stack(
        children: <Widget>[_progress(timer, type: "outer"), _progress(timer)],
      ),
    ));
  }

  Widget _progress(timer, {String type}) {
    final child = Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: type == "outer"
              ? null
              : LinearGradient(colors: [accent, Color(0XFFF3D4A0)])),
      child: type == "outer"
          ? _buildRadialProgress(
              accent, !timer.isBreak ? timer.currentSessionProgress : 1.0)
          : _buildRadialProgress(
              Colors.orangeAccent,
              timer.isBreak ? timer.currentSessionProgress : 0.0,
              _ticker(timer)),
    );
    return type == "outer"
        ? child
        : Center(
            child: Container(width: 250, height: 250, child: child),
          );
  }

  Widget _buildRadialProgress(Color progressColor, double progressPercent,
          [Widget centerContent]) =>
      RadialProgressBar(
          trackWidth: 20.0,
          trackColor: Colors.teal.shade50,
          progressPercent: progressPercent,
          progressWidth: 20.0,
          progressColor: progressColor,
          centerContent: centerContent);

  Widget _ticker(timer) => Center(
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
              color: Colors.black45,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black.withOpacity(.5), blurRadius: 10.0)
              ]),
          child: Center(
            child: Text("${timer.formattedCurrentTime}",
                style: TextStyle(fontSize: 65.0, fontWeight: FontWeight.bold)),
          ),
        ),
      );
}

class Control extends StatelessWidget {
  Control(this.timer);

  final timer;

  @override
  Widget build(BuildContext context) {
    startTimer() {
      Provider.of<PomoModel>(context).start();
    }

    resetTimer() {
      Provider.of<PomoModel>(context).reset();
    }

    return Container(
      margin: EdgeInsets.only(top: 50),
      child: RaisedButton(
        elevation: 8.0,
        color: timer.isRunning ? Colors.teal.shade200 : accent,
        onPressed: timer.isRunning ? resetTimer : startTimer,
        child: Text(
          timer.isRunning ? "RESET" : "START",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              fontStyle: FontStyle.italic),
        ),
        padding: EdgeInsets.all(30.0),
        shape: CircleBorder(),
      ),
    );
  }
}
