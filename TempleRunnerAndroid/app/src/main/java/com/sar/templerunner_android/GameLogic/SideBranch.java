package com.sar.templerunner_android.GameLogic;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;

import com.sar.templerunner_android.R;

public class SideBranch extends Block{
    private Bitmap obstacle;
    /**
     * screen on the x positions
     * <p>
     * screen on the Y positions
     * <p>
     * Position of the top of rectangle
     *
     * @param x
     * @param y
     * @param blockSize
     * @param screenY   taille de l'ecan vers le bas
     * @param res
     */
    public SideBranch(int x, int y, int blockSize, int screenY, Resources res) {
        super(x, y, blockSize, screenY, res);
        obstacle = BitmapFactory.decodeResource(res, R.drawable.sidebranch);
        obstacle=Bitmap.createScaledBitmap(obstacle, blockSize, blockSize, true);
    }

    @Override
    public boolean detectCollision(Player p) {
        //TO DO
        return false;
    }

    @Override
    public void updatePosition(Canvas c) {
        super.updatePosition(c);
        c.drawBitmap(obstacle,x,y, paint);
    }
}