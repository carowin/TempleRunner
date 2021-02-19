package com.sar.templerunner_android;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.preference.PreferenceManager;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;
import com.google.gson.JsonObject;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    Handler handler = new Handler();
    Runnable runnable;
    int delay = 10000;
    public static String USER_ID = "";
    public SharedPreferences preferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button playGameButton = findViewById(R.id.button_play);
        playGameButton.setOnClickListener(this);

        Button scoresView  = findViewById(R.id.button_scores);
        scoresView.setOnClickListener(scooresOnClickListener);

        Button chatView = findViewById(R.id.button_chat);
        chatView.setOnClickListener(chatOnClickListener);

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            NotificationChannel channel = new NotificationChannel("scoreChannel","scoreChannel", NotificationManager.IMPORTANCE_DEFAULT);
            NotificationManager manager = getSystemService(NotificationManager.class);
            manager.createNotificationChannel(channel);
        }

        preferences = PreferenceManager.getDefaultSharedPreferences(MainActivity.this.getApplicationContext());

        USER_ID = preferences.getString("USER_ID", "");
        System.out.println(USER_ID);

        if("" == USER_ID){
            createNewPersitanteId();
        }



    }

    protected void createNewPersitanteId() {
        System.out.println("--------------------------------");
        String url = "https://templerunnerppm.pythonanywhere.com/chat/fetchNewUsersID";
        RequestQueue queue = Volley.newRequestQueue(MainActivity.this.getApplicationContext());

        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
                (Request.Method.GET, url, null, new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {

                        try {
                            USER_ID = response.get("value").toString();
                            System.out.println(USER_ID);
                            SharedPreferences.Editor editor = preferences.edit();
                            editor.putString("USER_ID", USER_ID);
                            editor.commit();

                        } catch (JSONException e) {
                            e.printStackTrace();
                        }

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

    @Override
    protected void onResume() {
        handler.postDelayed(runnable = new Runnable() {
            public void run() {
                handler.postDelayed(runnable, delay);
                String url = "https://templerunnerppm.pythonanywhere.com/chat/fetchScore/";
                RequestQueue queue = Volley.newRequestQueue(MainActivity.this.getApplicationContext());

                JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
                        (Request.Method.GET, url + USER_ID, null, new Response.Listener<JSONObject>() {

                            @Override
                            public void onResponse(JSONObject response) {
                                JSONArray list_scores = new JSONArray();
                                try {
                                    list_scores =   response.getJSONArray("value");
                                    System.out.println("Size array :" + list_scores.length());

                                    for (int i=0 ; i<list_scores.length(); i++) {

                                        NotificationCompat.Builder builder = new NotificationCompat.Builder(MainActivity.this.getApplicationContext(),"scoreChannel")
                                                .setSmallIcon(R.drawable.rocher)
                                                .setContentTitle("New High score from another player")
                                                .setContentText(list_scores.get(i).toString())
                                                .setPriority(NotificationCompat.PRIORITY_DEFAULT);

                                        NotificationManagerCompat notificationManagerCompat = NotificationManagerCompat.from(MainActivity.this.getApplicationContext());
                                        notificationManagerCompat.notify(1,builder.build());

                                    }

                                } catch (JSONException e) {
                                    e.printStackTrace();
                                }

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
        }, delay);
        super.onResume();
    }

    public static String getUserId(){
        return USER_ID;
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


    Button.OnClickListener chatOnClickListener = new Button.OnClickListener(){
        @Override
        public void onClick(View v) {
            Intent intent = new Intent(MainActivity.this,MessageActivity.class);
            startActivity(intent);
        }
    };


}