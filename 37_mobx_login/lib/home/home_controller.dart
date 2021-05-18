/*
  Sabrina Karen
*/

import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {

  @observable
  String newItem = "";

  @action
  void addNewItem(String value) => newItem = value;

  ObservableList<String> taskList = ObservableList();

  @action
  void addItemInList() {
    taskList.add(newItem);
    print(taskList);
  }

}