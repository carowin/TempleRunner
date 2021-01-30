package com.sar.templerunner_android.GameLogic;

import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Point;
import android.graphics.Rect;
import android.os.DropBoxManager;

import com.sar.templerunner_android.Util.CurrentDifficulty;

public abstract class Block {

    private Rect rect;
    private Paint paint;

    /**
     *
     * @param screenX
     * screen on the x positions
     * @param screenY
     * screen on the Y positions
     * @param topOfRect
     * Position of the top of rectangle
     * @param color color of the pain to use exemple Color.YELLOW
     *
     */
    public Block(int screenX, int screenY , int topOfRect ,int blockSize, int color){
        int centerY = screenY/2;
        paint = new Paint(color);
        rect = new Rect();
        rect.top = topOfRect;
        rect.left = centerY - (blockSize/2);
        rect.right= centerY + (blockSize/2);
        rect.bottom  = topOfRect + blockSize;
    }

    /**
     *
     * @return True if the player lose the game
     */
    public abstract boolean detectCollision(Player p);



    public void updatePosition(Canvas c){
        rect.top = incrementSpeed(rect.top);
        c.drawRect(rect,paint);
    }

  //  private void DrawOnCanvas(Canvas c){ }

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



    public Rect getRect() {
        return rect;
    }
}
