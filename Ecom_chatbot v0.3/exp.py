# -*- coding: utf-8 -*-
"""
Created on Mon May 27 16:30:25 2019

@author: Ali
"""

sent = "Alright then give ___ for it"

if "___" in sent:
    sent = sent.replace("___", "Rs.800/-")
    print(sent)
