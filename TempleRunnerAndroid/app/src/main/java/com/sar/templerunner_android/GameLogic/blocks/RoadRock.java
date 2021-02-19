package com.sar.templerunner_android.GameLogic.blocks;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;

import com.sar.templerunner_android.GameLogic.player.Player;
import com.sar.templerunner_android.R;

public class RoadRock extends Block{
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
    public RoadRock(int x, int y, int blockSize, int screenY, Resources res) {
        super(x, y, blockSize, screenY, res);
        obstacle = BitmapFactory.decodeResource(res, R.drawable.rocher);
        obstacle=Bitmap.createScaledBitmap(obstacle, blockSize, blockSize, true);
    }

    @Override
    public boolean detectCollision(Player p) {
        Rect r = p.getRect();
        return getRect().intersect(r.left, r.top, r.right, r.bottom);
    }


    @Override
    public void setImage(Canvas c) {
        super.setImage(c);
        c.drawBitmap(obstacle,x,y, paint);
    }
}
