import 'TalkyItem.dart';
import 'TalkyLevel.dart';
import 'dart:html';

class TalkyEnd extends TalkyItem {
    //for most it will just be the "go back" button, but
    //could have sub questions
    //does NOT need serialized, just sort of added in.

    TalkyEnd(TalkyLevel level) : super("Shit Go Back",level) {
        print(" Debug SubQuestions: creating a talky end with level ${level.talkyItems.length} siblings, compared to owner ${owner.talkyItems.length}");
    }

    @override
    void display(Element cont) {
        super.display(cont);
        div.setInnerHtml(">$displayText");

    }

    void onClick() {
        owner.goUpALevel(container);
    }
}