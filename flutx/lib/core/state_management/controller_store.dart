import 'controller.dart';

class FxControllerStore {
  static final Map<String, FxController> _controllers = {};

  static T putOrFind<T extends FxController>(T controller,
      {String? tag, bool save = true}) {
    String key = tag ?? controller.getTag();

    if (_controllers.containsKey(key) && _controllers[key] is T) {
      T controller = _controllers[key] as T;
      controller.save = controller.save && save;
      return controller;
    }
    return put(controller, tag: tag, save: save);
  }

  static T put<T extends FxController>(T controller,
      {String? tag, bool save = true}) {
    String key = tag ?? controller.getTag();

    _controllers[key] = controller;
    controller.save = controller.save && save;

    return controller;
  }

  static void delete<T extends FxController>(T controller, {String? tag}) {
    String key = tag ?? controller.getTag();

    _controllers.remove(key);
  }

  static T? pop<T extends FxController>({T? controller, String? key}){
    if(key==null && controller==null){
      return null;
    }
    key??=controller?.getTag();

    if(_controllers.containsKey(key) && _controllers[key] is T){
      T controller = _controllers[key] as T;
      _controllers.remove(key);
      return controller;
    }
    return null;
  }

  static void resetStore() {
    _controllers.clear();
  }
}
