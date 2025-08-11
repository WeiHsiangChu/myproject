# 🪙 Coin Toss — Optimal Policy via Policy Iteration & Value Iteration

This project computes **optimal policies** for the coin-toss betting game under two settings:
- **Policy Iteration** with head probability **p = 0.9**
- **Value Iteration** with head probability **p = 0.1**

📓 Code:  
- [Policy Iteration (p = 0.9)](coin_toss_policy_iteration.m)  
- [Value Iteration (p = 0.1)](coin_toss_value_iteration.m)

---

## 🧠 Problem Overview

- **State:** current dollars \( s \in \{0,1,\dots,18\} \) (terminal at \(0\) and \( \ge 10 \))
- **Actions:** bet an integer amount \( a \in \{1,\dots,\min(s,\,10-s)\} \)
- **Transitions:** with prob \(p\) go to \( s+a \); with prob \(1-p\) go to \( s-a \)
- **Objective:** maximize expected terminal wealth; \( \gamma = 1 \) (episodic)

---

## 🛠 Methods

- **Policy Iteration (p = 0.9):** alternating **policy evaluation** and **policy improvement** until stable.
- **Value Iteration (p = 0.1):** Bellman optimality backups until \( \|v_{\text{new}}-v\|_\infty \) is below tolerance.

---

## 📊 Results

### Optimal Policy — Policy Iteration (p = 0.9)
Key entries (full list in code/report):  
\[
\pi(1)=1,\ \pi(2)=1,\ \dots,\ \pi(8)=1,\ \pi(9)=8
\]
and terminals thereafter.  [oai_citation:0‡Chu_homework3.pdf](file-service://file-G3rd9A82PCrWAGYC81zDfo)

**Optimal values (excerpt):**  
\( V(1)=14.9266,\ V(5)=16.7923,\ V(9)=16.7927,\ V(10)=10 \).  [oai_citation:1‡Chu_homework3.pdf](file-service://file-G3rd9A82PCrWAGYC81zDfo)

---

### Optimal Policy — Value Iteration (p = 0.1)
Key entries (full list in code/report):  
\[
\pi(1)=1,\ \pi(2)=2,\ \pi(3)=3,\ \pi(4)=1,\ \pi(5)=5,\ \pi(6)=6,\ \pi(7)=7,\ \pi(8)=2,\ \pi(9)=1
\]
and terminals thereafter.  [oai_citation:2‡Chu_homework3.pdf](file-service://file-G3rd9A82PCrWAGYC81zDfo)

**Optimal values (excerpt):**  
\( V(1)=0.0021,\ V(3)=0.1200,\ V(5)=1.0000,\ V(9)=2.8720,\ V(10)=10 \).  [oai_citation:3‡Chu_homework3.pdf](file-service://file-G3rd9A82PCrWAGYC81zDfo)

---

## 🗝 Key Techniques
- Policy evaluation with convergence threshold on value change.
- Greedy policy improvement (policy iteration) vs. optimality backups (value iteration).
- Handling absorbing terminals at \(0\) and \(\ge 10\).
