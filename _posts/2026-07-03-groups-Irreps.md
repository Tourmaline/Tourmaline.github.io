---
layout: post
title: "Groups and Irreducible Representations"
date: 2026-07-03
tags: ["math", "group theory", "representation theory"]
math: true
---


A group is a set of elements combined with an operation that satisfies four fundamental properties: closure, associativity, identity, and invertibility. 
In mathematical terms, a group is defined as a pair $(G, *)$ where $G$ is a set and $*$ is a binary operation on $G$ that satisfies the following properties:
1. Closure: combining any two elements of the group results in another element of the group. For all $a, b \in G$, $a * b$ is also in $G$.
2. Associativity: $(g * h) * k = g * (h * k)$ for all $g, h, k \in G$.
3. Identity: there exists an element $e \in G$ such that for every element $g \in G$, $e * g = g * e = g$.
4. Invertibility: for each element $g \in G$, there exists an element $g^{-1} \in G$ such that $g * g^{-1} = g^{-1} * g = e$.

Examples of groups:
- The set of integers under addition, denoted by $(\mathbb{Z}, +)$, is a group. The identity element is $0$, and the inverse of an integer $n$ is $-n$.
- The set of non-zero real numbers under multiplication, denoted by $(\mathbb{R}^*, \times)$, is a group. The identity element is $1$, and the inverse of a non-zero real number $x$ is $1/x$.
- The set of permutations of a finite set, denoted by $S_n$, is a group. The identity element is the permutation that leaves all elements unchanged, and the inverse of a permutation is the permutation that reverses the effect of the original permutation.
- The set of rotations and reflections of a regular polygon, denoted by $D_n$, is a group. The identity element is the rotation that leaves the polygon unchanged, and the inverse of a rotation or reflection is the operation that undoes it.
- The set of invertible matrices under matrix multiplication, denoted by $GL(n, \mathbb{R})$, is a group. The identity element is the identity matrix, and the inverse of an invertible matrix $A$ is the matrix $A^{-1}$ such that $A A^{-1} = A^{-1} A = I$.
- The set of symmetries of a geometric object, denoted by $\mathrm{Sym}(X)$, is a group. The identity element is the symmetry that leaves the object unchanged, and the inverse of a symmetry is the symmetry that undoes it.
- The set of modular integers under addition modulo $n$, denoted by $(\mathbb{Z}/n\mathbb{Z}, +)$, is a group. The identity element is $0$, and the inverse of an integer $a$ modulo $n$ is the integer $b$ such that $a + b \equiv 0 \pmod{n}$.



## Swap two labels group


Let's consider a "swap two labels" group, also known as the symmetric group on two elements, denoted by $S_2$. This group consists of two elements $\{e, \tau\}$: the identity $e$ and the transposition $\tau$ that swaps the two labels. The operation is a function composition.


Group is an abstract algebraic structure (a "pattern"), but it can have a concrete representation in a given vector space. So representation is a concrete rule for how abstract elements of $G$ act as matrices on a given vector space $V$, i.e. it is a function:

$$
\rho: G \to GL(V),
$$

where $GL(V)$ is the group of invertible matrices on $V$, or in 1D case, just the non-zero real numbers. 

Let $V$ = $\mathbb{R}^2$ (the pair $(a, b)$). We define a rule $\rho$ for swapping two elements in $V$ as follows:

$$
\rho(\tau)(a,b) = (b,a).
$$

In matrix form, the representation $\rho(\tau)$ can be written as:

$$
\rho(\tau) = \begin{pmatrix}
0 & 1 \\
1 & 0
\end{pmatrix}.
$$

## Irreducible representations

An irreducible representation is a representation that cannot be decomposed into smaller representations.   

In general, for abelian groups (i.e. groups where all elements commute), all irreducible representations are 1D.
For the group $S_2$, there are two 1D irreducible representations.
The 1D irreducible representation is just a number $\lambda=\rho(\tau)$. Then $\lambda^2 = \rho(\tau)^2 = \rho(e) = 1$, so $\lambda = \pm 1$.

This means that there are two ways to assign numbers to the elements of $S_2$ that respect the group operation. The first representation is the trivial representation, where both elements are mapped to 1:

$$
\rho_1(e) = 1, \quad \rho_1(\tau) = 1.
$$

The second representation is the sign representation, where the identity is mapped to 1 and the transposition is mapped to -1:

$$
\rho_2(e) = 1, \quad \rho_2(\tau) = -1.
$$

How can we connect these representations to the representation $\rho$ defined above?

The representation $\rho$ defined above is 2D and can be decomposed into the direct sum of the two 1D irreducible representations:

$$
\rho \cong \rho_1 \oplus \rho_2.
$$

In other words, there exists a change of basis that simultaneously diagonalizes $\rho(e)$ and $\rho(\tau)$, resulting in a block diagonal form where each block corresponds to one of the 1D irreducible representations. The new basis is given by the eigenvectors $U$ of the matrix $\rho(\tau)$:

$$
\rho(x) = U
\begin{pmatrix}
\rho_1(x) & 0 \\
0 & \rho_2(x)
\end{pmatrix}
U^{-1}, \qquad x \in S_2.
$$

For example, taking $x = \tau$:

$$
\rho(\tau) = \begin{pmatrix}
0 & 1 \\
1 & 0
\end{pmatrix} =
U
\begin{pmatrix}
1 & 0 \\
0 & -1
\end{pmatrix}
U^{-1},
$$

where 

$$
U = \frac{1}{\sqrt{2}}\begin{pmatrix}
1 & 1 \\
1 & -1
\end{pmatrix}.
$$

This $U$ is orthonormal, so $U^{-1} = U^T$.

So if I have a vector $v = (a, b)^T$ in the original basis, I can express it in the new basis as 

$$
v' = U^Tv = \frac{1}{\sqrt{2}}\begin{pmatrix}
a + b \\
a - b
\end{pmatrix}.
$$


## Modelling (simple)

I want to write a model $M$ which is mapping $(u,v)\in\mathbb{R}^{2}$ to $(a,b)\in\mathbb{R}^2$:

$$
\begin{pmatrix}
a \\
b
\end{pmatrix} = M\begin{pmatrix}
u \\
v
\end{pmatrix}.
$$

and which satisfies the symmetry of the group $S_2$:

$$
M\begin{pmatrix}
v \\
u
\end{pmatrix} = \begin{pmatrix}
b \\
a
\end{pmatrix}.
$$

As we have seen, for us it is best to work in the basis of irreducible representations. In this basis, we get:

$$
\widetilde{M}\begin{pmatrix}
u + v \\
u - v
\end{pmatrix} = \begin{pmatrix}
a + b \\
a - b
\end{pmatrix},
$$

where 

$$
\widetilde{M} = U^T M U,
$$

and $U$ is the change of basis matrix defined above.
It can be easily seen (by writing down the equation above and the version with swapped vectors) that $\widetilde{M}$ must be diagonal:

$$
\widetilde{M} = \begin{pmatrix}
\widetilde{m}_{11} & 0 \\
0 & \widetilde{m}_{22}
\end{pmatrix}.
$$

