# PCA — question deck

Source: `_posts/2026-07-02-PCA.md`. Answer before expanding.

---

## T1 · Recall

**Q1.** In one sentence, what does PCA optimise for, and what is the shape of
the data matrix $X$?

<details><summary>answer</summary>

PCA finds a new orthogonal basis (a rotation of feature space) that maximises
the variance captured in the first few coordinates — reducing dimensionality
while preserving as much variance/information as possible. $X \in
\mathbb{R}^{n\times m}$: $n$ samples (rows), $m$ features (columns), $n \ge m$.
</details>

**Q2.** What preprocessing step must happen first, and what matrix do you
eigendecompose?

<details><summary>answer</summary>

Center each feature to zero mean: $B = X - \tfrac1n \mathbf{1}\mathbf{1}^T X$.
Then eigendecompose the $m\times m$ covariance matrix
$C = \tfrac{1}{n-1} B^T B$.
</details>

**Q3.** Why is $C$ guaranteed to have real, non-negative eigenvalues and
orthogonal eigenvectors?

<details><summary>answer</summary>

$C$ is symmetric (so the spectral theorem gives real eigenvalues and an
orthogonal eigenbasis) and positive semi-definite (it's a Gram matrix
$\propto B^TB$, so $x^TCx = \tfrac{1}{n-1}\|Bx\|^2 \ge 0$), forcing
$\lambda_j \ge 0$.
</details>

**Q4.** What exactly *is* a principal component (the object, not the axis)?

<details><summary>answer</summary>

The projection of the centered data onto an eigenvector: $Bv_j$. The $v_j$ are
the principal **axes/directions**; the $Bv_j$ are the principal **components**
(the new coordinates / scores).
</details>

---

## T2 · Derive (blank page!)

**Q5.** Prove $\operatorname{var}(Bv_j) = \lambda_j$.

<details><summary>answer</summary>

$Bv_j$ is centered (since $B$ is), so its mean is 0 and
$$\operatorname{var}(Bv_j) = \tfrac{1}{n-1}\|Bv_j\|_2^2
= \tfrac{1}{n-1} v_j^T B^T B v_j = v_j^T C v_j.$$
With $Cv_j = \lambda_j v_j$ and $\|v_j\|=1$: $v_j^T C v_j = \lambda_j v_j^Tv_j =
\lambda_j$. So each eigenvalue **is** the variance along its principal axis.
</details>

**Q6.** Why are the principal components mutually uncorrelated?

<details><summary>answer</summary>

$\operatorname{cov}(Bv_i, Bv_j) \propto v_i^T B^T B v_j = v_i^T C v_j =
\lambda_j\, v_i^Tv_j = 0$ for $i\ne j$, because eigenvectors of a symmetric
matrix are orthogonal. Diagonalising $C$ = decorrelating the features.
</details>

**Q7.** Via the SVD $B = U\Sigma V^T$, relate the singular values $\sigma_j$ of
$B$ to the eigenvalues $\lambda_j$ of $C$.

<details><summary>answer</summary>

$B^TB = V\Sigma^TU^TU\Sigma V^T = V(\Sigma^T\Sigma)V^T$. Compare with the
eigendecomposition $C = \tfrac{1}{n-1}B^TB = VDV^T$: so
$\Sigma^T\Sigma = (n-1)D$, giving $\sigma_j = \sqrt{(n-1)\lambda_j}$.
Also $Bv_j = \sigma_j u_j$ — the $u_j$ are unit vectors and $\sigma_j$ is the
length of the projection.
</details>

---

## T3 · Apply

**Q8.** In the Gaussian-cloud demo the data is built with $S=\operatorname{diag}(2,\,0.5)$
before rotation/shift. What standard deviations should PCA recover along the two
principal axes, and via which formula from the singular values?

<details><summary>answer</summary>

$\approx 2$ and $\approx 0.5$. Rotation and translation don't change the
variances along the intrinsic axes; PCA undoes the rotation. Recover via
$\text{std} = \sigma/\sqrt{n-1}$ (the post gets `[1.95, 0.49]`).
</details>

**Q9.** You keep the top $k$ principal components. What fraction of the total
variance have you retained?

<details><summary>answer</summary>

$\dfrac{\sum_{j=1}^{k}\lambda_j}{\sum_{j=1}^{m}\lambda_j}$ — the "explained
variance ratio". You choose $k$ to hit a target (e.g. 95%).
</details>

---

## T4 · Connect / transfer

**Q10.** Numerically, why is it often better to SVD $B$ directly than to form
$C=B^TB$ and eigendecompose it?

<details><summary>answer</summary>

Forming $B^TB$ **squares the condition number** — small singular values get
lost to floating-point error, and you can produce tiny negative "eigenvalues"
for a PSD matrix. SVD of $B$ works on the raw data, is more numerically stable,
and avoids materialising $C$ (better when $m$ is large).
</details>

**Q11.** PCA's core limitation and what to reach for instead?

<details><summary>answer</summary>

Principal components are **linear** combinations of features, so PCA can't
capture nonlinear structure (curved manifolds). Alternatives: kernel PCA,
t-SNE / UMAP, autoencoders.
</details>

**Q12.** (Bridge to the groups deck.) PCA and irreducible-representation
decomposition are the *same move* under the hood. What is it?

<details><summary>answer</summary>

Both find a **change of basis that diagonalises** a structured matrix. PCA:
choose the eigenbasis $V$ of the covariance $C$ so it becomes diagonal
(decorrelated, variances on the diagonal). Rep theory: choose the basis $U$
(eigenvectors of $\rho(\tau)$) so every $\rho(x)$ becomes block-diagonal
(decoupled into independent irreps). "Find the basis where the operator is as
simple as possible" is the shared idea. See `linear-algebra-groups-irreps.md`.
</details>
