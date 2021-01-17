package com.sar.templerunner_android;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Point;
import android.os.Bundle;
import android.view.WindowManager;

public class GameActivity extends AppCompatActivity {

    private GameView gameViewThread;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        Point p = new Point();
        getWindowManager().getDefaultDisplay().getSize(p);

        gameViewThread = new GameView(this, p.x,p.y);
        gameViewThread.resume();
        setContentView(gameViewThread);
    }


    @Override
    protected void onPause() {
        super.onPause();
        gameViewThread.pause();
    }

    @Override
    protected void onPostResume() {
        super.onPostResume();
        gameViewThread.resume();
    }
}