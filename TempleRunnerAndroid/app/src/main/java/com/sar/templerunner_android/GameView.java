package com.sar.templerunner_android;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

import androidx.annotation.NonNull;

import com.sar.templerunner_android.GameLogic.Road;

public class GameView extends SurfaceView implements Runnable{
    private Thread thread;
    private boolean isPlaying = true;

    private final Background[] backgroundArray;
    private final int screenX, screenY;
    private int currentBG =0;
    private final int  nbBackground;


    private Road road;

     public GameView(Context context, int screenX, int screenY) {
        super(context);
         this.screenX = screenX;
         this.screenY = screenY;
         backgroundArray = new Background[6];
         nbBackground = backgroundArray.length;
        for(int i = 0;i<nbBackground;i++)
            backgroundArray[i]= new Background(screenX, screenY, getResources(), i);

        road = new Road(screenX,screenY);

    this.invalidate();
    }

    @Override
    public void run() {
            while (isPlaying){
                drawBackgroud();
                sleep();
            }
    }

    private void drawBackgroud(){
         if(getHolder().getSurface().isValid()){
             Canvas canvas =  getHolder().lockCanvas();
             canvas.drawColor(Color.WHITE);
             road.upDateRoad(canvas);
             canvas.drawBitmap(backgroundArray[currentBG%nbBackground].background, screenX,screenY,backgroundArray[currentBG%nbBackground].paint);
             currentBG++;
             getHolder().unlockCanvasAndPost(canvas);
         }
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        Log.d("myTag", "ICI");

        canvas.drawBitmap(backgroundArray[currentBG%nbBackground].background, screenX,screenY,backgroundArray[currentBG%nbBackground].paint);

    }

    public void resume(){
         isPlaying = true;
         thread = new Thread(this);
         thread.start();
    }

    public void pause () {
        try {
            isPlaying = false;
            thread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    private void sleep(){
        try {
            Thread.sleep(17);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }


    public static class Background {
        Bitmap background;
        Paint paint;
        Background(int screenX, int screenY, Resources res, int imageNumber){
            switch (imageNumber){
                case 0:
                    background= BitmapFactory.decodeResource(res,R.drawable.water_0);
                    break;
                case 1:
                    background= BitmapFactory.decodeResource(res,R.drawable.water_1);
                    break;
                case 2:
                    background= BitmapFactory.decodeResource(res,R.drawable.water_2);
                    break;
                case 3:
                    background= BitmapFactory.decodeResource(res,R.drawable.water_3);
                    break;
                case 4:
                    background= BitmapFactory.decodeResource(res,R.drawable.water_4);
                    break;
                default:
                    background= BitmapFactory.decodeResource(res,R.drawable.water_5);
            }
            background = Bitmap.createScaledBitmap(background,screenX,screenY,false);
            this.paint = new Paint();
        }

    }

}
