/*
  Sabrina Karen
*/

import 'package:mobx/mobx.dart';
part 'item_controller.g.dart';

class ItemController = ItemControllerBase with _$ItemController;

abstract class ItemControllerBase with Store {

  ItemControllerBase(this.title);

  final title;

  @observable
  bool status = false;

  void changeStatus(bool value) => status = value;

}