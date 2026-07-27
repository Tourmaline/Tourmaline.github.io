# Equivariance & Block Structure — question deck

Extends `linear-algebra-groups-irreps.md` (especially its Q8) and
`_posts/2026-07-03-groups-Irreps.md`. Answer before expanding.

Three running examples, reused throughout the deck:

- **Warm-up** — two microphones, a scalar readout $M:\mathbb{R}^2\to\mathbb{R}$.
- **Mirror** — three sensors in a *row* (left, centre, right) on a rod,
  symmetric about the midpoint. Group $S_2$.
- **Ring** — three sensors in a *cycle*. Group $\mathbb{Z}/3$.

The point of the deck: Q8 of the other deck gives a *fully diagonal* answer, and
that is the lucky special case. These examples show what the general answer
looks like — and there are two quite different reasons a block can fail to
shrink.

---

## T1 · Recall

**Q1.** Define an **equivariant** map. Why is it described as "respecting the
group action"?

<details><summary>answer</summary>

A map $M: V \to W$ between two representations is equivariant if

$$M\,\rho_{\text{in}}(g) = \rho_{\text{out}}(g)\,M \qquad \text{for all } g \in G.$$

In words: **transform-then-map = map-then-transform.** The square

```
        x  ─────── M ──────>  Mx
        │                      │
   ρ_in(g)                 ρ_out(g)
        │                      │
        v                      v
   ρ_in(g)·x ──── M ──────>  ρ_out(g)·Mx
```

commutes. "Respects" is the same word used in two things you already know —
every row below has the identical shape *(do the operation, then map)* = *(map,
then do the operation)*:

| structure | map respecting it | equation |
|---|---|---|
| group operation | homomorphism | $f(a*b) = f(a)f(b)$ |
| addition / scaling | linear map | $M(x+y) = Mx + My$ |
| group **action** | **equivariant map** | $M(g\cdot x) = g\cdot(Mx)$ |

A vector space is a set with addition; a *representation* is a vector space
with a group action layered on top. Linearity respects the first layer,
equivariance the second.
</details>

**Q2.** What is the difference between an **invariant** and an **equivariant**
map? Is one a special case of the other?

<details><summary>answer</summary>

- **Invariant**: the output does not move. $M(g\cdot x) = Mx$.
- **Equivariant**: the output moves *correspondingly*. $M(g\cdot x) = g\cdot Mx$.

Invariance is the special case of equivariance where $\rho_{\text{out}}$ is the
**trivial** rep, so $g$ acts on the output by multiplying by $1$. Respecting the
action does *not* mean ignoring it.
</details>

**Q3.** In the other deck's Q8 the condition was just $M\rho(\tau) = \rho(\tau)M$
— plain commutation. Why does it collapse to that, and what does the compact
form hide?

<details><summary>answer</summary>

Input and output are both $\mathbb{R}^2$ carrying the *same* rep, so
$\rho_{\text{in}} = \rho_{\text{out}}$ and the two-$\rho$ condition becomes a
commutator between two same-sized matrices.

What it hides: you can no longer see that one $\rho$ acts on the **input** and
the other on the **output**, so $M$ and $\rho(\tau)$ start looking like peers
when they are nothing of the sort — $\rho$ is *given* (the symmetry of the
world, no free parameters), $M$ is *chosen* (the model, all free parameters).

The warm-up below is the antidote: with $M$ of shape $1\times2$, "commutes" is
not even type-correct. The two-$\rho$ form is the real definition; commutation
is a coincidence of the square case.
</details>

**Q4.** State Schur's lemma in the form you actually use when block-structuring
a matrix.

<details><summary>answer</summary>

For irreps $W_i, W_j$:

- $\operatorname{Hom}_G(W_i, W_j) = 0$ when $W_i \not\cong W_j$ — **non-isomorphic
  irreps cannot talk to each other.**
- $\operatorname{End}_G(W_i)$ is a division algebra — over $\mathbb{C}$ just the
  scalars; over $\mathbb{R}$ it is $\mathbb{R}$, $\mathbb{C}$ or $\mathbb{H}$.

