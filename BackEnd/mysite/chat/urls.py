# chat/urls.py
from django.urls import path

from . import views

urlpatterns = [
    path('', views.initBDD, name="index"),
    path('fetch', views.fetchScore, name="fetch"),
    path('store/<str:score_value>/', views.storeScore, name="store"),
]
