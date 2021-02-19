package com.sar.templerunner_android;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.graphics.Point;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.LinearLayout;

import com.sar.templerunner_android.Util.ScoreModel;

public class GameActivity extends AppCompatActivity {

    private GameView gameViewThread;
    Handler handler = new Handler();
    Runnable runnable;
    int delay = 100;
    int current_score;
    boolean alreadyshow = false;


    @SuppressLint("ResourceType")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        Point p = new Point();
        getWindowManager().getDefaultDisplay().getSize(p);
        gameViewThread = new GameView(this, p.x,p.y);
        setContentView(gameViewThread);
        //onPauseGame();
        current_score = 0;
    }


    @Override
    protected void onPause() {
        super.onPause();
        gameViewThread.pause();
    }

    @Override
    protected void onResume() {
        handler.postDelayed(runnable = new Runnable() {
            public void run() {
                handler.postDelayed(runnable, delay);
                if(!gameViewThread.isPlaying() && !alreadyshow){
                    alreadyshow = true;
                    Intent intent = new Intent(GameActivity.this,ScoreActivity.class);
                    intent.putExtra("DATA_CHANGE", true);
                    intent.putExtra("CURRENT_SCORE", gameViewThread.getCurrentScore());
                    intent.putExtra("CURRENT_COINS", 0);
                    startActivity(intent);
                }
                gameViewThread.updateLabel();
            }
        }, delay);
        super.onResume();
    }

    @Override
    protected void onPostResume() {
        super.onPostResume();
        gameViewThread.resume();
    }
}