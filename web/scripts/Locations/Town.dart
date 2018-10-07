import 'Layers/ProceduralLayer.dart';
import 'Layers/StaticLayer.dart';
import 'PhysicalLocation.dart';
import 'dart:html';

import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';

//A town has a list of npcs, a pop up when entering the town
//and a list of 'dialogue' options talk/trade/travel/hunt
//a town is also not parallax
//but might have gently wobbling mist (like hunting?)

class Town extends PhysicalLocation {
    Random rand = new Random();
    int numTrees = 3;
    String name = "city2";
    //what text displays when you show up in a town.
    //think about fallen london
    String introductionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lobortis in purus non egestas. Aliquam erat volutpat. Aenean luctus tellus purus, non ultrices augue sagittis ut. Morbi ac luctus mauris, blandit euismod magna. Sed mauris nisi, feugiat eu accumsan sit amet, elementum eget orci. Nullam vel magna at leo feugiat sagittis. Praesent convallis vel lectus et convallis. Cras vel imperdiet eros. Sed interdum efficitur malesuada. Morbi iaculis ex dolor, sed rutrum eros malesuada a. Proin vel ligula id mi euismod vestibulum ac non augue. Praesent aliquam dui vel neque vehicula feugiat. <br><br>Praesent nec accumsan enim. Duis euismod, risus tincidunt efficitur vulputate, orci dui feugiat lorem, non pretium lorem erat sed odio. Quisque semper ipsum mauris, sit amet tincidunt tortor efficitur in. Donec ultricies nisl eget sapien posuere, vitae pellentesque elit mollis. Suspendisse vitae augue sapien. Vivamus cursus vehicula blandit. Sed eu sem ac nulla porttitor malesuada. Suspendisse et laoreet ipsum. In eget viverra magna, id dignissim est. Cras a augue blandit, fermentum justo ac, fermentum lectus.";
    Element flavorTextElement;
    List<StaticLayer> layers = new List<StaticLayer>();
  Town(Element parent) : super(parent);


  @override
  void init() {
      rand.setSeed(name.length);
      layers.add(new StaticLayer("images/BGs/SimpleSnowyPlainsLomat.png", this, 1));
      layers.add(new StaticLayer("images/BGs/${name}.png", this, 1));
      showFlavorText();
  }

  void showFlavorText() {
        flavorTextElement = new DivElement();
        flavorTextElement.classes.add("flavorText");
        flavorTextElement.setInnerHtml(introductionText);
        container.append(flavorTextElement);
  }
}