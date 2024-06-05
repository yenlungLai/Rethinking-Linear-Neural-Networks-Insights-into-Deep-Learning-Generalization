# Understanding Deep Learning Requires Rethinking Linear Neural Network

This paper is currently under review.

Abstract: 

Despite the empirical success of deep neural networks (DNNs), significant vulnerabilities persist, particularly exemplified by the existence of adversarial examples. These examples are crafted with imperceptible noise that can lead to misclassification by a DNN model. Additionally, DNN models exhibit the capacity to fit random noise, possibly relying on shortcut features, resulting in poor generalization to unseen test samples. In this work, we delve into understanding these phenomena, focusing on deep linear networks. While it is commonly understood that linear networks, unlike their non-linear counterparts, should exhibit less expressive power in fitting training labels and thus lower generalization performance. However, our findings indicate that this conventional belief does not necessarily hold for random unseen labels during training. We conducted experiments with deep linear networks to explore their ability to generalize and fit random labels. We observed the existence of correlation convergence between training input and random labels, which becomes increasingly significant in the overparameterized regime-where the number of layers is increases sufficiently. This convergence allows linear neural networks to fit these random labels perfectly, leading to zero training loss, and facilitating the classification of unseen labels and those with sign flipped. Our findings sheds light on the generalization behavior of DNNs to unseen labels and shortcut learning, offer new insights for understanding the success and vulnerabilities of DNNs.
