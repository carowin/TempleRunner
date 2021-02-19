package com.sar.templerunner_android;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;
import com.sar.templerunner_android.MainActivity;

import org.json.JSONObject;
import com.sar.templerunner_android.Util.ScoreModel;
/** TO DO  */
public class ScoreActivity extends AppCompatActivity {

    TextView my_score_label;
    TextView first_text_label;
    TextView first_num_label;
    TextView second_text_label;
    TextView second_num_label;

    Button first_button;
    Button second_button;
    Button third_button;

    enum Mode {Pause, Main} ;
    Mode mode;
    ScoreModel model = new ScoreModel();

    boolean data_change;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_score);

        first_text_label = findViewById(R.id.textView2);
        first_num_label = findViewById(R.id.textView);
        second_text_label = findViewById(R.id.textView3);
        second_num_label = findViewById(R.id.textView4);

        first_button = findViewById(R.id.button_send_score);
        second_button = findViewById(R.id.button_new_game);
        third_button = findViewById(R.id.button_back_main);

        first_button.setOnClickListener(sendScoreOnClickListener);
        second_button.setOnClickListener(newGameOnClickListener);
        third_button.setOnClickListener(backMainOnClickListener);

        mode = Mode.Main;
        data_change = getIntent().getBooleanExtra("DATA_CHANGE", false);

        if(data_change){
            model.setCurrentCoins(getIntent().getIntExtra("CURRENT_COINS", -1));
            model.setCurrentScore(getIntent().getIntExtra("CURRENT_SCORE", -1));
            model.updateScores();
            setModeToPause();
            updateLabels();
        }

    }

    Button.OnClickListener backMainOnClickListener = new Button.OnClickListener(){
        @Override
        public void onClick(View v) {
            model.updateScores();
            Intent intent = new Intent(ScoreActivity.this,MainActivity.class);
            startActivity(intent);
        }
    };

    Button.OnClickListener newGameOnClickListener = new Button.OnClickListener(){
        @Override
        public void onClick(View v) {
            Intent intent = new Intent(ScoreActivity.this,GameActivity.class);
            startActivity(intent);
        }
    };

    Button.OnClickListener resumeGameOnClickListener = new Button.OnClickListener(){
        @Override
        public void onClick(View v) {
            Intent intent = new Intent(ScoreActivity.this,GameActivity.class);
            startActivity(intent);
        }
    };

    Button.OnClickListener sendScoreOnClickListener = new Button.OnClickListener(){
        @Override
        public void onClick(View v) {

            String url = "https://templerunnerppm.pythonanywhere.com/chat/storeScore/";
            System.out.println("Ask for : " + url + MainActivity.getUserId() + "/" + "100");
            RequestQueue queue = Volley.newRequestQueue(ScoreActivity.this.getApplicationContext());

            JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
                    (Request.Method.GET, url + MainActivity.getUserId() + "/" + "100", null, new Response.Listener<JSONObject>() {

                        @Override
                        public void onResponse(JSONObject response) {
                            System.out.println("Reponse !!!!!");
                            //my_score_label.setText("Response: " + MainActivity.getUserId());
                        }
                    }, new Response.ErrorListener() {

                        @Override
                        public void onErrorResponse(VolleyError error) {
                            // TODO: Handle error
                            System.out.println("Error :" + error.getMessage());

                        }
                    });

            queue.add(jsonObjectRequest);
        }
    };

    public void setModeToPause(){
        mode = Mode.Pause;
    }

    public void setModeToMain(){
        mode = Mode.Main;
    }

    public void updateLabels(){
        switch (mode){
            case Main:
                first_text_label.setText("Last Score :");
                first_num_label.setText(String.valueOf(model.getLastScore()));
                second_text_label.setText("High Score :");
                second_num_label.setText(String.valueOf(model.getHightScore()));

                first_button.setText("Send Score");
                second_button.setText("New Game");
                third_button.setText("Back Menu");
                first_button.setOnClickListener(sendScoreOnClickListener);
                second_button.setOnClickListener(newGameOnClickListener);
                third_button.setOnClickListener(backMainOnClickListener);

            case Pause:
                first_text_label.setText("Current Score :");
                first_num_label.setText(String.valueOf(model.getCurrentScore()));
                second_text_label.setText("Current Coins :");
                second_num_label.setText(String.valueOf(model.getCurrentCoins()));

                first_button.setText("Main menu");
                second_button.setText("New Game");
                third_button.setText("Send Score");
                first_button.setOnClickListener(backMainOnClickListener);
                second_button.setOnClickListener(newGameOnClickListener);
                third_button.setOnClickListener(sendScoreOnClickListener);
        }
    }
}