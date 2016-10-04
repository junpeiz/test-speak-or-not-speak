# test-speak-or-not-speak
Use a simple SVM to judge whether a man is speaking in a vedio  
This is matlab version and use the libsvm library  
The ‘training.data’ contains the training data. It is from our project to detect whether a person in a video speaks or not. The features are generated in the following way, which may help you making the most of these features.  
1. Get the mouth region M from the origin image based on facial landmark detection.  
2. Calculate dense optic flow between mouth region of last frame and the current frame and generate a score S that depicts the motion of mouth.  
3. Calculate the parameter V which depicts the degree of mouth opening.  
4. For frame i, we also calculate the S and V for its previous and next frames.  
5. Hence, we generate a 6 dimensional feature vector is X=[Si-1 Si Si+1 Vi-1 Vi Vi+1].  
6. The label is at the end of each line, where +1 represents speaking, and -1 represents not-speaking.  

In the training.data, the ratio of positive examples over negative examples is 1:1.
