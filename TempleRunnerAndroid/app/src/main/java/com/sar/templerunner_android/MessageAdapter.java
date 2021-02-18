package com.sar.templerunner_android;

import android.content.Context;
import android.content.Intent;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

public class MessageAdapter extends RecyclerView.Adapter<MessageAdapter.ViewHolder> {

    private Context context;
    private List<Chat> mChat;
    private String imgUrl;

    private static final int MSG_TYPE_LEFT = 0;
    public static final int MSG_TYPE_RIGhT = 1;

    // Construtor

    public MessageAdapter(Context context, List<Chat> mChat, String imgUrl) {
        this.context = context;
        this.mChat = mChat;
        this.imgUrl = imgUrl;
    }

    @NonNull
    @Override
    public MessageAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        if (viewType == MSG_TYPE_RIGhT){
            View view = LayoutInflater.from(context).inflate(R.layout.chat_item_right, parent,false);
            return new MessageAdapter.ViewHolder(view);
        } else {
            View view = LayoutInflater.from(context).inflate(R.layout.chat_item_left, parent,false);
            return new MessageAdapter.ViewHolder(view);
        }

    }

    @Override
    public void onBindViewHolder(@NonNull MessageAdapter.ViewHolder holder, int position) {

        Chat chat = mChat.get(position);

        holder.show_message.setText(chat.getMessage());

        if(imgUrl.equals("default")){
            holder.imageView.setImageResource(R.mipmap.ic_launcher);
        } else {
            //Glide.with(context).load(imgUrl).into(holder.imageView);
        }
    }

    @Override
    public int getItemCount() {
        return mChat.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder{
        public TextView show_message;
        public ImageView imageView;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);

            show_message = itemView.findViewById(R.id.show_message);
            imageView = itemView.findViewById(R.id.profile_image);

        }

    }

    public int getItemViewType(int position) {
        if(mChat.get(position).getSender().equals(MainActivity.getUserId())){
            return MSG_TYPE_RIGhT;
        } else {
            return MSG_TYPE_LEFT;
        }
    }
}