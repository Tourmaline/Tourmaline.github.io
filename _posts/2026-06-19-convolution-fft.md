---
layout: post
title: "Convolution and the FFT"
date: 2026-06-19
tags: [signal-processing, FFT, convolution]
math: true
---

## Convolution

Imagine a system which produces an impulse $a[t]$ at each timestep $t = 0,1,2,3$. When an impulse is produced the system responds with a certain signal $b = [b_0, b_1, b_2]$ which fades away in time.

The process can be visualized as:

| time: |    0    |    1    |    2    |    3    |    4    |    5    |
| ---   | ---     | ---     | ---     | ---     | ---     | ---     |
| a[0]: | $a[0]b_0$ | $a[0]b_1$ | $a[0]b_2$ |         |         |         |
| a[1]: |         | $a[1]b_0$ | $a[1]b_1$ | $a[1]b_2$ |         |         |
| a[2]: |         |         | $a[2]b_0$ | $a[2]b_1$ | $a[2]b_2$ |         |
| a[3]: |         |         |         | $a[3]b_0$ | $a[3]b_1$ | $a[3]b_2$ |

Then at timestep 2 we have the total signal $out[2] = a[0]b_2 + a[1]b_1 + a[2]b_0$.
This is the intuition behind the convolution formula:

$$
out[t] = \sum_{k = 0}^{\text{len}(a)-1} a[k]\, b_{t-k}, \quad \text{for } t = 0, 1, 2, 3, 4, 5
$$

Note that here we have assumed padding with zeros, so that $b_{t-k} = 0$ for $t-k < 0$ or $t-k \geq \text{len}(b)$. This is an example of linear convolution, and it is the most common type of convolution in signal processing.

An alternative is circular convolution, where we assume that the signals are periodic. Here both vectors are treated as length $N$; we pad the shorter one with zeros. $N$ is a free choice as long as $N \geq \max(\text{len}(a), \text{len}(b))$ — and, as we will see in the FFT section, picking $N \geq \text{len}(a) + \text{len}(b) - 1$ makes the circular result coincide with the linear one. For now take $N = \max(\text{len}(a), \text{len}(b)) = 4$. The convolution formula becomes:

$$
out[t] = \sum_{k = 0}^{N-1} a[k]\, b_{(t-k) \bmod N}, \quad \text{for } t = 0, 1, 2, 3
$$

The terms that would fall off the end of the linear convolution now wrap around to the start. With $N = 4$, the tail at $t = 4$ wraps to $t = 0$ and the tail at $t = 5$ wraps to $t = 1$ (wrapped terms marked with $*$):

| time: |    0      |    1      |    2      |    3      |
| ---   | ---       | ---       | ---       | ---       |
| a[0]: | $a[0]b_0$ | $a[0]b_1$ | $a[0]b_2$ |           |
| a[1]: |           | $a[1]b_0$ | $a[1]b_1$ | $a[1]b_2$ |
| a[2]: | $a[2]b_2^*$ |         | $a[2]b_0$ | $a[2]b_1$ |
| a[3]: | $a[3]b_1^*$ | $a[3]b_2^*$ |       | $a[3]b_0$ |

So for circular convolution $out[0] = a[0]b_0 + a[2]b_2 + a[3]b_1$, while $out[2] = a[0]b_2 + a[1]b_1 + a[2]b_0$ stays the same as in the linear case.



## Cross-correlation

Cross-correlation is a similar operation to convolution, but without the time flip of the second signal. Where convolution uses $b_{t-k}$ (the template reversed), cross-correlation slides the unflipped template $b$ over $a$:
$$
out[n] = \sum_{k} a[n+k]\, b_k
$$

Here $n$ is a *lag*: it shifts the template $b$ to position $n$ in $a$. Unlike convolution, the lag can be negative as well as positive. For our example ($\text{len}(a) = 4$, $\text{len}(b) = 3$) the overlapping lags run from $n = -2$ to $n = 3$, giving $\text{len}(a) + \text{len}(b) - 1 = 6$ outputs. For instance $out[0] = a[0]b_0 + a[1]b_1 + a[2]b_2$ (template aligned at the start), while $out[1] = a[1]b_0 + a[2]b_1 + a[3]b_2$ (template slid one step to the right).

While convolution looks at the accumulated effect of a system, cross-correlation measures how much the template signal $b$ matches the input signal $a$ at each lag. It peaks at the shift where the two line up best, which is why it is used for pattern matching and alignment.


## Discrete Fourier Transform

Discrete Fourier Transform (DFT) rewrites a signal in a different coordinate system, where the basis vectors are complex exponentials (sines and cosines). So it converts a signal of N samples into N frequency components, each representing the amplitude and phase of a particular frequency in the original signal.

Euler's formula says $e^{-ix} = \cos x - i \sin x$.

We define cosine and sine waves which are determined by their frequency $j$:
$\cos(2\pi j n / N)$ and $\sin(2\pi j n / N)$, where $n$ indicates where along that wave we are. 

![Cosine waves at frequencies j=1 and j=7 sharing the same sample points]({{ '/assets/images/image-dft-cosine-symmetry.png' | relative_url }})

![Sine waves at frequencies j=1 and j=7 with sample points of equal magnitude but opposite sign]({{ '/assets/images/image-dft-sine-symmetry.png' | relative_url }})

