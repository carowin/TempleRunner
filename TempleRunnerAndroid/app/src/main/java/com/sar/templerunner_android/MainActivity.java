package com.sar.templerunner_android;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity implements View.OnClickListener{
    private Button playGameButton;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        playGameButton = findViewById(R.id.ButtonPlay);
        playGameButton.setOnClickListener(this);
    }



    @Override
    public void onClick(View v) {
        Intent intent = new Intent(this, GameActivity.class);
        startActivity(intent);
    }
}