package com.sar.templerunner_android;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.app.ActionBar;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.Toolbar;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.Callable;

public class MessageActivity extends AppCompatActivity {


    Handler handler = new Handler();
    Runnable runnable;
    int delay = 1000;
    int message_already_read = 0;

    TextView username;
    ImageView imageView;
    JSONObject res;

    RecyclerView recyclerView;
    EditText msg_editText;
    ImageButton sendBtn;

    Intent intent;

    String userid;
    MessageAdapter messageAdapter;
    List<Chat> mChat;

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_message);

        imageView = findViewById(R.id.imageView);
        username = findViewById(R.id.usernameText);
        username.setText(MainActivity.getUserId());
        sendBtn = findViewById(R.id.btn_send);
        msg_editText = findViewById(R.id.text_send);

        // RecyclerView
        recyclerView = findViewById(R.id.recycler_view);
        recyclerView.setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getApplicationContext());
        linearLayoutManager.setStackFromEnd(true);

        recyclerView.setLayoutManager(linearLayoutManager);
        imageView.setImageResource(R.mipmap.ic_launcher);

        try {
            readMessage("default");
        } catch (JSONException e) {
            e.printStackTrace();
        }


        //Toolbar

        Toolbar toolbar = findViewById(R.id.toolbar2);
        getSupportActionBar(toolbar);
        getSupportActionBar().setTitle("");
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v){
                finish();
            }
        });

        intent = getIntent();
        userid = intent.getStringExtra("userid");

        sendBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String msg = msg_editText.getText().toString();
                if(!msg.equals("")){
                    sendMessage(MainActivity.getUserId(), msg);
                } else {
                    Toast.makeText(MessageActivity.this, "Please send a non empty message", Toast.LENGTH_SHORT).show();
                }

                msg_editText.setText("");
            }
        });

    }

    @Override
    protected void onResume() {
        handler.postDelayed(runnable = new Runnable() {
            public void run() {
                handler.postDelayed(runnable, delay);
                try {
                    readMessage("Default");
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }, delay);
        super.onResume();
    }

    private void sendMessage(String sender, String message) {
        String url = "https://templerunnerppm.pythonanywhere.com/chat/storeMessage/"+sender+"/"+message;
        RequestQueue queue = Volley.newRequestQueue(MessageActivity.this.getApplicationContext());

        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
                (Request.Method.GET, url, null, new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        System.out.println(response);
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

    private void accesListMessage(String url){
        RequestQueue queue = Volley.newRequestQueue(MessageActivity.this.getApplicationContext());

        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
                (Request.Method.GET, url, null, new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        System.out.println(response);
                        mChat = new ArrayList<>();

                        try {
                            JSONArray liste_messages = response.getJSONArray("messages");
                            for(int i=0; i < liste_messages.length(); i++){
                                String sender = liste_messages.getJSONObject(i).getString("sender");
                                String message = liste_messages.getJSONObject(i).getString("message");
                                Chat chat = new Chat(sender, MainActivity.getUserId(), message);
                                mChat.add(chat);
                            }
                            messageAdapter = new MessageAdapter(MessageActivity.this, mChat, "default");
                            recyclerView.setAdapter(messageAdapter);
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

    private void accesNbMessage(String url){
        RequestQueue queue = Volley.newRequestQueue(MessageActivity.this.getApplicationContext());

        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
                (Request.Method.GET, url, null, new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        System.out.println(response);
                        int nb_messages = 0;
                        try {
                            nb_messages = Integer.parseInt(response.getString("value"));
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }

                        if(nb_messages - message_already_read <= 0){
                            return;
                        } else {
                            int temp = nb_messages;
                            nb_messages = nb_messages - message_already_read;
                            message_already_read = temp;
                            notifyNewMesssage(nb_messages);
                        }
                        String url_fecth_messages ="https://templerunnerppm.pythonanywhere.com/chat/fetchMessages/"+nb_messages;
                        accesListMessage(url_fecth_messages);
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

    private void readMessage(String imageurl) throws JSONException {
        String url = "https://templerunnerppm.pythonanywhere.com/chat/fetchMessagesSize";
        accesNbMessage(url);
    }

    private void notifyNewMesssage(int nb_mess) {
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            NotificationChannel notificationChannel = new NotificationChannel("My Notification","NotificationChannel",NotificationManager.IMPORTANCE_DEFAULT);
            NotificationManager notificationManager = getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(notificationChannel);
        }

        String message = "Vous avez "+nb_mess+" nouveaux messages";
        NotificationCompat.Builder buillder = new NotificationCompat.Builder(MessageActivity.this,"My Notification");
        buillder.setContentTitle("Nouveau Message");
        buillder.setContentText(message);
        buillder.setSmallIcon(R.drawable.ic_launcher_background);
        buillder.setAutoCancel(true);

        NotificationManagerCompat managerCompat = NotificationManagerCompat.from(MessageActivity.this);
        managerCompat.notify(1,buillder.build());
    }

    private ActionBar getSupportActionBar(Toolbar toolbar) {
        return null;
    }
}