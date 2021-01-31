package com.sar.templerunner_android.GameLogic;

import android.graphics.Point;

public class SimpleRoad extends Block {


    /**
     * @param screenX   screen on the x positions
     * @param screenY   screen on the Y positions
     * @param topOfRect Position of the top of rectangle
     * @param color color of the pain to use exemple Color.YELLOW
     */
    public SimpleRoad(int screenX, int screenY, int topOfRect,int blockSize, int color) {
        super(screenX, screenY, topOfRect,blockSize , color);
    }

    @Override
    public boolean detectCollision(Player p) { return false; }
}
