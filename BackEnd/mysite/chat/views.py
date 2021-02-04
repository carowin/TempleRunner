from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
import sqlite3
import os.path



# Create your views here.


def initBDD(request): 
    # do nothing
    return HttpResponse("main")


def fetchScore(request):
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(BASE_DIR, "base.db")
    connection = sqlite3.connect(db_path)
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM score')
    value = cursor.fetchone()[0]
    connection.close()
    resdict = {
        "value": str(value),
    }
    return JsonResponse(resdict)

def storeScore(request, score_value):
    connection = sqlite3.connect("base.db")
    cursor = connection.cursor()
    new_score = (score_value,cursor.lastrowid)
    cursor.execute('INSERT INTO score VALUES(?,?)', new_score)
    connection.commit()
    connection.close()
    resdict = {
        "value": "OK",
    }
    return JsonResponse(resdict)
