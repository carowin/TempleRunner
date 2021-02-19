package com.sar.templerunner_android.GameLogic;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import com.sar.templerunner_android.R;

public class SimpleCoin extends Coin{

    public SimpleCoin(int x, int y, int coinSize, int screenY, Resources res) {
        super(x, y, coinSize, screenY, res);
        coinImage = BitmapFactory.decodeResource(res, R.drawable.simple_coin);
        coinImage= Bitmap.createScaledBitmap(coinImage, coinSize, coinSize, true);
    }

    @Override
    public boolean detectCollision(Player p) {
        return false;
    }
}
