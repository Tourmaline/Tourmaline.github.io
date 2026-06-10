---
layout: post
title: "Attention and transformers"
date: 2026-06-10
tags: [machine-learning, statistics, ai, transformers, attention]
math: true
---

So what are these transformers? And why is attention a crucial part of modern AI success?

Transformers were proposed in the famous paper ["Attention Is All You Need"](https://arxiv.org/pdf/1706.03762) (2017).
A Transformer, according to the paper, is "a model architecture eschewing recurrence and instead relying entirely on an attention mechanism to draw global dependencies between input and output".

The paper is concerned with transduction models transforming an input sequence into an output sequence, which is different from regression or classification tasks. At the time of publication, Recurrent Neural Networks (RNNs) and Long Short-Term Memory Networks (LSTMs) were the dominant models for sequence transduction. Both are sequential in nature: they process the input one element at a time, carrying information from previous steps forward. This makes parallelizing training difficult. Transformers, on the other hand, process the entire input sequence at once, allowing for significantly more parallelization.

The Transformer has an encoder-decoder structure. The encoder reads the whole input and learns a rich set of representations. The decoder uses these representations to generate the output sequence one token at a time. The decoder is also auto-regressive: it feeds each generated token back as input for the next step, giving it access to all previously generated tokens. The trade-off is that token generation is sequential.

Both encoder and decoder are composed of a stack of identical layers, each with sub-layers that are either a multi-head self-attention function or a dense feed-forward network. Each sub-layer employs a residual connection, so the output is $\text{LayerNorm}(x + \text{Sublayer}(x))$. The residual connection helps mitigate the vanishing gradient problem: instead of rewriting the input at each layer, a layer just marks changes. If it has nothing to add, it passes the original input forward unchanged.

## Attention

When processing a token, attention allows the model to selectively focus on the other tokens most relevant to understanding the current one.

The process: compute a score between the query of the current token and the keys of all other tokens. Apply softmax to turn scores into weights that sum to 1. Multiply those weights by the values of the tokens to get a weighted blend of the most relevant tokens' contents:

$$
\text{Attention}(Q, K, V) = \text{softmax}\!\left(\frac{QK^\top}{\sqrt{d_k}}\right) V
$$

where $Q$ is the query matrix, $K$ is the key matrix, $V$ is the value matrix, and $d_k$ is the dimension of the key vectors. The scaling factor $\sqrt{d_k}$ prevents the dot products from growing too large, which would cause small gradients and slow convergence.

Rather than learning this attention function once, the Transformer learns multiple attention functions in parallel, each with different learned projections of $Q$, $K$, $V$. These are called *heads*, and the process is called **multi-head attention**. The outputs of each head are concatenated and projected to produce the final output. This allows direct, parallel, distance-independent access to all tokens, enabling the model to learn different types of relationships simultaneously.

The paper distinguishes three variants of attention:

| Type | Query from | Key/Value from | Purpose |
|---|---|---|---|
| **Self-attention** (encoder) | Input sequence | Input sequence | Each token attends to all other input tokens |
| **Self-attention** (decoder) | Output so far | Output so far | Each generated token attends to previous outputs |
| **Cross-attention** (decoder) | Output so far | Encoder output | Decoder attends to the full input while generating |

This attention mechanism feels a bit magical at first, but it developed gradually over years to solve the problem of extracting relevant information from sequences in RNNs. The authors then asked: if attention already handles long-range dependencies, why do we need RNNs at all? Pushing this idea to the extreme is one of the paper's main contributions.

## Positional encoding

Since the attention mechanism is order-agnostic, the model needs to be told the order of tokens in the sequence. This is done via positional encoding using sine and cosine waves of different frequencies across the dimensions of the positional vector:

$$
\text{PE}(\text{pos},\, 2i) = \sin\!\left(\frac{\text{pos}}{10000^{2i/d_{\text{model}}}}\right)
$$

$$
\text{PE}(\text{pos},\, 2i+1) = \cos\!\left(\frac{\text{pos}}{10000^{2i/d_{\text{model}}}}\right)
$$

where $\text{pos}$ is the token position in the sequence, $i$ is the dimension index within the positional vector, and $d_{\text{model}} = 512$.

Why use both sine and cosine? For any fixed offset $k$:

$$
\sin(\text{pos} + k) = \sin(\text{pos})\cos(k) + \cos(\text{pos})\sin(k)
$$

$$
\cos(\text{pos} + k) = \cos(\text{pos})\cos(k) - \sin(\text{pos})\sin(k)
$$

which means $\text{PE}(\text{pos} + k)$ is always a linear combination of $\text{PE}(\text{pos})$. Since the attention mechanism is designed to learn linear transformations, it can learn to "jump forward $k$ positions" and consistently attend to tokens that are exactly $k$ steps away, regardless of absolute position.

---

Nowadays, the Transformer has become a universal architecture, not just for language, but for vision, biology, code, audio, and multimodal tasks. Companies are scaling up resources and data to train ever-larger models. I wonder what comes next: will we just keep scaling indefinitely? It feels like time for a new architectural breakthrough beyond the Transformer.
