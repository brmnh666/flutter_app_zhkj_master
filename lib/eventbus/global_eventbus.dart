import 'package:event_bus/event_bus.dart';

/*首先我们需要定义一个EventBus对象来订阅事件流.这里我们通过一个工厂方法来创建一个唯一的EventBus对象.*/
class GlobalEventBus{
  EventBus eventBus;
  factory GlobalEventBus()=>_getInstance();
  static GlobalEventBus get instance =>_getInstance();
  static GlobalEventBus _instance;

  GlobalEventBus._internal(){
    eventBus=EventBus();
  }

  static GlobalEventBus _getInstance() {
    if (_instance == null) {
      _instance = GlobalEventBus._internal();
    }
    return _instance;
  }

}

class StateChangeEvent{
  String state;
  StateChangeEvent(this.state);
}

