package com.sar.templerunner_android.GameLogic;

import android.content.res.Resources;
import android.graphics.Canvas;
import android.util.Log;

import com.sar.templerunner_android.GameLogic.blocks.Block;
import com.sar.templerunner_android.GameLogic.blocks.Branch;
import com.sar.templerunner_android.GameLogic.blocks.RoadRock;
import com.sar.templerunner_android.GameLogic.blocks.SideBranch;
import com.sar.templerunner_android.GameLogic.blocks.SimpleRoad;
import com.sar.templerunner_android.GameLogic.coins.Coin;
import com.sar.templerunner_android.GameLogic.coins.SimpleCoin;

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

        for (int pos =0;pos<screenY;pos+=BlockSize) {
            mainRoad.add(new SimpleRoad(x, pos, BlockSize, screenY, res));
         }

        // Ajout des obstacles
        obstacles.add(new RoadRock(x,-BlockSize,BlockSize, screenY,res));
        obstacles.add(new Branch(x,-BlockSize,BlockSize, screenY,res));
        obstacles.add(new SideBranch(x,-BlockSize,BlockSize, screenY,false,res));
        obstacles.add(new SideBranch(x,-BlockSize,BlockSize, screenY,true,res));

        //mainRoad.add(obstacles.pop());
        //Ajout des pieces
          for (int i= 0 ;i < NB_COIN ; i++)
                coins.add(new SimpleCoin(x,0,BlockSize/4,screenY,res));


    }


    public void upDateRoad(Canvas c){
        addObstacles();

        for (Block b : mainRoad)
            b.updatePosition();

      /*  int posMin = getMinPos();
        for (Block b: mainRoad) {
            if(b.getY() > screenY+BlockSize)
                b.setY(posMin-BlockSize);
        }*/

        for (Block b : mainRoad)
            b.setImage(c);
    }

    private void addObstacles(){

      boolean isOutObstacle = false;
        for (Block b: mainRoad) {
            if(b.getY() >= screenY && !(b instanceof SimpleRoad)){
                Log.d("myTag", "Y = " +obstacles.size());
                obstacles.add(mainRoad.get(mainRoad.indexOf(b)));
                mainRoad.remove(b);
                isOutObstacle = true;
                break;
            }
        }

        if(isOutObstacle)
            return;

        //Ajouter une chance d'avoir un obstacles
        if (r.nextInt(10) == 0 && obstacles.size() ==3){
            Block b = obstacles.pop();
            int min =getMinPos();
            b.setY(min);
            mainRoad.add(b);
        }
    }


    private int getMinPos(){
        int min =0;
        for (Block b_in: mainRoad)
            if(b_in.getY() < min )
                min=b_in.getY();
         return min;
    }

    public Stack<Block> getObstacles() {
        return obstacles;
    }
}
