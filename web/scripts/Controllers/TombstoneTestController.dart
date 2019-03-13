import '../AnimationObject.dart';
import '../CipherEngine.dart';
import '../Locations/HuntingGrounds.dart';
import '../NPCs/Disease.dart';
import '../NPCs/Tombstone.dart';
import 'dart:html';

DivElement div = querySelector('#output');
void main()  async{
    await testDisease();
    testCiphers();
    testAnimation();
    testTombstone();
}

Future<Null> testDisease() async {
    Element otherTest = new DivElement()..text = "TODO: some disease shit";
    Disease disease = await Disease.generateProcedural(13);
    otherTest.text = "${disease.name} ${disease.description}. Looks rough. It's doing ${disease.power} damage per tick, and will last for ${disease.remainingDuration} ticks.";
    div.append(otherTest);

}

void testCiphers() {
    Element otherTest = new DivElement()..text = "it is not the Titan, nor the Reaper.";
    div.append(otherTest);
    CipherEngine.applyRandom(otherTest);
}

void testAnimation() {
    for(int i = 0; i<2; i++) {
        GullAnimation gull = new GullAnimation("pimp");
        gull.frameRateInMS = 20*i+20;
        div.append(gull.element);
    }

}

void testTombstone() {
    Tombstone t = new Tombstone();
    t.drawSelf(div,null);
}