Consequence: an equivariant $M$ is **block-diagonal, one block per irrep**, and
every off-diagonal (irrep $i$ → irrep $j$) block vanishes. The zeros are Schur,
not arithmetic luck.
</details>

---

## T2 · Derive (blank page!)

**Q5.** *Warm-up.* Two microphones; $M: \mathbb{R}^2 \to \mathbb{R}$ is a row
vector $(p,q)$, and $\rho_{\text{in}}(\tau) = \begin{pmatrix}0&1\\1&0\end{pmatrix}$.
Solve for $(p,q)$ when (a) the readout is unchanged under the swap
($\rho_{\text{out}}(\tau)=1$), and (b) it flips sign ($\rho_{\text{out}}(\tau)=-1$).
Interpret both in irrep language.

<details><summary>answer</summary>

$(p,q)\rho_{\text{in}}(\tau) = (q,p)$, so:

- **(a)** $(q,p) = (p,q) \Rightarrow q = p$. So $M = p(1,1)$, i.e. $Mx = p(x_L+x_R)$.
- **(b)** $(q,p) = -(p,q) \Rightarrow q = -p$. So $M = p(1,-1)$, i.e. $Mx = p(x_L-x_R)$.

One free parameter each, down from two.

**Irrep reading.** The source is $\rho_1 \oplus \rho_2$ (trivial ⊕ sign, spanned
by $(1,1)$ and $(1,-1)$); the target carries one irrep. By Schur the
non-matching component must die and the matching one is a scalar, so each case
is **a scalar multiple of the projection onto one isotypic component**:

- (a) kills the sign irrep ($\ker M = \operatorname{span}(1,-1)$), keeps the
  trivial one. A loudness detector is *structurally* blind to imbalance.
- (b) kills the trivial irrep ($\ker M = \operatorname{span}(1,1)$), keeps the
  sign one. A balance detector is blind to overall level.

Those projections are the group-averaging operators
$P_{1,2} = \tfrac12\big(I \pm \rho(\tau)\big)$, which is how you build them for
any finite group.
</details>

**Q6.** *Mirror.* Three sensors in a row; $\sigma$ swaps left and right and
fixes the centre. Write $\rho(\sigma)$ and state the equivariance condition.

<details><summary>answer</summary>

$$\rho(\sigma) = P = \begin{pmatrix}0&0&1\\0&1&0\\1&0&0\end{pmatrix},
\qquad P^2 = I,$$

and equivariance is $MP = PM$ (same rep in and out again). Equivalently, since
$P^{-1}=P$: $M = PMP$.
</details>

**Q7.** How many of the nine entries of $M$ survive? Do it with the **orbit
trick**, not nine simultaneous equations.

<details><summary>answer</summary>

Conjugating by a permutation matrix permutes rows *and* columns, so $M = PMP$
says

$$M_{ij} = M_{\sigma(i)\,\sigma(j)}$$

— entries are **constant on orbits of index pairs**. With $\sigma = (1\,3)$ the
nine pairs fall into five orbits: $\{11,33\}$, $\{13,31\}$, $\{12,32\}$,
$\{21,23\}$, $\{22\}$. Hence

$$M = \begin{pmatrix} a & b & c \\ d & e & d \\ c & b & a \end{pmatrix},
\qquad \textbf{5 free parameters of 9.}$$

Equivariance alone cut the count *before* any change of basis. The orbit trick
is what scales to bigger groups.
</details>

**Q8.** Find the eigenvectors of $\rho(\sigma)$, note the **multiplicities**,
build $U$, and compute $\widetilde M = U^T M U$. Is it diagonal?

<details><summary>answer</summary>

Eigenvectors: $+1$ for both $(1,0,1)/\sqrt2$ and $(0,1,0)$; $-1$ for
$(1,0,-1)/\sqrt2$. So the **trivial irrep has multiplicity 2** and the sign
irrep multiplicity 1 — this is where it stops resembling the other deck's Q8.
Ordering the basis (trivial, trivial, sign),

