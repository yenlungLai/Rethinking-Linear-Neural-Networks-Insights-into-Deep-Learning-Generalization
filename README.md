# Rethinking Linear Neural Networks: Insights into Deep Learning Generalization

This paper is currently under review.

Abstract: 

Despite the success of deep neural networks (DNNs), they have significant vulnerabilities and unresolved issues, such as adversarial examples that can lead to misclassification. Additionally, overparameterized DNNs are believed to fit random noise without aiding generalization; however, they often generalize well to unseen test samples. This unexpected generalization is often attributed to explicit or implicit regularization from gradient-based optimization techniques.

We conducted experiments with deep linear networks to explore their ability to generalize and fit random labels. We consistently observed correlation convergence between the training input and random labels, which becomes increasingly significant in the overparameterized regime, where the number of layers is sufficiently increased. This convergence allows linear neural networks to fit these random labels perfectly, leading to zero training loss and improved classification performance (in terms of decidability) for test labels, including their flipped counterparts that were never seen by the model during training.

Our findings provide new insights into the generalization of DNNs, highlighting a specific scenario where generalization is closely connected with correlation convergence. This scenario involves the network's ability to fit random unseen labels in a simplistic setting where the network is linear, and no explicit regularization or gradient-based optimization is considered.
