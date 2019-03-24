import 'dart:async';
import 'dart:html';

import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Utility.dart';

import 'Game.dart';
import 'Locations/Trail.dart';

class GuideBot {
    static GuideBot _instance;
    Element button;
    bool bored = true;
    bool running = false;
    int frameRateInMillis = 1000;
    int ticksSinceLastAction = 0;

    static GuideBot get instance {
        if(_instance == null) {
            _instance = new GuideBot();
        }
        return _instance;
    }

    GuideBot() {
        _instance = this;
    }

    //if you go to long without doing anything, flip to bored
    void boredomTest() {
        ticksSinceLastAction ++;
        //print("bored: ${ticksSinceLastAction}");
        if(ticksSinceLastAction > 100) {
            bored = true;
        }
    }

    void toggle() {
        if(button == null) {
            button = querySelector("#botBotton");
        }
        if(running) {
            stop();
            button.text = "Bot";
        }else {
            run();
            button.text = "!Bot";
        }
    }

    void run() {
        running = true;
        bored = true;
        boredomLoop();
    }

    void stop() {
        running = false;
        bored = true;
    }

    void boredomLoop() {
        if(!running) {
            return;//break
        }
        clickPopups();
        boredomTest();
        if(bored) {
            bored = false;
            //TODO once hunting can be tested/escaped we can add it to this loop
            List<Action> actions = <Action>[clickTalkButton, clickTravelButton];
            new Random().pickFrom(actions)();
        }

        new Timer(new Duration(milliseconds: frameRateInMillis), () => {
            boredomLoop()
        });
    }

/*
    for now, just click on screen buttons.
 */

    //dismisses popups
    void clickPopups() {
        //clears away popups
        Game.instance.container.click();
    }

    void acceptDeath() {
        Element button = querySelector("#acceptDeath");
        print("can I accept death? ${button}");
        if(button == null) return;
        button.click();
    }

    void clickHuntButton() {
        ticksSinceLastAction = 0;
        //find a button labeled hunt
        Element button = querySelector("#huntingButton");
        if(button == null) return;
        button.click();
        //actually play the hunting mini game
    }

    void clickTravelButton() {
        ticksSinceLastAction = 0;
        //find a button labeled hunt
        Element button = querySelector("#travelButton");
        if(button == null) return;
        button.click();
        List<Element> travelOptions = querySelectorAll(".travelOption");
        Random rand = new Random();
        //seriously my react learning at jorb made this syntax make WAY more sense
        new Timer(new Duration(milliseconds: frameRateInMillis), () => {
            rand.pickFrom(travelOptions).click(),
            acceptTravel()
        });
        //need to periodically click away popups and shit
    }

    void acceptTravel() {
        acceptDeath();
        //if we aren't on the trail anymore, we arrived (technically we can hunt from here but i have no clue how i wanna handle that)
        //tbh i might disable that entirely
        if(Game.instance.currentLocation != null && !(Game.instance.currentLocation is Trail)) {
            bored = true;
            return;
        }
        new Timer(new Duration(milliseconds: frameRateInMillis), () => {
            acceptTravel()
        });
    }

    void clickTalkButton(){
        ticksSinceLastAction = 0;
        //find a button labeled hunt
        DivElement button = querySelector("#talkButton");
        if(button == null) return;
        button.click();
        //TODO once the talk screen is up, click through all the text options i guess?
        //oh i see, react taught me about this
        Random rand = new Random();
        new Timer(new Duration(milliseconds: frameRateInMillis), () => {
            dialogueLoop(rand,0)
        });


    }

    void dialogueLoop(Random rand, int loop) {
        List<Element> dialogueOptions = querySelectorAll(".dialogueSelectableItem");
        if(dialogueOptions.isEmpty) {
            bored = true;
            return;
        }
        ticksSinceLastAction = 0;
        if(loop <100) {
            rand.pickFrom(dialogueOptions).click();
        }else {
            dialogueOptions.last.click(); //try to escape please
        }
        new Timer(new Duration(milliseconds: frameRateInMillis), () => {
            dialogueLoop(rand, loop+1)
        });

    }


}