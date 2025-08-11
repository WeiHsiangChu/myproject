# 🪙 Coin Toss Policy Evaluation (p = 0.9)

This project evaluates three fixed betting policies in a coin-toss game using **policy evaluation** (γ = 1, episodic).  
Start with $5; the game ends at $0 (lose) or ≥ $10 (win). Head probability is **0.9**.

📓 [View Code](coin_toss_policy_evaluation.m)

---

## 🧠 Problem Overview

- **State:** current dollars \( s \in \{0,1,\dots,10\} \)
- **Actions:** bet an integer amount \( a \in \{1,\dots,\min(s,\,10-s)\} \)
- **Transition:** with prob 0.9 go to \( s+a \); with prob 0.1 go to \( s-a \)
- **Terminal states:** \( s=0 \) or \( s\ge 10 \)
- **Goal:** evaluate \( v_\pi(s) \) for three policies with \( \gamma=1 \) (episodic)

Policies:
- **Aggressive:** always bet the maximum allowed
- **Conservative:** always bet $1
- **Random:** bet uniformly at random among valid amounts

---

## 🛠 Implementation Details

- **Language:** MATLAB  
- **Method:** iterative **policy evaluation** (Bellman expectation backup)  
- **Stopping:** small tolerance on \(\|v_{\text{new}}-v\|_\infty\)  
- **Note:** Using in-place updates corresponds to **Gauss–Seidel**; using a copy corresponds to **Jacobi**. Either converges here because it’s episodic with absorbing terminals.

---

## 📊 Results

Value of \( v_\pi(s) \) at state \( s = 5 \):

| Policy         | \(v_\pi(5)\) | Notes |
|----------------|--------------|-------|
| Aggressive     | **0.9000**   | Fast win or bust |
| Conservative   | **1.0000**   | Safe, steady climb |
| Random         | **0.9510**   | Balanced behavior |

---

## 🗝 Key Techniques

- Bellman expectation equation for evaluating a fixed policy.
- Episodic setting with absorbing terminal states.
- Comparison of deterministic and stochastic policies.
