/*
  Sabrina Karen
*/

import 'package:mobx/mobx.dart';
import 'package:mobx_login/home/item_controller.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {

  @observable
  String newItem = "";

  @action
  void addNewItem(String value) => newItem = value;

  ObservableList<ItemController> taskList = ObservableList<ItemController>();

  @action
  void addItemInList() {
    taskList.add(ItemController(newItem));
    print(taskList);
  }

}