package com.sar.templerunner_android.GameLogic.coins;


import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;

import com.sar.templerunner_android.GameLogic.Player;

public abstract class Coin {
    private int x,y;
    protected Bitmap coinImage;
    private int screenY;
    protected Paint paint;
    private Rect rect;

    public Coin(int x, int y, int coinSize, int screenY, Resources res) {
        paint = new Paint();
        rect = new Rect();
        this.x=x;
        this.y=y;
        this.screenY = screenY;
    }


    public abstract boolean detectCollision(Player p);


    public void updatePosition(Canvas c){
        y++;
     //   if(y>=screenY)
    //        y= -blockSize;
       c.drawBitmap(coinImage,x,y, paint);
    }
}
