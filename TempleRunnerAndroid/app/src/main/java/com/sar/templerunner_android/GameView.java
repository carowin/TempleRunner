package com.sar.templerunner_android;

import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.util.Log;
import android.view.MotionEvent;
import android.view.SurfaceView;

import androidx.annotation.NonNull;

import com.sar.templerunner_android.GameLogic.blocks.Block;
import com.sar.templerunner_android.GameLogic.player.Player;
import com.sar.templerunner_android.Util.PlayerStates;

import android.view.View;
import com.sar.templerunner_android.GameLogic.Player;
import com.sar.templerunner_android.GameLogic.PlayerStates;
import com.sar.templerunner_android.GameLogic.Road;
import android.widget.TextView;


public class GameView extends SurfaceView implements Runnable{
    private Thread thread;
    private boolean isPlaying = true;

    private final Background[] backgroundArray;
    private final int screenX, screenY;
    private int currentBG =0;
    private final int  nbBackground;

    private Player player;
    private Road road;
    private Bitmap button;
    private Rect rect_button;
    private Paint paint;

    private TextView score;
    private int score_value;

    public GameView(Context context, int screenX, int screenY) {
        super(context);
        score = new TextView(context);
        score_value = 0;
        this.screenX = screenX;
        this.screenY = screenY;
        paint = new Paint();
        backgroundArray = new Background[6];
        nbBackground = backgroundArray.length;
        for(int i = 0;i<nbBackground;i++)
            backgroundArray[i]= new Background(screenX, screenY, this.getResources(), i);
        road = new Road(screenX,screenY,this.getResources());

        player = new Player(screenX/3 , screenY - screenY/10,screenY, PlayerStates.RUNNING,this.getResources());

        button = BitmapFactory.decodeResource(this.getResources(), R.drawable.button);
        button = Bitmap.createScaledBitmap(button, 300, 150, true);


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
            canvas.drawColor(Color.BLUE);
            canvas.drawBitmap(button,screenX - 300,screenY - 150,paint);
            paint.setColor(Color.BLACK);
            paint.setTextSize(50);
            canvas.drawText(String.valueOf(score_value), screenX - 100, 150, paint);
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
                    if(x >= screenX - 300 && y >= screenY - 150){
                        pause();
                        //Intent intent = new Intent(GameActivity.this,ScoreActivity.class);
                        //intent.putExtra("DATA_CHANGE", true);
                        //intent.putExtra("CURRENT_SCORE", 100);
                        //intent.putExtra("CURRENT_COINS", 1200);
                        //startActivity(intent);
                    }

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

    public boolean isPlaying(){
        return  isPlaying;
    }

    public void updateLabel(){
        score_value++;
        drawBackgroud();
    }

    public int getCurrentScore(){
        return score_value;
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
            background = Bitmap.createScaledBitmap(background,screenX-20,screenY-20,false);
            this.paint = new Paint();
        }

    }

}