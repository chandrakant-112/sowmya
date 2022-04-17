import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sowmya/model/TitleSwitchModel.dart';

final providerNotifier = ChangeNotifierProvider(
  (ref) => ProviderNotifier(ref),
);

class ProviderNotifier extends ChangeNotifier {
  final Ref ref;
  ProviderNotifier(this.ref);

  var hallList = [
    TitleSwitch(title: "Light", subTitle: "FAN SW", status: false),
    TitleSwitch(title: "Light", subTitle: "D-LIGHT", status: false),
    TitleSwitch(title: "Light", subTitle: "TubeLight", status: false),
    TitleSwitch(title: "RGB", subTitle: "Hall Strip", status: false),
    TitleSwitch(title: "Light", subTitle: "D-Light 5", status: false),
  ];

  var selectedList = <TitleSwitch>[];

  void addSingleTile(TitleSwitch titleSwitch){
    selectedList.add(titleSwitch);
    notifyListeners();
  }

  void removeTile(TitleSwitch titleSwitch){
    int index = selectedList.indexWhere((element) => element == titleSwitch);
    selectedList.removeAt(index);
    notifyListeners();
  }

  void switchNotifier(bool val,int index){
    hallList[index].status = val;
    notifyListeners();
  }
}
