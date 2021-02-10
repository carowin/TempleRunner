package com.sar.templerunner_android.GameLogic;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Point;
import android.graphics.Rect;
import android.os.DropBoxManager;

import com.sar.templerunner_android.R;
import com.sar.templerunner_android.Util.CurrentDifficulty;

public abstract class Block {

    private Rect rect;
    private Paint paint;
    private Bitmap pave;

    private int x,y;

    /**
     *
     *
     * screen on the x positions
     *
     * screen on the Y positions
     *
     * Position of the top of rectangle
     * @param color color of the pain to use exemple Color.YELLOW
     *
     */
    public Block(int x, int y, int blockSize, int color , Resources res){
      //  int centerY = screenY/2;
        paint = new Paint(color);
        rect = new Rect();
    //    rect.top = topOfRect;
     //   rect.left = centerY - (blockSize/2);
     //   rect.right= centerY + (blockSize/2);
      //  rect.bottom  = topOfRect + blockSize;

        pave=BitmapFactory.decodeResource(res, R.drawable.road);
        BitmapFactory.Options o = new BitmapFactory.Options();
        pave=Bitmap.createScaledBitmap(pave, blockSize, blockSize, true);
    }

    /**
     *
     * @return True if the player lose the game
     */
    public abstract boolean detectCollision(Player p);



    public void updatePosition(Canvas c){
       /// rect.top = incrementSpeed(rect.top);
        y++;
        c.drawBitmap(pave,x,y, paint);
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
