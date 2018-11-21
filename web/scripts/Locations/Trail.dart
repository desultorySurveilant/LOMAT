import '../SoundControl.dart';
import '../Wagon.dart';
import 'Layers/ParallaxLayers.dart';
import 'Layers/ProceduralLayer.dart';
import 'Layers/ProceduralLayerParallax.dart';
import 'MenuItems/MenuHolder.dart';
import 'PhysicalLocation.dart';
import 'Road.dart';
import 'dart:async';
import 'dart:html';

import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';

//eventually subclasses will have events and shit hwatever, not doing now
class Trail extends PhysicalLocation {
    List<ParallaxLayer> paralaxLayers = new List<ParallaxLayer>();
    List<ProceduralLayerParallax> treeLayers = new List<ProceduralLayerParallax>();
    Wagon wagon;
    int numTrees = 8;
    Colour groundColor = new Colour.fromStyleString("#6aa7de");
    //lets you know where you are going and how long it will take to get there and what events will be there.
    Road road;

  Trail(Road this.road,PhysicalLocation prev) : super(prev);



  @override
  void init() {
      new Timer(new Duration(milliseconds: road.travelTimeInMS), () => arrive());
      //TODO have bg layer match town you left from
      paralaxLayers.add(new ParallaxLayerLooping(road.bg, this, 1,1));
      DivElement ground = new DivElement()..style.backgroundColor = groundColor.toStyleString();
      container.append(ground);
      //StaticLayer.styleLikeStaticLayer(ground,5,800,300,0,300);
      Random rand = new Random();
      //TODO eventually how wooded an area will be will be determined by location
      numTrees = rand.nextIntRange(1,13);
      ground.classes.add("ground");
      for(int i = 0; i<numTrees; i++) {
          treeLayers.add(ProceduralLayerParallax.spawnTree(this,rand.nextInt()));
      }

      //TODO figure out the right speed for things its being weird
      paralaxLayers.add(new ParallaxLayerLooping("images/BGs/mist1.png", this, 5,5));

      paralaxLayers.add(new ParallaxLayerLooping("images/BGs/mist0.png", this, 33,10));
      paralaxLayers.add(new ParallaxLayerLooping("images/BGs/mist2.png", this, 1000,13));
      wagon = new Wagon(this.container);

      menu = new MenuHolder(parent,this);
      createMenuItems();

      Element labelElement = new DivElement()..text = "${road.label}}"..classes.add("townLable");
      container.append(labelElement);

  }

  void arrive() {
      SoundControl.instance.playSoundEffect("Dead_Jingle_light");
      paralaxLayers.forEach((ParallaxLayer layer) {
          layer.removeMePlease = true;
      });

      treeLayers.forEach((ProceduralLayerParallax layer) {
          layer.removeMePlease = true;
      });
      teardown();
      road.destinationTown.prevLocation = this;
      road.destinationTown.displayOnScreen(parent);

  }

    void createMenuItems() {
        if(prevLocation != null) {
            menu.addBack();
        }
    }
  @override
  String get bg => road.bg;
}
