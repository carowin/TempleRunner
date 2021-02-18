package com.sar.templerunner_android.GameLogic.coins;

import android.content.res.Resources;
import android.graphics.Canvas;
import android.util.Log;

import com.sar.templerunner_android.GameLogic.SimpleCoin;
import com.sar.templerunner_android.GameLogic.blocks.Block;
import com.sar.templerunner_android.GameLogic.blocks.RoadRock;
import com.sar.templerunner_android.GameLogic.blocks.SimpleRoad;
import com.sar.templerunner_android.GameLogic.blocks.branch;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Road {
    private List<Block> mainRoad = new ArrayList<>();
    private List<Coin> coins = new ArrayList<>();
    /** size of one blocks */
    private int BlockSize;
    private final int NB_COIN = 10;
    // a tester pour le découpage de l'ecran
    private final int diviseur = 10;
    private Random r = new Random();
    public Road(int screenX, int screenY , Resources res){
      //  Log.d("myTag", "X = " +screenX);
       // Log.d("myTag", "Y = " +screenY);
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
        Log.d("myTag", "Y = " +mainRoad.size());
        for (Block b : mainRoad)
            b.updatePosition(c);

    }
}
