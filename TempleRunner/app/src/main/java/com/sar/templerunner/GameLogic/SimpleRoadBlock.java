package com.sar.templerunner.GameLogic;

import android.graphics.Point;

public class SimpleRoadBlock extends Block {

    public SimpleRoadBlock(int pos, int BlockSize,int screenY) {
        super(pos,BlockSize,screenY);
    }

    public SimpleRoadBlock(Point p1, Point p2, Point p3, Point p4) {
        super(p1, p2, p3, p4);
    }

    @Override
    public boolean isBlocked(Point pos, int size) {
        return false;
    }
}
