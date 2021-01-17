package com.sar.templerunner_android;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.util.Log;
import android.view.SurfaceView;

public class GameView extends SurfaceView implements Runnable {
    private Thread thread;
    private boolean isPlaying = true;

    private Background backgroundArray[];
    private int screenX, screenY;
    private int currentBG =0;

     public GameView(Context context, int screenX, int screenY) {
        super(context);
         this.screenX = screenX;
         this.screenY = screenY;
         backgroundArray = new Background[6];
        for(int i = 0;i<6;i++)
            backgroundArray[i]=new Background(screenX,screenY,getResources(),i);


    }

    @Override
    public void run() {
            while (isPlaying){
                drawBackgroud();
            }
        //Log.d("izan","Izannne");

    }

    private void drawBackgroud(){
         if(getHolder().getSurface().isValid()){
             Log.d("izan","Izannne");
             Canvas canvas =  getHolder().lockCanvas();

             canvas.drawBitmap(backgroundArray[(currentBG++)%6].background, screenX,screenY, new Paint());
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



    public class Background {
        Bitmap background;
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
        }

    }

}
