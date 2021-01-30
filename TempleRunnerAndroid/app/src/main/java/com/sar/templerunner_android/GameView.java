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


    }

    @Override
    public void run() {
            while (isPlaying){
                drawBackgroud();
                sleep();
            }
    }
    Paint  p = new Paint(Color.YELLOW);
    private void drawBackgroud(){
        Log.d("myTag", "This is my message");
         if(getHolder().getSurface().isValid()){
             Log.d("myTag", "This is my message  " +1);
             Canvas canvas =  getHolder().lockCanvas();
             canvas.drawColor(Color.WHITE);
             Rect r = new Rect();
             r.left=screenX/2;
             r.right =screenX/2+50;
             r.bottom=screenX/2+50;

             r.top=screenX/2;


             p.setStrokeWidth(10);
             canvas.drawRect(r,p);


             canvas.drawBitmap(backgroundArray[currentBG%nbBackground].background, screenX,screenY,backgroundArray[currentBG%nbBackground].paint);
             currentBG++;
             getHolder().unlockCanvasAndPost(canvas);
         }
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
