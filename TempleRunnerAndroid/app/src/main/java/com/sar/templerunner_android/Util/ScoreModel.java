package com.sar.templerunner_android.Util;

public class ScoreModel {

    private int lastScore = 0;
    private int hightScore  = 0;
    private int currentScore = 0;
    private int currentCoins = 0;


    public ScoreModel(int lastScore, int hightScore, int currentScore, int currentCoins) {
        this.lastScore = lastScore;
        this.hightScore = hightScore;
        this.currentScore = currentScore;
        this.currentCoins = currentCoins;
    }


    public ScoreModel() {
        // Do nothing
    }

    public int getLastScore() {
        return lastScore;
    }

    public void setLastScore(int lastScore) {
        this.lastScore = lastScore;
    }

    public int getHightScore() {
        return hightScore;
    }

    public void setHightScore(int hightScore) {
        this.hightScore = hightScore;
    }

    public int getCurrentScore() {
        return currentScore;
    }

    public void setCurrentScore(int currentScore) {
        this.currentScore = currentScore;
    }

    public int getCurrentCoins() {
        return currentCoins;
    }

    public void setCurrentCoins(int currentCoins) {
        this.currentCoins = currentCoins;
    }

    public void updateScores() {
        if(currentScore != 0){
            lastScore = currentScore;
        }
        if (lastScore > hightScore) {
            hightScore = lastScore;
        }
    }
}