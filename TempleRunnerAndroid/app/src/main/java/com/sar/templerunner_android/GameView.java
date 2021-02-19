package com.sar.templerunner_android;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.util.Log;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

import androidx.annotation.NonNull;

import com.sar.templerunner_android.GameLogic.blocks.Block;
import com.sar.templerunner_android.GameLogic.player.Player;
import com.sar.templerunner_android.Util.PlayerStates;
import com.sar.templerunner_android.GameLogic.Road;


public class GameView extends SurfaceView implements SurfaceHolder.Callback,Runnable{
    private Thread thread;
    private boolean isPlaying = true;

    private final Background[] backgroundArray;
    private final int screenX, screenY;
    private int currentBG =0;
    private final int  nbBackground;

    private Player player;
    private Road road;

     public GameView(Context context, int screenX, int screenY) {
        super(context);
         this.screenX = screenX;
         this.screenY = screenY;
         backgroundArray = new Background[6];
         nbBackground = backgroundArray.length;
        for(int i = 0;i<nbBackground;i++)
            backgroundArray[i]= new Background(screenX, screenY, this.getResources(), i);
        road = new Road(screenX,screenY,this.getResources());

        player = new Player(screenX/3 , screenY - screenY/10,screenY, PlayerStates.RUNNING,this.getResources());
    }

    @Override
    public void run() {
            while (isPlaying){
                drawBackgroud();
                detectCollision();
                sleep();
            }
    }

    private void drawBackgroud(){
         if(getHolder().getSurface().isValid()){
             Canvas canvas =  getHolder().lockCanvas();
             canvas.drawColor(Color.BLUE);
             road.upDateRoad(canvas);
             player.update(canvas);

            // canvas.drawBitmap(backgroundArray[currentBG%nbBackground].background, screenX,screenY,backgroundArray[currentBG%nbBackground].paint);
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

    private final float TOUCH_SCALE_FACTOR = 180.0f / 320;
    private float previousX;
    private float previousY;
    @Override
    public boolean onTouchEvent(MotionEvent e) {
        float x = e.getX();
        float y = e.getY();
        try {
            switch (e.getAction()) {
                case MotionEvent.ACTION_DOWN:
                    Log.d("myTag", "cur = Y =" + y + " X = " + x);

                case MotionEvent.ACTION_MOVE:
                    float dx = x - previousX;
                    float dy = y - previousY;

                    if (y > previousY) {
                        Log.d("myTag", "Swip bas");
                        return true;
                    }
                    if (x < previousX) {
                        Log.d("myTag", "Swip gauche");
                        return true;
                    }
            }
        } finally {
            previousX = x;
            previousY = y;
        }
        return false;
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


    @Override
    public void surfaceCreated(@NonNull SurfaceHolder holder) {

    }

    @Override
    public void surfaceChanged(@NonNull SurfaceHolder holder, int format, int width, int height) {

    }

    @Override
    public void surfaceDestroyed(@NonNull SurfaceHolder holder) {

    }

    private void detectCollision() {
        for(Block b : road.getObstacles()) {
            if (b.detectCollision(player)){
                isPlaying = false;
                break;
            }
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
            background = Bitmap.createScaledBitmap(background,screenX-20,screenY-20,false);
            this.paint = new Paint();
        }

    }

}
