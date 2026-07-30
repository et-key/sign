# Verification Specification of Unified Correspondence Between Operators and Lambdas via Kan Extensions in Sign

## 1. Overview

In Sign design, operators (`+`, `*`, `<`, `&`, `,`) and user-defined lambdas (`?`) are fundamentally unified. Through implementation, it was inductively verified that all their behaviors correspond structurally to a single universal concept in category theory: **Kan Extensions**.

This document describes and verifies how Sign operator and lambda semantics align with Left Kan Extensions ($\text{Lan}$) and Right Kan Extensions ($\text{Ran}$).

> [!NOTE]
> **Inductive Verification Statement**
>
> The correspondence with Kan extensions is an inductive observation of Sign's implementation behavior converging with category-theoretic universal properties, rather than a deductive starting point.

---

## 2. Mathematical Foundation: All Concepts Are Kan Extensions

For functors $K: \mathcal{A} \rightarrow \mathcal{B}$ and $F: \mathcal{A} \rightarrow \mathcal{C}$, the Left Kan Extension ($\text{Lan}_K F$) and Right Kan Extension ($\text{Ran}_K F$) are defined via universal adjunctions:

### 2.1 Left Kan Extension ($\text{Lan}_K F$)

The Left Kan Extension extends functor $F$ along $K$ in the colimit direction:

$$\text{Nat}(\text{Lan}_K F, G) \;\cong\; \text{Nat}(F, G \circ K)$$

### 2.2 Right Kan Extension ($\text{Ran}_K F$)

The Right Kan Extension extends functor $F$ along $K$ in the limit direction:

$$\text{Nat}(G, \text{Ran}_K F) \;\cong\; \text{Nat}(G \circ K, F)$$

### 2.3 Adjunction Duality: Pullback and Pushforward

Every functor $K: \mathcal{A} \rightarrow \mathcal{B}$ induces a precomposition (pullback) functor $K^*$:

$$K^* : [\mathcal{B}, \mathcal{C}] \longrightarrow [\mathcal{A}, \mathcal{C}]$$

The left and right adjoints of $K^*$ define the Kan extensions:

$$\text{Lan}_K \;\dashv\; K^* \;\dashv\; \text{Ran}_K$$

- **Left Kan Extension ($\text{Lan}_K$)**: Left adjoint to $K^*$, representing minimal (coend/colimit) pushforward.
- **Right Kan Extension ($\text{Ran}_K$)**: Right adjoint to $K^*$, representing maximal (end/limit) pushforward.

---

## 3. Structural Correspondence in Sign

All core operations in Sign correspond directly to this adjunction:
- **Partial Application (Hole `_`)**: Modeled via static desugaring into Kan extension pushforward.
- **Coproduct Space Operators**: Resolved deterministically according to Kan extension precomposition.
- **Unit (`__`)**: Serves as the identity for both Monad (algebra) and Comonad (coalgebra) in the Kan extension framework.