$$U = \begin{pmatrix} \tfrac1{\sqrt2} & 0 & \tfrac1{\sqrt2} \\
0 & 1 & 0 \\ \tfrac1{\sqrt2} & 0 & -\tfrac1{\sqrt2}\end{pmatrix},
\qquad
\widetilde M = \begin{pmatrix} a+c & \sqrt2\,b & 0 \\
\sqrt2\,d & e & 0 \\ 0 & 0 & a-c \end{pmatrix}.$$

**Not diagonal** — block-diagonal, one $2\times2$ block and one $1\times1$.
Note $4 + 1 = 5$, matching Q7. That agreement is the whole point.
</details>

**Q9.** Why did the other deck's Q8 give a *fully diagonal* answer while this
one does not? State the general rule covering both.

<details><summary>answer</summary>

The diagonality argument needs $\rho$ to have **distinct** eigenvalues. Here
$+1$ is repeated, so the trivial isotypic component is a 2-plane — and the
symmetry supplies **no preferred axes inside it**. Any orthonormal basis of
$\operatorname{span}\{(1,0,1),(0,1,0)\}$ is equally valid and gives a different
(conjugate) $2\times2$ block. Symmetry says "these two directions may mix with
each other but neither may touch the antisymmetric one"; it does not say which
combination to prefer.

**General rule:** symmetry forces $\widetilde M$ to be **block-diagonal, one
block per irrep, of size (multiplicity × multiplicity)**. Fully diagonal is the
special case where every multiplicity is 1.
</details>

**Q10.** *Ring.* Three sensors in a cycle, $r: 1\to2\to3\to1$. Write $\rho(r)$
and derive the equivariant form of $M$.

<details><summary>answer</summary>

$$\rho(r) = C = \begin{pmatrix}0&0&1\\1&0&0\\0&1&0\end{pmatrix},
\qquad C^3 = I,$$

the cyclic shift. Orbit trick with $\pi = (1\,2\,3)$: the nine index pairs fall
into **three** orbits — the diagonal $\{11,22,33\}$ and the two cycles
$\{12,23,31\}$, $\{13,21,32\}$. So

$$M = \begin{pmatrix}\alpha&\beta&\gamma\\\gamma&\alpha&\beta\\
\beta&\gamma&\alpha\end{pmatrix}
= \alpha I + \gamma C + \beta C^2,
\qquad \textbf{3 free parameters.}$$

A **circulant** — a cyclic convolution filter with taps $(\alpha,\gamma,\beta)$.
Note every equivariant $M$ is a *polynomial in $C$*; that is the whole of Q11 in
disguise. Bigger group ⟹ fewer orbits ⟹ fewer parameters.
</details>

**Q11.** Diagonalise the ring case over $\mathbb{C}$. What are the eigenvalues,
and what is the change-of-basis matrix?

<details><summary>answer</summary>

$C$ has characteristic polynomial $\lambda^3 = 1$, so eigenvalues
$1, \omega, \omega^2$ with $\omega = e^{2\pi i/3}$ — **three distinct** values,
so the Q8 argument applies and $\widetilde M$ is fully diagonal. The
eigenvectors are the DFT vectors $f_k = \tfrac1{\sqrt3}(1,\omega^{-k},\omega^{-2k})$,
so $U = F$, the unitary DFT matrix:

$$F^{\dagger} C F = \operatorname{diag}(1,\omega,\omega^2), \qquad
F^{\dagger} M F = \operatorname{diag}\big(P(1),\,P(\omega),\,P(\omega^2)\big)$$

where $P(z) = \alpha + \gamma z + \beta z^2$. Since $M = P(C)$, its eigenvalues
are just $P$ evaluated at the eigenvalues of $C$. Explicitly

$$\lambda_0 = \alpha+\beta+\gamma, \qquad
\lambda_{1,2} = \alpha - \tfrac{\beta+\gamma}{2} \mp \tfrac{\sqrt3}{2}(\beta-\gamma)\,i.$$

Three complex numbers, but $\lambda_1 = \overline{\lambda_2}$ — still 3 real
degrees of freedom, as it must be.
</details>

