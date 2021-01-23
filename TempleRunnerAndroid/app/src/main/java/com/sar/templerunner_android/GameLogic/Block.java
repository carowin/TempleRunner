package com.sar.templerunner_android.GameLogic;

import android.graphics.Point;

public abstract class Block {

    private Point p1,p2,p3,p4;

    public Block(int pos, int blockSize,int screenY){
        //TO DO creation des point en fonction de c'est parametre
    }

    public Block(Point p1,Point p2,Point p3,Point p4){
        this.p1=p1;this.p2=p2;this.p3=p3;this.p4=p4;
    }

    /**
     *
     * @return True if the player lose the game
     */
    public abstract boolean isBlocked(Point pos , int player_pos);



    public void setNewPos(Point p1,Point p2,Point p3,Point p4){
        this.p1=p1;this.p2=p2;this.p3=p3;this.p4=p4;
    }


    public Point getP1() {
        return p1;
    }


    public Point getP2() {
        return p2;
    }

    public Point getP3() {
        return p3;
    }

    public Point getP4() {
        return p4;
    }




}
