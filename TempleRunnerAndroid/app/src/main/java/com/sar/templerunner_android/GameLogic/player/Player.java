package com.sar.templerunner_android.GameLogic.player;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;

import com.sar.templerunner_android.R;
import com.sar.templerunner_android.Util.PlayerStates;

import java.util.ArrayList;
import java.util.List;

public class Player {
    private PlayerStates state;
    private Rect rect;
    private int screenY;
    private int x,y;
    private Paint paint;
    private List<Bitmap> images = new ArrayList<>();




    private boolean isLeft = true;


    public Player(int x, int y , int screenY , PlayerStates state , Resources res){
        int size = 60;
        paint = new Paint();
        rect = new Rect(x, y, x + size, y + size);
        this.x=x;
        this.y=y;
        this.screenY=screenY;
        this.state=state;
        Bitmap tmp = BitmapFactory.decodeResource(res, R.drawable.player_run1);
        tmp=Bitmap.createScaledBitmap(tmp, size, size, true);
        images.add(tmp);
        Bitmap tmp2 = BitmapFactory.decodeResource(res, R.drawable.player_run2);
        tmp2=Bitmap.createScaledBitmap(tmp2, size, size, true);
        images.add(tmp2);
        Bitmap tmp3 = BitmapFactory.decodeResource(res, R.drawable.player_slid);
        tmp3=Bitmap.createScaledBitmap(tmp3, size, size, true);
        images.add(tmp3);
    }

    private boolean isSet = false ;
    private long lastPoint = 0;
    private long endPoint ;
    public void update(Canvas c){

        if(isSet){
            lastPoint =  System.nanoTime();
            endPoint = lastPoint + 1000;
            isSet =true;
        }else if(endPoint >= System.nanoTime())
            isSet =false;
        else
            return;


        if(isLeft) {
            isLeft = false;
            c.drawBitmap(images.get(0), x, y, paint);
        }else {
            isLeft = true;
            c.drawBitmap(images.get(1), x, y, paint);
        }
    }


    public PlayerStates getState() {
        return state;
    }

    public void setState(PlayerStates state) {
        this.state = state;
    }

    public Rect getRect(){
        return rect;
    }

}