**Q12.** What goes wrong if you insist on a **real** basis for the ring case?

<details><summary>answer</summary>

The conjugate pair is the obstruction. $\chi: r\mapsto\omega$ and
$\bar\chi: r\mapsto\omega^2$ are 1-dimensional irreps that exist only over
$\mathbb{C}$; over $\mathbb{R}$ they fuse into a single **2-dimensional real
irrep** — rotation by $120°$. Taking real and imaginary parts of $f_1$ gives the
orthonormal real basis

$$u = \tfrac1{\sqrt3}(1,1,1), \qquad
p_j = \sqrt{\tfrac23}\cos\tfrac{2\pi j}{3}, \qquad
q_j = \sqrt{\tfrac23}\sin\tfrac{2\pi j}{3},$$

in which

$$U^T C U = \begin{pmatrix}1&0&0\\0&-\tfrac12&-\tfrac{\sqrt3}2\\
0&\tfrac{\sqrt3}2&-\tfrac12\end{pmatrix},
\qquad
U^T M U = \begin{pmatrix}\alpha+\beta+\gamma&0&0\\0&s&t\\0&-t&s\end{pmatrix}$$

with $s = \alpha - \tfrac{\beta+\gamma}{2}$ and $t = \tfrac{\sqrt3}{2}(\beta-\gamma)$.
The $2\times2$ block is a **scaled rotation**, and $\lambda_{1,2}=s\mp it$ are
exactly its eigenvalues. So over $\mathbb{R}$: $1\times1 \oplus 2\times2$, with
only $1+2=3$ free parameters.
</details>

---

## T3 · Apply

**Q13.** State the dimension formula for the space of equivariant maps, and
check it against every case in both decks.

<details><summary>answer</summary>

Over $\mathbb{C}$, with $m_i, n_i$ the multiplicities of irrep $i$ in source and
target: $\dim \operatorname{Hom}_G(V,W) = \sum_i m_i n_i$. Over $\mathbb{R}$ it
needs the division-algebra refinement,

$$\dim_{\mathbb{R}}\operatorname{End}_G(V) = \sum_i m_i^2\, d_i,
\qquad d_i = \dim \operatorname{End}_G(W_i) \in \{1,2,4\}.$$

| case | multiplicities | count |
|---|---|---|
| warm-up (a) | in $(1,1)$, out $(1,0)$ | $1\cdot1 + 1\cdot0 = 1$ |
| warm-up (b) | in $(1,1)$, out $(0,1)$ | $1\cdot0 + 1\cdot1 = 1$ |
| other deck Q8 | $(1,1)$ | $1^2 + 1^2 = 2$ |
| mirror | trivial $m{=}2$, sign $m{=}1$, both $d{=}1$ | $2^2\cdot1 + 1^2\cdot1 = 5$ |
| ring | trivial $d{=}1$, 2-dim irrep $d{=}2$, both $m{=}1$ | $1^2\cdot1 + 1^2\cdot2 = 3$ |

Useful in practice: this predicts the parameter count and the block sizes
*before* you write down a single equation.
</details>

**Q14.** *Spot the bug.* Someone computes the mirror case in sympy:

```python
a,b,c,d,e,f,g,h,m = sym.symbols('a b c d e f g h m')
M = sym.Matrix([[a,b,c],[d,e,f],[g,h,m]])
v = sym.Matrix([[ s,-s,0],
                [ 0, 0,1],
                [ s, s,0]])          # s = 1/sqrt(2)
v*M*v.T                              # ...comes out dense
```

Two things are wrong. What?

<details><summary>answer</summary>

1. **Equivariance was never imposed.** $M$ has nine *independent* symbols, so it
   is an arbitrary matrix, not a mirror-symmetric one. A general $M$ is supposed
   to be dense in every basis. Fix: apply Q7 first —
   `Msym = M.subs(sym.solve([sym.Eq(x,y) for x,y in zip(M, P*M*P)], dict=True)[0])`,
   which returns a 5-parameter matrix.
