import 'Layers/StaticLayer.dart';
import 'package:CommonLib/Random.dart';

class TownGenome {
    //its a hash so i can do genetic combination of towns because what can i say i love genetic algorithms
    //TODO if it turns out all the values are strings just make 'em strings
    Map<String, dynamic> genes;
    Random rand;
    static String imagesLocationBase = "images/BGs/Towns/";
    static String backgroundBase = "${imagesLocationBase}/backgrounds/";
    static String groundBase = "${imagesLocationBase}/grounds/";
    static String midgroundBase = "${imagesLocationBase}/midgrounds/";
    static String foregroundBase = "${imagesLocationBase}/foregrounds/";
    static int maxBGs = 3;
    static int maxGs =2;
    static int maxMGs = 2;
    static int maxFGs = 2;
    static String BGIMAGEKEY = "backgroundImgLoc";
    static String GROUNDKEY = "groundImgLoc";
    static String MIDGROUNDKEY = "midgroundImgLoc";
    static String FOREGROUNDKEY = "foregroundImgLoc";




    //lets you take in a list of genes for premade towns
    TownGenome(Random this.rand,Map<String, dynamic> this.genes) {
        if(rand == null) rand = new Random();
        if(genes == null) init();
    }

    void init() {
        genes = new Map<String, dynamic>();
        genes[BGIMAGEKEY] = randomBackground(rand);
        genes[GROUNDKEY] = randomGround(rand);
        genes[MIDGROUNDKEY] = randomMidground(rand);
        genes[FOREGROUNDKEY] = randomForeground(rand);
        //TODO should there be any mist??? animated gif??? ask artists
    }

    //to draw: village, farm, train station, carnival, mine, port, logging station (with no trees), stonehenge???
    //premade towns: null town, consequenceville, glacier town
    //later towns have sail decorations cuz they alchemized the hive
    static String randomBackground(Random rand) {
        int fileNumber = rand.nextIntRange(1,maxBGs);
        print('bg number is $fileNumber');
        return "$backgroundBase$fileNumber.png";
    }

    static String randomGround(Random rand) {
        int fileNumber =  rand.nextIntRange(1,maxGs);
        return "$groundBase$fileNumber.png";
    }

    static String randomMidground(Random rand) {
        int fileNumber =  rand.nextIntRange(1,maxMGs);
        return "$midgroundBase$fileNumber.png";
    }

    static String randomForeground(Random rand) {
        //can be zero
        int fileNumber =  rand.nextInt(maxFGs);;
        return "$foregroundBase$fileNumber.png";
    }
}
