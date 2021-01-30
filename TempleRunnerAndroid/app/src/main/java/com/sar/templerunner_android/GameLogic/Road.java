package com.sar.templerunner_android.GameLogic;

import android.graphics.Canvas;
import android.graphics.Color;
import android.util.Log;

import java.util.ArrayList;
import java.util.List;

public class Road {
    private List<Block> mainRoad = new ArrayList<>();

    /** size of one blocks */
    private int BlockSize;

    // a tester pour le découpage de l'ecran
    private final int diviseur = 10;

    public Road(int screenX, int screenY){
        Log.d("myTag", "X = " +screenX);
        Log.d("myTag", "Y = " +screenY);
        BlockSize = screenY /diviseur;
        for (int pos =0;pos<screenY;pos+=BlockSize)
            mainRoad.add(new SimpleRoad(screenX,screenY, pos,BlockSize, Color.YELLOW));
    }


    public void upDateRoad(Canvas c){
        for (Block b : mainRoad) {
            b.updatePosition(c);
        }
    }
}
