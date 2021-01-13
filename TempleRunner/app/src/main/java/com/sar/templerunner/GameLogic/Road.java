package com.sar.templerunner.GameLogic;

import java.util.ArrayList;
import java.util.List;

public class Road {
    private List<Block> mainRoad = new ArrayList<>();
    private List<Block> LeftRoad = null;
    private List<Block> RightRoad = null;

    /** size of one blocks */
    private int BlockSize;

    // a tester pour le découpage de l'ecran
    private final int diviseur = 6;

    public Road(int screenX, int screenY){
        BlockSize = screenX /diviseur;
        for (int i =0;i<diviseur;i++)
            mainRoad.add(simpleRoadBlock(screenX-(BlockSize*diviseur) ,BlockSize,screenY));
    }

    public Block simpleRoadBlock(int pos , int blockSize , int screenY){
        return new SimpleRoadBlock(pos,blockSize,screenY);
    }

}
