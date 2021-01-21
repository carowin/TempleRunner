package com.sar.templerunner_android.GameLogic;

import android.graphics.Point;

public class Player {
    private Point position;
    private PlayerStates state;
    public Player(Point pos, PlayerStates state){
        position=pos;
        this.state=state;
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
