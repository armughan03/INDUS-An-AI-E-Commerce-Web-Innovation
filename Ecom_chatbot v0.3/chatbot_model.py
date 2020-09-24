import nltk
# nltk.download('punkt')

from nltk.stem.lancaster import LancasterStemmer
stemmer = LancasterStemmer()

import numpy as np
import random
import pickle
import json

import matplotlib.pyplot as plt

from keras.models import Sequential
from keras.layers import Dense

# importing chatbot intents file

with open('intent.json') as json_data:
    intents = json.load(json_data)

words = []
classes = []
documents = []

ignore_words = ['?']

# loop through each sentence in our intents patterns
for intent in intents['intents']:
    for pattern in intent['patterns']:
        # tokenize each word in the sentence 
        w = nltk.word_tokenize(pattern)
        # add to our words list
        words.extend(w)
        # add to our words in our corpus
        documents.append((w, intent['tag']))
        # add to our classes list
        if intent['tag'] not in classes:
            classes.append(intent['tag'])

# stem and lower each word and remove duplicates
words = [stemmer.stem(w.lower()) for w in words if w not in ignore_words]
words = sorted(list(set(words)))

# remove duplicates
classes = sorted(list(set(classes)))

# print(len(documents), "documents",documents)
# print(len(classes), "classes", classes)
# print(len(words), "unique stemmed words", words)

# ======================= CREATING TRAINING DATA =============================
training = []
output = []

# create an empty array for output
output_empty = [0] * len(classes)

# training set, bag of words for each sentence 
for doc in documents:
    # initialize our bag of words
    bag = []
    # list of tokenized words for the pattern
    pattern_words = doc[0]
    # stem each word
    pattern_words = [stemmer.stem(word.lower()) for word in pattern_words]
    # create bag of words array
    for w in words:
        bag.append(1) if w in pattern_words else bag.append(0)
        
    # output = 0 for each tag and 1 for current tag
    output_row = list(output_empty)
    #print(classes.index(doc[1]))
    output_row[classes.index(doc[1])] = 1
    
    training.append([bag, output_row])





# SHUFFLING OUR FEATURES AND TURN INTO np.array
random.shuffle(training)
training = np.array(training)

# create train and test lists
train_x = list(training[:,0])
train_y = list(training[:,1])

# print(train_y[0])


# ======================= BUILDING OUR MODEL ============================
model = Sequential()
model.add(Dense(16, input_shape=[len(train_x[0], )]))
model.add(Dense(16))
model.add(Dense(16))
model.add(Dense(16, activation = 'softmax'))
model.add(Dense(16))
model.add(Dense(16))
model.add(Dense(len(train_y[0]), activation = 'softmax'))
# two extra layers were added previously there were only two

# model.summary()
model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['acc'])

# batch size was reduced from 8 to 4 
history = model.fit(np.array(train_x), np.array(train_y), epochs=2000, batch_size=4)

model.save('chatmodel.h5')

# Save all of our data structures
pickle.dump({'documents':documents ,'words':words, 'classes':classes}, open("training_data", "wb"))

# for report purposes

history_dict = history.history
history_dict.keys()

acc = history.history['acc']
loss = history.history['loss']
epochs = range(1, len(acc) + 1)
plt.plot(epochs, acc, 'bo', label='Training acc')
plt.title('Training and validation accuracy')
plt.legend()
plt.figure()
plt.plot(epochs, loss, 'bo', label='Training loss')
plt.title('Training and validation loss')
plt.legend()
plt.show()

























