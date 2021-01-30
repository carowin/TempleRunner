package com.sar.templerunner_android.GameLogic;

import android.graphics.Point;
import android.graphics.Rect;

public abstract class Block {

    private Rect rect;

    public Block(int screenX, int screenY , int topOfRect){

    }

    /**
     *
     * @return True if the player lose the game
     */
    public abstract boolean isBlocked(Point pos , int player_pos);



    public void setNewPos(Point p1,Point p2,Point p3,Point p4){

    }

    public Rect getRect() {
        return rect;
    }

}
