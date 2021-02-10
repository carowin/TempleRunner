package com.sar.templerunner_android.GameLogic;

import android.content.res.Resources;


public class SimpleRoad extends Block {


    /**
     * @param color color of the pain to use exemple Color.YELLOW
     */
    public SimpleRoad(int x, int y, int blockSize, int color , Resources res) {
        super(x, y, blockSize , color,res);
    }

    @Override
    public boolean detectCollision(Player p) { return false; }
}
