package com.sar.templerunner_android.GameLogic;

import android.content.res.Resources;

public class RedCoin extends Coin{

    public RedCoin(int x, int y, int blockSize, int screenY, Resources res) {
        super(x, y, blockSize, screenY, res);
    }

    @Override
    public boolean detectCollision(Player p) {
        return false;
    }
}
