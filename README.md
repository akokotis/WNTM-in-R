# Word Network Topic Modeling - Work in Progress!
This work is my current project that is an extension of my experimentation to find the best method to group like-itemed retail products into types using short text input. I read this interesting and comprehensive paper on a different topic modeling approach. The gist is that you create a word network using your document text and apply an edge weight that is the frequency of word pairs appearing in the same document. Then using the adjacency matrix of the graph, apply LDA. The results will give you topics for each of the words and not immediately be mappable back to the documents. But the paper includes a formula to apply the topics to the documents.
##### Excited to try this out!!

### Resource:
[Word Network Topic Model: A Simple but General Solution for Short and Imbalanced Texts](https://www.semanticscholar.org/paper/Word-network-topic-model%3A-a-simple-but-general-for-Zuo-Zhao/0c48389589ad8f6df7d79e5caa8820268453a645/read)
