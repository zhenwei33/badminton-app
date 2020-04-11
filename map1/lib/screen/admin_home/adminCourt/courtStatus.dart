import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CourtStatus extends StatelessWidget {
  final String courtName;
  final String status;

  CourtStatus({this.courtName, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: bgColor(status),
      child: FlatButton(
        onPressed: () => _alertPopup(context),
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                text(status, courtName),
                SizedBox(height: 20),
                statusIcon(status),
                SizedBox(height: 10),
                text(status, courtName),
                SizedBox(height: 10),
                playPauseIcon(status)
              ],
            )),
      ),
    );
  }

  _alertPopup(context) {
    Alert(
        context: context,
        title: "Close court",
        style: AlertStyle(
          titleStyle: blueBold_20
        ),
        content: Column(
          children: <Widget>[
            Icon(Icons.not_interested, color: blue, size: 40,),
            SizedBox(height: 10),
            Text("$courtName", style: blueBold_14),
            Text("For how long does it close?", style: blueReg_14),
            SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  durationOption("30m"),
                  durationOption("1h"),
                  durationOption("2h"),
                  durationOption("Other"),
                ],
              ),
            )
          ],
        ),
        buttons: [
          DialogButton(
            color: blue1,
            child: Text("Cancel", style: blueReg_14,),
            onPressed: () => Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName)),
          ),
          DialogButton(
            color: blue,
            child: Text("Close", style: whiteReg_14),
            onPressed: () => Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName)),
          ),
        ]).show();
  }

  

  Widget statusIcon(status) {
    Widget _statusIcon;
    switch (status) {
      case 'Empty':
        _statusIcon = SizedBox(height: 40, width: 40);
        break;
      case 'Temporary closed':
        _statusIcon = Icon(Icons.not_interested, color: blue, size: 40);
        break;
      case 'Occupied':
        _statusIcon = Icon(Icons.person, color: Colors.white, size: 40);
        break;
    }
    return _statusIcon;
  }

  Widget playPauseIcon(status) {
    Icon _playPauseIcon;
    switch (status) {
      case 'Empty':
        _playPauseIcon = Icon(Icons.pause, color: blue, size: 30);
        break;
      case 'Temporary closed':
        _playPauseIcon = Icon(Icons.play_arrow, color: blue, size: 30);
        break;
      case 'Occupied':
        _playPauseIcon = Icon(Icons.pause, color: Colors.white, size: 30);
        break;
    }
    return _playPauseIcon;
  }

  BoxDecoration bgColor(status) {
    BoxDecoration _bgColor;
    switch (status) {
      case 'Empty':
        _bgColor = BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(15));
        break;
      case 'Temporary closed':
        _bgColor = BoxDecoration(
            color: darkGreyColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15));
        break;
      case 'Occupied':
        _bgColor =
            BoxDecoration(color: blue, borderRadius: BorderRadius.circular(15));
        break;
    }
    return _bgColor;
  }

  Widget text(status, courtName) {
    Text _text;

    switch (status) {
      case 'Empty':
        _text = Text("$courtName", style: blueReg_16);
        break;
      case 'Temporary closed':
        _text = Text("$courtName", style: blueReg_16);
        break;
      case 'Occupied':
        _text = Text("$courtName", style: whiteReg_16);
        break;
    }
    return _text;
  }

  Widget durationOption(duration) {
    return Container(
      decoration: BoxDecoration(
        color: blue1,
        borderRadius: BorderRadius.circular(15)
      ),
      width: 55,
      height: 55,
      child: FlatButton(
        padding: EdgeInsets.all(5),
        onPressed: () {},
        child: Text("$duration"),
      ),
    );
  }
}
