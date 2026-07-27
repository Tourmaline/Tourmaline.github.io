# Groups & Irreducible Representations — question deck

Source: `_posts/2026-07-03-groups-Irreps.md`. Answer before expanding.

---

## T1 · Recall

**Q1.** State the four group axioms for $(G, *)$.

<details><summary>answer</summary>

1. **Closure** — $a*b \in G$ for all $a,b\in G$.
2. **Associativity** — $(g*h)*k = g*(h*k)$.
3. **Identity** — $\exists\, e$ with $e*g = g*e = g$.
4. **Invertibility** — $\forall g\ \exists\, g^{-1}$ with $g*g^{-1}=g^{-1}*g=e$.

(Commutativity is *not* required — a group that also has it is *abelian*.)
</details>

**Q2.** What is a representation $\rho$? Give its signature and say what it does.

<details><summary>answer</summary>

$\rho: G \to GL(V)$ — a concrete rule mapping each abstract group element to an
invertible matrix acting on a vector space $V$, respecting the group operation
($\rho(g*h) = \rho(g)\rho(h)$). In 1D, $GL(V)$ is just the nonzero reals. The
group is the abstract "pattern"; the representation is how it *acts*.
</details>

**Q3.** Define an irreducible representation. What's special about the irreps of
an abelian group?

<details><summary>answer</summary>

An **irrep** is a representation with no nontrivial invariant subspace — it
can't be decomposed into smaller representations (block-diagonalised further).
For **abelian** groups, all irreps are **1-dimensional**.
</details>

**Q4.** $S_2 = \{e,\tau\}$ has two 1D irreps. Name and give them.

<details><summary>answer</summary>

- **Trivial**: $\rho_1(e)=1,\ \rho_1(\tau)=1$.
- **Sign**: $\rho_2(e)=1,\ \rho_2(\tau)=-1$.
</details>

---

## T2 · Derive (blank page!)

**Q5.** Show that a 1D irrep of $S_2$ must send $\tau$ to $\pm 1$.

<details><summary>answer</summary>

A 1D irrep is a scalar $\lambda = \rho(\tau)$. Since $\tau$ is its own inverse,
$\tau^2 = e$, so $\lambda^2 = \rho(\tau)^2 = \rho(\tau^2) = \rho(e) = 1$. Hence
$\lambda = \pm 1$ — exactly the trivial ($+1$) and sign ($-1$) irreps.
</details>

**Q6.** The 2D swap representation is $\rho(\tau)=\begin{psmallmatrix}0&1\\1&0\end{psmallmatrix}$.
Show it decomposes as $\rho \cong \rho_1 \oplus \rho_2$, and give the change of
basis $U$.

<details><summary>answer</summary>

Diagonalise $\rho(\tau)$: eigenvalues $+1$ (eigenvector $(1,1)/\sqrt2$) and $-1$
(eigenvector $(1,-1)/\sqrt2$). So
$$U = \tfrac{1}{\sqrt2}\begin{pmatrix}1&1\\1&-1\end{pmatrix},\qquad
\rho(\tau) = U\begin{pmatrix}1&0\\0&-1\end{pmatrix}U^{-1}.$$
The $+1$ block is $\rho_1$, the $-1$ block is $\rho_2$. $U$ is orthonormal so
$U^{-1}=U^T$. The eigenvectors are the symmetric part $a+b$ and antisymmetric
part $a-b$.
</details>

**Q7.** In the new basis, $v'=U^Tv$. Compute it for $v=(a,b)^T$ and interpret.

<details><summary>answer</summary>

$v' = U^T v = \tfrac{1}{\sqrt2}\begin{pmatrix}a+b\\a-b\end{pmatrix}$ — the
symmetric (sum) and antisymmetric (difference) coordinates. The swap $\tau$
leaves $a+b$ fixed and flips the sign of $a-b$: the two irreps.
</details>

**Q8.** For an $S_2$-symmetric model $M$ (satisfying $M(v,u)^T=(b,a)^T$ when
$M(u,v)^T=(a,b)^T$), show that in the irrep basis $\widetilde M = U^TMU$ must be
**diagonal**.

<details><summary>answer</summary>

Equivariance means $M$ commutes with the swap: $M\rho(\tau)=\rho(\tau)M$. In the
basis that diagonalises $\rho(\tau)$ (distinct eigenvalues $+1,-1$), any matrix
commuting with a diagonal matrix of distinct eigenvalues is itself diagonal —
so $\widetilde M = \operatorname{diag}(\widetilde m_{11},\widetilde m_{22})$.
Schur's lemma in miniature: symmetry forces the operator to act as a single
scalar on each irrep. Two free parameters instead of four.
</details>

---

## T3 · Apply

**Q9.** A vector's symmetric coordinate is 5 and antisymmetric is 1. Recover
$(a,b)$.

<details><summary>answer</summary>

$v = Uv' $ with $v'=(5,1)^T/\!$... careful with the $\tfrac1{\sqrt2}$: since
$v'=\tfrac1{\sqrt2}(a+b,\,a-b)$, we have $a+b=5\sqrt2,\ a-b=\sqrt2$, so
$a = 3\sqrt2,\ b = 2\sqrt2$. (If instead you're told the *raw* sum/diff are 5
and 1: $a=3,b=2$.)
</details>

**Q10.** Why does working in the irrep basis make an equivariant model cheaper
to fit?

<details><summary>answer</summary>

$\widetilde M$ is diagonal, so the model decouples into independent scalar
gains — one per irrep — instead of a full dense matrix. Fewer parameters, no
cross-terms, and each irrep can be learned/analysed separately. This is the
toy version of why symmetry (equivariance) shrinks parameter counts in modern
architectures.
</details>

---

## T4 · Connect / transfer

**Q11.** How is this the same underlying move as PCA?

<details><summary>answer</summary>

Both are **change of basis to diagonalise a structured operator**. PCA
diagonalises the covariance $C$ (its eigenbasis $V$ decorrelates the data). Rep
theory diagonalises/block-diagonalises every $\rho(g)$ at once (basis $U$ =
eigenvectors of the generator). "Pick the basis where the operator is as simple
as possible." See `linear-algebra-pca.md`, Q12.
</details>

**Q12.** Give three groups and their identity + inverse, from memory.

<details><summary>answer</summary>

- $(\mathbb{Z},+)$: identity $0$, inverse of $n$ is $-n$.
- $(\mathbb{R}^*,\times)$: identity $1$, inverse of $x$ is $1/x$.
- $S_n$ (permutations): identity = do-nothing permutation, inverse = the
  reversing permutation. Also: $D_n$, $GL(n,\mathbb R)$, $\mathbb Z/n\mathbb Z$.
</details>