Let $x[n]$ be the original signal, where $n = 0, 1, \ldots, N-1$.
At frequency j, the DFT computes two real numbers:
$$
C_j = \sum_{n=0}^{N-1} x[n] \cos(2\pi j n / N)
$$
and
$$
S_j = \sum_{n=0}^{N-1} x[n] \sin(2\pi j n / N).
$$
These represent how much of the cosine and sine wave at frequency j is present in the original signal. The DFT combines these into a single complex number:
$$
X_j = C_j - i S_j
$$
Equivalently, expanding the cosine and sine via Euler's formula, this is the single complex sum
$$
X_j = \sum_{n=0}^{N-1} x[n]\, e^{-i 2\pi j n / N},
$$
which is the form we will use for the FFT.


The magnitude of $X_j$ is $|X_j| = \sqrt{C_j^2 + S_j^2}$, which gives the amplitude of the frequency component, while the angle (or phase) of $X_j$ is $\phi_j = \arctan\frac{-S_j}{C_j}$ (the imaginary part of $X_j$ is $-S_j$), which indicates how much that frequency is shifted in time.


### A note on the real case

If signal $x[n]$ is real-valued, then the DFT has a symmetry property: $X_{N-j} = \overline{X_j}$, where $\overline{X_j} = C_j + i S_j$ is the complex conjugate of $X_j$. 
See the plots above, which demonstrate this symmetry for $N = 8$ (so $j$ and $N-j$ pair up, e.g. $j=1$ with $j=7$). Even if the actual cosine and sine waves are different, the DFT sees only the sample points (orange points). For example, for the cosine wave the sample points in waves $j=7$ and $j=1$ have identical locations. And for the sine wave the sample points in waves $j=7$ and $j=1$ have identical magnitudes, but with opposite signs.

This symmetry means that the DFT of a real-valued signal is redundant, and we only need to compute the first $\lfloor N/2 \rfloor + 1$ frequency components to capture all the information.

## Fast Fourier Transform

The FFT uses symmetry properties of the DFT to compute it efficiently. In the FFT algorithm, we split the DFT formula into two parts: one for the even-indexed samples and one for the odd-indexed samples:
$$
X_j = E_j + W_j O_j,
$$
where $E_j = \sum_{n=0}^{N/2-1} x[2n] e^{-i 2\pi j n / (N/2)}$ is the DFT of the even-indexed samples, $O_j = \sum_{n=0}^{N/2-1} x[2n+1] e^{-i 2\pi j n / (N/2)}$ is the DFT of the odd-indexed samples, and $W_j = e^{-i 2\pi j / N}$ is the twiddle factor.

Then we notice that $E_j$ and $O_j$ are themselves DFTs of size $N/2$, and $E_{j+N/2} = E_j$, $O_{j+N/2} = O_j$ (both periodic with period $N/2$). Moreover,  $W_{j+N/2} = e^{-i 2\pi (j+N/2) / N} = e^{-i 2\pi j / N} \cdot e^{-i \pi} = -W_j$.

In summary, we get the following recursive formulas:
$$
X_j = E_j + W_j O_j, \quad \text{for } j = 0, 1, \ldots, N/2-1
$$
$$
X_{j+N/2} = E_j - W_j O_j, \quad \text{for } j = 0, 1, \ldots, N/2-1
$$

For the best performance, we typically choose $N$ to be a power of 2, so that we can keep halving the size of the DFT all the way down to size 1. The base case of the recursion is when $N=1$, where the DFT is just the identity: $X_0 = x[0]$.

The complexity of the FFT algorithm is $O(N \log N)$, where $N$ is the length of the input signal, which is a significant improvement over the naive DFT computation that has complexity $O(N^2)$.

## Convolution via the FFT

**Convolution in the time domain equals pointwise multiplication in the frequency domain.**


The core idea is:
$$
\text{conv}(a, b) = \text{IFFT}(\text{FFT}(a_\text{padded}) \cdot \text{FFT}(b_\text{padded}))
$$
This turns an $O(N \cdot M)$ operation into $O(N' \log N')$, where $N' = \text{len}(a_\text{padded}) = \text{len}(b_\text{padded}) = N + M - 1$. 

Note that pointwise multiplication in the frequency domain corresponds to *circular* convolution in the time domain, so we need to pad the input signals with zeros to prevent wrap-around effects. For linear convolution, we pad both signals to length $N' = N + M - 1$, where $N$ and $M$ are the lengths of the original signals. This ensures that the circular convolution computed by the FFT corresponds to the desired linear convolution. 


```python
import numpy as np

def convolution_fft(a, b):
    N = len(a)
    M = len(b)
    N_padded = N + M - 1
    
    n_fft = 1 << (N_padded - 1).bit_length()  # next power of 2
    
    A = np.fft.fft(a, n=n_fft)
    B = np.fft.fft(b, n=n_fft)
    C = A * B
    conv_result = np.fft.ifft(C)
    
    return conv_result[:N_padded]  # the valid part of the convolution


a = np.array([1, 2, 3, 4], dtype=float)
b = np.array([0.5, 0.5], dtype=float)

print(convolution_fft(a, b)) # [0.5+0.j, 1.5+0.j, 2.5+0.j, 3.5+0.j, 2.0+0.j]
print(np.convolve(a, b))   # sanity check 
```

Like convolution, cross-correlation is computable via the FFT, with one extra conjugation (and the same zero-padding to avoid wrap-around):
$$
\text{corr}(a, b) = \text{IFFT}(\text{FFT}(a) \cdot \overline{\text{FFT}(b)})
$$