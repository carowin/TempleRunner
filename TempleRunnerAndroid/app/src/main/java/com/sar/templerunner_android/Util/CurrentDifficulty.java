package com.sar.templerunner_android.Util;


public class CurrentDifficulty {
    private CurrentDifficulty() { }

    private static Difficulty lvl = Difficulty.EASY;

    public static void goToNextLvl(){
        switch (lvl){
            case EASY:
                lvl = Difficulty.MEDIUM;
                break;
            case MEDIUM:
                lvl = Difficulty.HARD;
                break;
            case HARD:
                lvl = Difficulty.IMPOSSIBLE;
                break;
            default:
                lvl = Difficulty.EASY;
        }
    }


    public static Difficulty getDDiff() {
        return lvl;
    }

    public enum Difficulty {
        EASY ,
        MEDIUM,
        HARD,
        IMPOSSIBLE
    }
}
