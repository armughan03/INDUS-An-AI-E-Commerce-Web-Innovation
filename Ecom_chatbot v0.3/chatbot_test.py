import pickle
import json
import random
import nltk
import numpy as np

from keras.models import load_model

from nltk.stem.lancaster import LancasterStemmer
stemmer = LancasterStemmer()

data = pickle.load( open("training_data", "rb") )
words = data['words']
documents = data['documents']
classes = data['classes']

with open('intent.json') as json_data:
    intents = json.load(json_data)

# ======================= BUILDING OUR MODEL ============================

# load the model
model = load_model('chatmodel.h5')

def clean_up_sentence(sentence):
    # tokenize the pattern
    sentence_words = nltk.word_tokenize(sentence)
    # stem each word
    sentence_words = [stemmer.stem(word.lower()) for word in sentence_words]
    return sentence_words

# return bag of words array: 0 or 1 for each word in the bag that exists in the sentetnce
 
def bow(sentence, words, show_details=False):
    # tokenize the pattern
    sentence_words = clean_up_sentence(sentence)
    # bag of words
    bag = [0]*len(words)
    for s in sentence_words:
        for i,w in enumerate(words):
            if w == s:
                bag[i] = 1
                if show_details:
                    print("found in bag: %s" % w)
    return(np.array(bag))

# create a data structure to hold user context
context = {}

ERROR_THRESHOLD = 0.65
def classify(sentence):
    # generate probabilities from the model
    p = bow(sentence, words)
    
    d = len(p)
    f = len(documents)-2
    a = np.zeros([f, d])
    tot = np.vstack((p, a))
    
    results = model.predict(tot)[0]
    
    # filter out predictions below a threshold
    results = [[i, r] for i, r in enumerate(results) if r > ERROR_THRESHOLD]
    # sort by strength of probability
    results.sort(key=lambda x: x[1], reverse=True)
    return_list = []
    
    for r in results:
        return_list.append((classes[r[0]], r[1]))
        
    # return tuple of intent and probability
    return return_list

def response(sentence, userID, show_details=False):
    results = classify(sentence)
    # print('Result:', results)
    
    # if we have a classification then find the matching intent tag
    if results:
        #loop as long as there are matches to process
        while results:
            for i in intents['intents']:
                # find a tag matching the first result
                if i['tag'] == results[0][0]:
                    # set the context for this intent if necessary
                    if 'context_set' in i:
                        if show_details: print('context: ', i['context_set'])
                        context[userID] = i['context_set']
                        
                    # check if this intent is contextual and applies to this user's conversation
                    if not 'context_filter' in i or \
                        (userID in context and 'context_filter' in i and i['context_filter'] == context[userID]):
                        if show_details: print('tag:', i['tag'])
                        # a random response from the intent
                        return (random.choice(i['responses']))
            results.pop(0)


# TODO
# Check for goodbyes properly and terminate whenever someone say goodbye 
while True:
    try:
        input_msg = str(input("You: ")) 
        if input_msg == 'bye' or input_msg == 'goodbye':
            res = response(input_msg, '123',True)
            print("Negobot: "+ res)
            break;
        res = response(input_msg, '123', True)
        # For replacing the amount
        if "___" in res:
            #TODO the function which returns the evaluated price should be called here
            res = res.replace("___", "800", True)
        print("Negobot: "+ res)
    except TypeError:
        res = response("bla bla", '123', True)
        print("Negobot: "+ res)
        
# in answer to i am leaving give them a counter offer with convincing dialogues