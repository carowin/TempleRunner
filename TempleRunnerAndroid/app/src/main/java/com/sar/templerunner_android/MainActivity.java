package com.sar.templerunner_android;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button playGameButton = findViewById(R.id.button_play);
        playGameButton.setOnClickListener(this);

        Button scoresView  = findViewById(R.id.button_scores);
        scoresView.setOnClickListener(scooresOnClickListener);

    }

    /* fonction callback du button_Play qui lance le jeu */
    @Override
    public void onClick(View v) {
        Intent intent = new Intent(this, GameActivity.class);
        startActivity(intent);
    }

    //class anonyme c'est dégeulasse mais c'est soit ça soit un menu
    Button.OnClickListener scooresOnClickListener = new Button.OnClickListener(){
        @Override
        public void onClick(View v) {
            Intent intent = new Intent(MainActivity.this,ScoreActivity.class);
            startActivity(intent);
        }
    };

}