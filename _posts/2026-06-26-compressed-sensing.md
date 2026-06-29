---
layout: post
title: "Compressed Sensing"
date: 2026-06-26
tags: [signal-processing, compressed-sensing, FFT, sparsity]
math: true
---

This blog post is inspired by the [lecture series by Steve Brunton](https://youtube.com/playlist?list=PLMrJAkhIeNNRHP5UA-gIimsXLQyHXxRty&si=FAfZ7EjU1ioXrB1U) covering signal processing topics and compression.



Let the signal $x(t)$ be a function of time. We sample (uniformly!) that signal at a rate of $f_s$ samples per second, and get a vector of samples $x$. We can transform that vector into any other basis, for example, the Fourier basis. Note, that it can be any other orthogonal basis, for example PCA basis, wavelet basis, etc.

So, we can write the signal as a linear combination of basis functions:

$$
x = \sum_{i} s_i \phi_i
$$

where $\phi_i$ are the basis functions and $s_i$ are the coefficients. This can be written in matrix form as:

$$
x = \Phi s
$$

where $\Phi$ is the inverse DFT matrix (its columns are the Fourier basis vectors $\phi_i$) and $s$ is the vector of coefficients (frequencies).



## Nyquist-Shannon sampling theorem

The Nyquist-Shannon sampling theorem states that if the highest frequency in the signal is $f_{max}$, then we need to sample at a rate of more than $2 f_{max}$ samples per second to be able to reconstruct the signal. This is known as the Nyquist rate. This means that in order to perfectly reconstruct our original signal $x(t)$, we need to sample with $f_s > 2 f_{max}$.

This actually makes sense intuitively. Let us say our signal is just a cosine wave with a certain frequency $f$. If we sample at half the frequency, we will only get one sample per period, which means we will reconstruct a constant signal. If we sample with some frequency between $f/2$ and $f$, we will just get 1-2 points per period, which will result in a so-called "aliasing" effect, where the reconstructed signal will have a different (lower) frequency than the original one.

The Nyquist-Shannon theorem makes no assumption about sparsity, it only requires the signal to be bandlimited (a finite highest frequency). It therefore gives a worst-case rate that is safe even for dense signals that carry a lot of information and are not sparse in the frequency domain: we need to sample at more than twice the highest frequency in order to reconstruct the original signal without losing information. 


Let us consider a simple example of a sparse signal:

$$
    x(t) = \cos(2 \pi \cdot 5 \cdot t) + \sin(2 \pi \cdot 100 \cdot t)
$$


```python
n = 1000
t = np.linspace(0, 1, n, endpoint=False)
def my_signal(t):
    return np.cos(2 * np.pi * 5 * t) + np.sin(2 * np.pi * 100 * t)
x = my_signal(t)
```

![The original signal, a sum of a 5 Hz cosine and a 100 Hz sine, plotted over one second]({{ '/assets/images/compressed-sensing-original-signal.png' | relative_url }})


According to the Nyquist-Shannon theorem, we need to sample at the frequency larger than $2 \cdot 100 = 200$ Hz. Let us sample at $f_s = 201$ Hz, which is just above the Nyquist rate.

```python
n1 = 201
t1 = np.linspace(0, 1, n1, endpoint=False)
x1 = my_signal(t1)
```

Here we plot the sampled points:

![The signal sampled at 201 Hz, just above the Nyquist rate]({{ '/assets/images/compressed-sensing-samples-201hz.png' | relative_url }})

Note that the sampled points are not aligned with the peaks of the original signal, but we can still reconstruct the original signal from these samples.

Using the FFT we can reconstruct frequencies of the original signal:

```python
X = np.fft.rfft(x1, n=n1)  
freq = np.fft.rfftfreq(n1, d=1/n1)
PSD = np.abs(X) ** 2 / n1 * 2 # power spectrum density


print(f"Frequency components with larger power:")
fs_large_power = []
for f, p in zip(freq, PSD):
    if p > 2: # threshold for large power
        print(f"Frequency: {f} Hz, Power: {p}")
        fs_large_power.append(f)



plt.figure(figsize=(10, 4))
plt.plot(freq, PSD, marker='o', linestyle='None', markersize=6)
for f in fs_large_power:
    plt.axvline(x=f, color='red', linestyle='--', alpha=0.5)    
plt.title('Power Spectrum')
plt.xlabel('Frequency [Hz]')
plt.grid()


# plot only significant bins in the phase spectrum
threshold = 1e-6 * PSD.max()
phase_clean = np.where(PSD > threshold, np.angle(X), np.nan)

plt.figure(figsize=(10, 4))
plt.plot(freq, phase_clean, marker='o', linestyle='None', markersize=8)
for f in fs_large_power:
   plt.axvline(x=f, color='red', linestyle='--', alpha=0.5)
plt.title('Phase Spectrum (significant bins only)')
plt.xlabel('Frequency [Hz]')
plt.grid()
```

![Power and phase spectra recovered by the FFT at 201 Hz, with peaks at 5 Hz and 100 Hz]({{ '/assets/images/compressed-sensing-spectrum-201hz.png' | relative_url }})

Both frequencies are constructed correctly, and the phase spectrum is also correct. The cosine wave with frequency 5 Hz has a phase of 0, and the sine wave with frequency 100 Hz has a phase of $-\pi/2$.

---
Why do we get a phase of $-\pi/2$ for the sine wave? The Fourier transform of a sine wave is calculated from Euler's formula as follows:

$$
\mathcal{F}\{\sin(2 \pi f_0 t)\} = \frac{1}{2i} \left( \delta(f - f_0) - \delta(f + f_0) \right),
$$

where $\delta(f)$ is the Dirac delta function and $f_0$ is the frequency of the sine wave.

This is non-zero only at $f = f_0$ and $f = -f_0$. The coefficient at $f = f_0$ is $\frac{1}{2i} = -\frac{i}{2}$, which is purely (negative) imaginary, so its phase is

$$
\text{phase} = \operatorname{atan2}\left(\text{Im}, \text{Re}\right) = \operatorname{atan2}\left(-\tfrac{1}{2}, 0\right) = -\frac{\pi}{2}.
$$

---


Now let us try to sample with a lower frequency, for example $f_s = 60$ Hz, which is below the Nyquist rate. The obtained power and phase spectra are:

![Power and phase spectra at 60 Hz sampling, where the 100 Hz component aliases to a negative 20 Hz component]({{ '/assets/images/compressed-sensing-spectrum-60hz-aliasing.png' | relative_url }})

The sine wave is miscalculated! Now we have got a negative sine wave with frequency 20 Hz.


## Compressed sensing


The Nyquist-Shannon theorem assumes that signal is dense in a frequency domain and contains a lot of information.
But what if our signal is sparse in a frequency domain? For example, if it is a sum of just a few sinusoids or cosines as in the example above.

In this case, we can often sample with a lower frequency than the Nyquist rate and still be able to reconstruct the original signal. This is the idea behind compressed sensing. 

Instead of sampling the whole vector $x$, we can sample only a few points of it and get a measurement vector $y$:

$$
y = C x,
$$

where $C$ is a matrix that selects a few entries of the vector $x$ (in the code below, this is done by indexing $x$ with a set of random indices, which is equivalent to multiplying by such a selection matrix). Then we have 

$$
y = C \Phi s = \Theta s,
$$

where $\Theta = C \Phi$ is a new matrix that combines the sampling and the basis transformation. There are more columns than rows in the matrix $\Theta$, which means that we have an underdetermined system of equations. This means that there are infinitely many solutions for $s$ that satisfy the equation $y = \Theta s$. To obtain a unique solution, we impose a sparsity constraint on the solution $s$ by minimizing the $l_1$ norm of $s$, so we want to find a solution to this minimization problem:

$$
\min \lVert s \rVert_1 \quad \text{subject to} \quad y = \Theta s.
$$

---
Why minimizing the $l_1$ norm? The $l_1$ norm is defined as the sum of the absolute values of the vector coefficients:

$$
\lVert s \rVert_1 = \sum_i \lvert s_i \rvert.
$$

Minimizing the $l_1$ norm means favoring the solution with fewer non-zero coefficients.

---

Important to note that sampling in this case should be done randomly, not uniformly! With uniform sampling, we will still get aliasing effects. But with random sampling we will get many points in some regions and few points in other regions. 


We start by randomly sampling $m$ points from the original signal $x$ to get the measurement vector $y$:

```python
m = 30 # number of samples
C = np.random.choice(n, size=m, replace=False)
y = x[C]
```

![Thirty randomly chosen samples drawn from the original signal]({{ '/assets/images/compressed-sensing-random-samples.png' | relative_url }})

Then we construct matrix $\Theta$ by selecting the corresponding rows of the inverse DFT matrix $\Phi$:

```python
Phi = np.fft.ifft(np.eye(n))
Theta = Phi[C, :]
```

We are using python package `cvxpy` to solve the optimization problem for the sparse vector $s$:

```python
# solve the l1 minimization problem using cvxpy: y = Theta @ s
import cvxpy as cp

n = Theta.shape[1]

s = cp.Variable(n, complex=True) 
objective = cp.Minimize(cp.norm(s, 1))
constraints = [Theta @ s == y]

problem = cp.Problem(objective, constraints)
problem.solve()

s_l1 = s.value
```

The obtained frequencies and phases are:

![Frequencies and phases recovered by l1 minimization from only 30 random samples, matching the original signal]({{ '/assets/images/compressed-sensing-l1-reconstruction.png' | relative_url }})


With only 30 random samples, we were able to reconstruct the original signal with the correct frequencies and phases!  