2. **The transform is backwards.** Eigenvectors are the **columns** of `v`, so
   it must be `v.T * M * v`, not `v * M * v.T`. The wrong order treats the
   *rows* as the basis — row 1 here mixes sites 1 and 2, when the mirror mixes
   sites 1 and **3**.

Two smaller points: the column order `(trivial, sign, trivial)` leaves the
blocks scattered across indices $\{1,3\}$ rather than contiguous — reorder to
`(trivial, trivial, sign)`. And use exact `sym.sqrt(2)/2` rather than floats, so
the output stays readable and `==` stays reliable. `P.eigenvects()` returns
results grouped by eigenvalue, which hands you the irrep grouping for free.
</details>

**Q15.** In the mirror case, is $\widetilde M$ unique? What *is* basis-independent?

<details><summary>answer</summary>

No. The $2\times2$ trivial block depends on which orthonormal basis you pick for
the 2-plane; a different choice conjugates that block by a $2\times2$
orthogonal matrix. What survives is everything conjugation-invariant — the
block's **eigenvalues, trace and determinant** — plus the *decomposition itself*
(which subspaces the blocks live on) and the block **sizes**. The $1\times1$
sign block is forced to be the scalar $a-c$ and so is unique.
</details>

---

## T4 · Connect / transfer

**Q16.** Both the mirror and the ring end up with a $2\times2$ block. Explain
why the reasons are *opposite*.

<details><summary>answer</summary>

| | mirror (row of 3) | ring (cycle of 3) |
|---|---|---|
| why a $2\times2$ block | one **1-dim** irrep with multiplicity **2** | one **2-dim** irrep with multiplicity **1** |
| free params in block | **4** — a full $2\times2$ | **2** — forced to $\begin{pmatrix}s&t\\-t&s\end{pmatrix}$ |
| why it cannot shrink | symmetry picks no preferred axes inside the isotypic plane | the irrep has no invariant line over $\mathbb{R}$ at all |
| over $\mathbb{C}$ | unchanged | splits into two $1\times1$ blocks |

Same symptom, different disease — repeated irrep vs. genuinely higher-dimensional
irrep. The $\sum m_i^2 d_i$ formula in Q13 is what tells them apart.
</details>

**Q17.** How is the ring case the same statement as the **FFT / convolution
theorem**?

<details><summary>answer</summary>

$M$ circulant means $Mx$ is the **cyclic convolution** of $x$ with the taps, and
Q11 showed the DFT diagonalises every circulant. Put together:

> DFT turns convolution into pointwise multiplication *is precisely* the
> statement that changing to the irrep basis of $\mathbb{Z}/n$ block-diagonalises
> every $\mathbb{Z}/n$-equivariant operator.

Better still, the eigenvalues came out as $P(1), P(\omega), P(\omega^2)$ — the
**generating polynomial of the filter, evaluated at the roots of unity**. That
is the bridge to the generating-functions post: multiplying polynomials is
convolving coefficient sequences, evaluating at roots of unity diagonalises
that, and the FFT is just a fast way to apply $U$.

Fourier analysis **is** the representation theory of abelian groups. The other
deck's Q3 ("all irreps of an abelian group are 1-dimensional") is why the
Fourier basis is made of scalars $e^{i\theta}$ rather than matrices — though as
Q12 shows, you need $\mathbb{C}$ for that to be literally true.
</details>

**Q18.** Where does the mirror structure show up in a modelling problem you
actually care about?

<details><summary>answer</summary>

A **home / draw / away** outcome model with home↔away team-swap symmetry.
Swapping the teams exchanges the home-win and away-win coordinates and fixes the
draw — *exactly* the mirror $\rho(\sigma)$. So the same conclusion holds: 5 free
parameters instead of 9, the draw and the win-*sum* may mix with each other, and
the win-*difference* is completely decoupled from both.

More generally, whenever the labelling of inputs is arbitrary (mic 1 vs mic 2,
team A vs team B, sensor left vs right), a non-equivariant model gives answers
that depend on a choice made for no reason. Imposing equivariance is not a
mathematical nicety — it removes a degree of freedom that was never real, and
the parameter savings are the bookkeeping of that removal.
</details>
