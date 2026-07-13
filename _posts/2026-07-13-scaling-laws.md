---
layout: post
title: "Scaling Laws for Neural Language Models"
date: 2026-07-13
tags: ["machine learning", "neural networks", "scaling laws"]
math: true
---


Today I am reading the article ["Scaling Laws for Neural Language Models"](https://arxiv.org/abs/2001.08361) by Kaplan et al. (2020). In this paper authors are focusing on the Transformer architecture, however, the scaling laws they find are likely to hold for other architectures as well.

Factors affecting the model performance are:
1. Model size $N$, which is a number of model parameters.
2. Dataset size $D$, which is a number of tokens in the dataset.
3. Compute budget $C$, which is the number of floating point operations. Compute is proportional to the number of model parameters and the number of tokens in the dataset.

Authors consider three different scaling regimes:

1. **Model size scaling**: In this regime, you train the model with so much data that it never overfits, the model size is the only limiting factor.  What does scaling the model size mean? It means increasing the number of parameters in the model, which can be done by adding more layers, increasing the width of layers, or both.

2. **Data scaling**: In this regime, you have a very large model, and the dataset size is the limiting factor. You prevent overfitting by stopping training early, before the model has a chance to overfit.

3. **Compute scaling**: In this regime you can vary both the model size and the dataset size, but you are limited by the compute budget. Here for each given compute cost, we pick the optimal combination of model size and dataset size minimizing the loss.

Authors notice interesting dependence: entropy loss $L$ scales as a power law with respect to compute effort, dataset size, and number of model parameters:

$$
L(C) = \left(\frac{C}{C_0}\right)^{-\alpha_C}, \quad L(D) = \left(\frac{D}{D_0}\right)^{-\alpha_D}, \quad L(N) = \left(\frac{N}{N_0}\right)^{-\alpha_N}.
$$


So each scaling law answers a question: if I have this model size, or this dataset size, or this compute budget, what is the best performance I can achieve?


The main takeaway is that within a given architecture family (like Transformers in this paper), instead of going crazy with tuning its internal shape, spend your effort on scaling up the model size and dataset size.  What the paper says is that the loss depends only on the aggregated number of parameters $N$, not on how that number is distributed across the layers. The paper's finding is that once you have more compute budget, you should put most of it into increasing the model size, rather than increasing the dataset size.

One may wonder, wouldn't I overfit by scaling the model size only? Authors claim that to avoid overfitting the dataset size only needs to grow as a sublinear power of the model size (roughly $D \propto N^{0.74}$), since overfitting shows when you train a large model on a small dataset. Moreover, by the compute-optimal recipe proposed in the paper, it is better to train a larger model but stop training early, than to train a smaller model until convergence and flat training curve. If we have a model and the training curve is starting to flatten, it is better to stop training and increase the model size, rather than continue training the same model. So, instead of spending the compute power on marginal improvements on a smaller model, it is better to invest that compute power into training a larger model. By stopping training early, we can avoid overfitting and still benefit from the larger model's capacity.

It is worth mentioning that the results in the paper are based on experiments with the Transformer architecture, so they may not generalize to other architectures like simple feedforward networks for example. The principles of scaling laws are likely to hold for other architectures, but the specific scaling exponents may differ.

Also, the recipe for compute-optimal training (bigger model, stop very early) has been developed based on the specific scaling laws found for the Transformer architecture. Moreover, the result has been revised in literature, and now it is considered a bit too extreme.

In any case, this paper has become a foundational work for future developments in the large language model field, including the development of models like GPT-3 and beyond.






