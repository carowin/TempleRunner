package com.sar.templerunner_android.GameLogic;

import android.content.res.Resources;
import android.graphics.Canvas;
import android.graphics.Color;
import android.util.Log;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Stack;

public class Road {
    private List<Block> mainRoad = new ArrayList<>();
    private List<Block> sideRoad = new ArrayList<>();

    private Stack<Block> obstacles = new Stack<>();

    private List<Coin> coins = new ArrayList<>();

    /** size of one blocks */
    private int BlockSize;
    private final int NB_COIN = 10;
    // a tester pour le découpage de l'ecran
    private final int diviseur = 10;
    private boolean done = false;
    private Random r = new Random();
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

        for (int pos =-BlockSize;pos<screenY;pos+=BlockSize) {
            mainRoad.add(new SimpleRoad(x, pos, BlockSize, screenY, res));
         }

        // Ajout des obstacles
        obstacles.add(new RoadRock(x,0,BlockSize, screenY,res));
        obstacles.add(new Branch(x,0,BlockSize, screenY,res));
        obstacles.add(new SideBranch(x,0,BlockSize, screenY,false,res));
        obstacles.add(new SideBranch(x,0,BlockSize, screenY,true,res));


        //obstacles.get();
        //Ajout des pieces
          for (int i= 0 ;i < NB_COIN ; i++)
                coins.add(new SimpleCoin(x,0,BlockSize/4,screenY,res));



    }
    /** 
        c.save(Canvas.MATRIX_SAVE_FLAG);
    */


    public void upDateRoad(Canvas c){
       // Log.d("myTag", "Y = " +mainRoad.size());
        //Log.d("int", ""+r.nextInt(100));

        AddObstacles();

        if (!done && r.nextInt(800) == 0){
            //cree deux route gauche / droite
            //mettre le boolean a true
            //c.save(Canvas.MATRIX_SAVE_FLAG);
            //c.rotate(90);
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
        //c.restore();
    }

    private void AddObstacles(){
        //utiliser un iterator
        boolean isOutObstacle = false;
        for (Block b: mainRoad) {
            if(b.getY()+1 >= screenY && !(b instanceof SimpleRoad)){
                b.setY(0);
                obstacles.add(mainRoad.get(mainRoad.indexOf(b)));
                mainRoad.remove(b);
                isOutObstacle = true;
                break;
            }
        }
        if(!isOutObstacle){
            return;
        }
        //Ajouter une chance d'avoir un obstacles
        if (r.nextInt(1) == 0){
            Block b = obstacles.pop();
            mainRoad.add(b);
        }
    }
}
