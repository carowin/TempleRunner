package com.sar.templerunner_android.GameLogic.blocks;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;

import androidx.annotation.Nullable;

import com.sar.templerunner_android.GameLogic.player.Player;

import com.sar.templerunner_android.R;
import com.sar.templerunner_android.Util.CurrentDifficulty;

public abstract class Block {

    // util pour implanter les colision par la suite
    private Rect rect;
    protected Paint paint;
    private Bitmap pave;
    private static int cpt =0;
    private final int id ;
    private final int blockSize;
    private int screenY;

    protected int x,y;

    /**
     *
     *
     * screen on the x positions
     *
     * screen on the Y positions
     *
     * Position of the top of rectangle
     * @param screenY taille de l'ecan vers le bas
     *
     */
    public Block(int x, int y, int blockSize, int screenY , Resources res){
        paint = new Paint();
        rect = new Rect();
        id = cpt++;
        this.x=x;
        this.y=y;
        this.screenY=screenY;
        this.blockSize=blockSize;

        pave = BitmapFactory.decodeResource(res, R.drawable.road);
        pave = Bitmap.createScaledBitmap(pave, blockSize, blockSize, true);
    }

    /**
     *
     * @return True if the player lose the game
     */
    public abstract boolean detectCollision(Player p);



    public void updatePosition(){
        y++;
        if(y >= screenY )
            y=0;
    }

    protected int incrementSpeed(int y){
        switch (CurrentDifficulty.getDDiff()){
            case EASY:
                return y +10;
            case HARD:
                return y +20;
            case MEDIUM:
                return y +30;
            default:
                return y + 40;
        }
    }

    public void setImage(Canvas c){
        c.drawBitmap(pave,x,y, paint);
    }

    @Override
    public boolean equals(@Nullable Object obj) {
        // If the object is compared with itself then return true
        if (!(obj instanceof Block)) {
            return false;
        }
        Block other = (Block) obj;
        if (other.id == id)
            return true;
        else
            return false;
    }


    public Rect getRect() {
        return rect;
    }

    public int getId() {
        return id;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public void setY(int value){
        y=value;
    }

}
