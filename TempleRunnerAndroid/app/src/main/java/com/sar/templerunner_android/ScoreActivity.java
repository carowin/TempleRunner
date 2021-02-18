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

import org.json.JSONObject;

/** TO DO  */
public class ScoreActivity extends AppCompatActivity {

    TextView my_score_label;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_score);

        Button backMain  = findViewById(R.id.button_back_main);
        backMain.setOnClickListener(backMainOnClickListener);

        Button newGame  = findViewById(R.id.button_new_game);
        newGame.setOnClickListener(newGameOnClickListener);

        Button sendScore  = findViewById(R.id.button_send_score);
        sendScore.setOnClickListener(sendScoreOnClickListener);

        my_score_label = findViewById(R.id.textView2);

    }

    Button.OnClickListener backMainOnClickListener = new Button.OnClickListener(){
        @Override
        public void onClick(View v) {
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

    Button.OnClickListener sendScoreOnClickListener = new Button.OnClickListener(){
        @Override
        public void onClick(View v) {

            String url = "https://templerunnerppm.pythonanywhere.com/chat/storeScore/User1/100";
            System.out.println("Ask !!!!!");
            RequestQueue queue = Volley.newRequestQueue(ScoreActivity.this.getApplicationContext());

            JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
                    (Request.Method.GET, url, null, new Response.Listener<JSONObject>() {

                        @Override
                        public void onResponse(JSONObject response) {
                            System.out.println("Reponse !!!!!");
                            //my_score_label.setText("Response: " + response.toString());
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
}