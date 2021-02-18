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
    private List<Block> sideRoad = new ArrayList<>();
    private List<Coin> coins = new ArrayList<>();
    /** size of one blocks */
    private int BlockSize;
    private final int NB_COIN = 10;
    // a tester pour le découpage de l'ecran
    private final int diviseur = 10;
    private Random r = new Random();
    private boolean done = false;
    Resources res;
    private int screenX, screenY;
    public Road(int screenX, int screenY , Resources res){
      //  Log.d("myTag", "X = " +screenX);
       // Log.d("myTag", "Y = " +screenY);
        this.res = res;
        this.screenX = screenX;
        this.screenY = screenY;
        BlockSize = screenY /diviseur;
        int x = screenX/3;
        for (int pos =-BlockSize;pos<screenY;pos+=BlockSize)
            if(r.nextBoolean())
                mainRoad.add(new SimpleRoad(screenX/3,pos,BlockSize, screenY,res));
            else if(r.nextBoolean())
                mainRoad.add(new RoadRock(screenX/3,pos,BlockSize, screenY,res));
                else
                mainRoad.add(new branch(screenX/3,pos,BlockSize, screenY,res));
          for (int i= 0 ;i < NB_COIN ; i++){
            if(i%2 == 0)
                coins.add(new SimpleCoin(x,0,BlockSize/4,screenY,res));
            else
                coins.add(new RedCoin(x,0,BlockSize/4,screenY,res));
        }

    }


    public void upDateRoad(Canvas c){
       // Log.d("myTag", "Y = " +mainRoad.size());
        Log.d("int", ""+r.nextInt(100));
        if (!done && r.nextInt(800) == 0){
            //cree deux route gauche / droite
            //mettre le boolean a true
            done = true;
            for (int i = 0 ; i < screenX/BlockSize + 1 ; i++) {
                sideRoad.add(new SimpleRoad(i*BlockSize,-BlockSize,BlockSize, screenY,res));
            }
        }
        if (done){
            for (Block b : mainRoad){
                if (b.y >= sideRoad.get(0).y)
                    b.updatePosition(c);
            }

        } else {
            for (Block b : mainRoad)
                b.updatePosition(c);
        }

        for (Block b : sideRoad)
            b.updatePosition(c);

    }
}
