# Multiarmed Bandit — Epsilon-Greedy & UCB (MATLAB)

**Language:** MATLAB  
**Goal:** Reproduce Fig. 2.4 (average reward vs. steps) comparing **epsilon-greedy** and **UCB** on k-armed bandits.

---

## 📌 Overview
Implements:
- **Epsilon-Greedy:** with probability ε choose a random arm; otherwise choose the action with the highest current value estimate. Incremental update for action values.
- **UCB (Upper Confidence Bound):**  
  \( a_t = \arg\max_a \left[ Q_t(a) + c \sqrt{\frac{\ln t}{N_t(a)}} \right] \)  
  balancing exploitation (large \(Q_t\)) and exploration (small \(N_t\)).

**Experiment setup**
- Steps per run: **1000**
- Runs: **2000**
- Arms: **k** (set in code)
- Hyperparameters: **ε** for epsilon-greedy, **c** for UCB

---

## 📂 Files
- `multiarmed_bandit.m` — MATLAB implementation and plotting.
