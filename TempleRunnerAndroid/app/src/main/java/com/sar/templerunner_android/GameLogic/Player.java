package com.sar.templerunner_android.GameLogic;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Point;

import com.sar.templerunner_android.R;

public class Player {
    private Point position;
    private PlayerStates state;

    private Bitmap image;

    public Player(Point pos, PlayerStates state , Resources res){
        position=pos;
        this.state=state;
        image = BitmapFactory.decodeResource(res, R.drawable.branch);
       // image=Bitmap.createScaledBitmap(obstacle, blockSize, blockSize, true);
    }


    public Point getPosition() {
        return position;
    }

    public void setPosition(Point position) {
        this.position = position;
    }

    public PlayerStates getState() {
        return state;
    }

    public void setState(PlayerStates state) {
        this.state = state;
    }

}
