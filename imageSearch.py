# -*- coding: utf-8 -*-
"""
Created on Mon Apr 25 18:20:51 2016

@author: Julie
"""

import requests
import json


data = [line.strip() for line in open("C:\Users\Julie\OneDrive\Research\Python Practice\Emotion SQL Scripts\EmotionList.txt", 'r')]
images = []

for emotion in data:
    image_type = emotion
    searchTerm = emotion
    startIndex = '1'
    key = 'AIzaSyAdezd24uJh9vX6kFfVbL73o7cHc_l9DAE'
    cx = '017221338186166509486:d4ldrzpjxkq'
    searchUrl = "https://www.googleapis.com/customsearch/v1?q=" + \
    searchTerm + "&start=" + startIndex + "&key=" + key + "&cx=" + cx + \
    "&searchType=image"
    r = requests.get(searchUrl)
    response = r.content.decode('utf-8')
    result = json.loads(response)
    images.append(result)
    for img in images:
  print(img)