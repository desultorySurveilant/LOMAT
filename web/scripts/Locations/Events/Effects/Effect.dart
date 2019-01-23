import '../../Road.dart';

abstract class Effect {
    String name = "abstractEffect";
    int amount;
    String get flavorText =>  "Nothing happens, but $amount big anyways.";
    //your road will handle this
    void apply(Road road);

    //override this if there are some situations it doens't make sense for you to happen
    //such as it not making sense to target a party member if you don't HAVE a party
    bool isValid(Road road) {
        return true;
    }
}