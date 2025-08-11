# 🪙 Coin Toss — Optimal Policy via Policy Iteration & Value Iteration

This project computes **optimal policies** for the coin-toss betting game under two settings:
- **Policy Iteration** with head probability `p = 0.9`
- **Value Iteration** with head probability `p = 0.1`

📓 Code:  
- [Policy Iteration (p = 0.9)](coin_toss_policy_iteration.m)  
- [Value Iteration (p = 0.1)](coin_toss_value_iteration.m)

---

## 🧠 Problem Overview

- **State (non-terminal):** current dollars `s in {1,...,9}`
- **Terminal states:** `s = 0` (lose) and any `s >= 10` (win)
- **Actions:** bet an integer amount `a in {1,...,s}`  ← matches your implementation (e.g., from `s=9` you can bet `8`)
- **Transitions (probability of heads = p):**
  - With prob `p`: next state is `(s + a)`
  - With prob `1 - p`: next state is `(s - a)`
- **Episode end:** as soon as the next state is terminal (i.e., `0` or `>= 10`)
- **Objective:** maximize expected terminal wealth; `gamma = 1` (episodic)

---

## 🛠 Methods

- **Policy Iteration (p = 0.9):** alternating **policy evaluation** and **policy improvement** until stable.
- **Value Iteration (p = 0.1):** Bellman optimality backups until the largest change across all state values is below a small threshold (`max(|v_new - v|) < tolerance`).

---

## 📊 Results

### Optimal Policy — Policy Iteration (p = 0.9)

Optimal policy `pi(s)` for s = 1 to 9:  
`[1, 1, 1, 1, 1, 1, 1, 1, 8]`  
(Terminal at s = 0 and s ≥ 10)

Optimal values `V(s)` for s = 1 to 10:  
`[14.9266, 15.8666, 15.9266, 16.3666, 16.7923, 16.7266, 16.7666, 16.7923, 16.7927, 10]`

---

### Optimal Policy — Value Iteration (p = 0.1)

Optimal policy `pi(s)` for s = 1 to 9:  
`[1, 2, 3, 1, 5, 6, 7, 2, 1]`  
(Terminal at s = 0 and s ≥ 10)

Optimal values `V(s)` for s = 1 to 10:  
`[0.0021, 0.0572, 0.1200, 0.2643, 1.0000, 1.5270, 2.1510, 2.5260, 2.8720, 10]`

---

## 🗝 Key Techniques
- Policy evaluation with convergence threshold on value change.
- Greedy policy improvement (policy iteration) vs. optimality backups (value iteration).
- Handling absorbing terminals at `0` and `>= 10`.
