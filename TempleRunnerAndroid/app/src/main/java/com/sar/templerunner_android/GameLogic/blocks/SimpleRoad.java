package com.sar.templerunner_android.GameLogic.blocks;

import android.content.res.Resources;

import com.sar.templerunner_android.GameLogic.player.Player;


public class SimpleRoad extends Block {


    /**
     * @param screenY color of the pain to use exemple Color.YELLOW
     */
    public SimpleRoad(int x, int y, int blockSize, int screenY , Resources res) {
        super(x, y, blockSize , screenY,res);
    }

    @Override
    public boolean detectCollision(Player p) { return false; }
}
