package com.sar.templerunner_android.GameLogic;

import android.graphics.Canvas;
import android.graphics.Color;

import java.util.ArrayList;
import java.util.List;

public class Road {
    private List<Block> mainRoad = new ArrayList<>();

    /** size of one blocks */
    private int BlockSize;

    // a tester pour le découpage de l'ecran
    private final int diviseur = 10;

    public Road(int screenX, int screenY){
        BlockSize = screenX /diviseur;
        for (int pos =0;pos<diviseur;pos+=BlockSize)
            mainRoad.add(new SimpleRoad(screenX,screenY , pos,BlockSize, Color.YELLOW));
    }


    public void upDateRoad(Canvas c){
        for (Block b : mainRoad) {
            b.updatePosition(c);
        }
    }
}
