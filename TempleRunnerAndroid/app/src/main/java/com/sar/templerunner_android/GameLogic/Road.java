package com.sar.templerunner_android.GameLogic;

import android.content.res.Resources;
import android.graphics.Canvas;
import android.graphics.Color;
import android.util.Log;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Road {
    private List<Block> mainRoad = new ArrayList<>();

    /** size of one blocks */
    private int BlockSize;

    // a tester pour le découpage de l'ecran
    private final int diviseur = 10;
    private Random r = new Random();
    public Road(int screenX, int screenY , Resources res){
      //  Log.d("myTag", "X = " +screenX);
       // Log.d("myTag", "Y = " +screenY);
        BlockSize = screenY /diviseur;
        for (int pos =-BlockSize;pos<screenY;pos+=BlockSize)
            if(r.nextBoolean())
                mainRoad.add(new SimpleRoad(screenX/3,pos,BlockSize, screenY,res));
            else if(r.nextBoolean())
                mainRoad.add(new RoadRock(screenX/3,pos,BlockSize, screenY,res));
                else
                mainRoad.add(new branch(screenX/3,pos,BlockSize, screenY,res));


    }


    public void upDateRoad(Canvas c){
        Log.d("myTag", "Y = " +mainRoad.size());
        for (Block b : mainRoad)
            b.updatePosition(c);

    }
}
