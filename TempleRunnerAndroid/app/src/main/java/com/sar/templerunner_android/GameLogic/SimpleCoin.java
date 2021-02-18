package com.sar.templerunner_android.GameLogic;

import android.content.res.Resources;

public class SimpleCoin extends Coin{
    public SimpleCoin(int x, int y, int coinSize, int screenY, Resources res) {
        super(x, y, coinSize, screenY, res);
    }

    @Override
    public boolean detectCollision(Player p) {
        return false;
    }
}
