import '../../Road.dart';
import 'Effect.dart';

class ArriveEffect extends Effect {
    @override
    String name = "ArriveEffect";
    @override
    int amount;

    @override
    String get flavorText =>  "You somehow slip in the cracks of reality and arrive immediatly at your destination.";

    ArriveEffect(int this.amount);

  @override
  void apply(Road road) {
    print("applying arrive effect.");
    road.applyArriveEffect();
  }
}