# ⌚ WeBe Band: On-Device Gesture Recognition using Wrist Accelerometer

This project develops an end-to-end machine learning pipeline for real-time gesture recognition using triaxial accelerometer data collected from the WeBe Band wearable device. The objective is to accurately classify user-performed "X" and "O" gestures while distinguishing them from random motions under embedded system constraints.

📄 [View Full Paper (PDF)](WeBe_Band_Gesture_XO.pdf)  
📓 [View Code](gesture-recognition.ipynb)

---

## 🎯 Problem Overview

Wearable devices used in healthcare and human-computer interaction often require low-latency motion recognition while operating under strict memory and computational constraints.

This project investigates whether reliable gesture recognition can be achieved using only wrist-mounted triaxial accelerometer signals without relying on cameras or full IMU systems. The resulting models are designed for deployment on resource-constrained embedded devices.

---

## 🧪 Data Collection & Processing

Five participants performed multiple sessions of three motion classes:

- ⭕ O Gesture
- ❌ X Gesture
- 🎲 Random Motions

Data were collected using the WeBe Band wearable device at a sampling rate of 25 Hz.

To improve robustness and class balance, several time-series augmentation techniques were applied:

- Temporal Shifting
- Amplitude Scaling
- Time Stretching

Gesture segments were manually verified and labeled before model development.

---

## 🧠 Feature Engineering & Model Development

An AutoML workflow based on the Piccolo AI framework was used to identify the most informative features for embedded deployment.

Selected features included:

- Statistical descriptors (mean, variance, kurtosis)
- Signal amplitude measurements
- Zero-crossing features
- Cross-axis relationships
- Peak-to-peak and min-max distance metrics

The extracted features were used to train and evaluate multiple lightweight machine learning models:

- Neural Network (NN)
- Random Forest (RF)
- Pattern Matching Engine (PME)
- Bonsai

Feature separability was further analyzed using t-SNE visualization.

---

## 📈 Results

The final Neural Network achieved the best overall performance:

| Metric | Neural Network |
|----------|----------|
| Accuracy | 98.1% |
| Macro F1 Score | 98.6% |
| Inference Latency | 1.2 ms |

The model successfully distinguished target gestures from random motions while maintaining low latency suitable for real-time embedded applications.

![Model Performance](images/model-performance.png)

---

## 🚀 On-Device Deployment

All models were profiled on the WeBe Band platform featuring an ARM Cortex-M4F microcontroller.

Key deployment characteristics:

- Real-time inference
- Low memory footprint
- Sub-2 ms latency
- Fully on-device execution
- No cloud connectivity required

This approach improves privacy, security, and responsiveness for wearable healthcare applications.

---

## 🧠 Key Techniques

- Triaxial Accelerometer Signal Processing
- Time-Series Data Augmentation
- AutoML-Based Feature Selection
- Embedded Machine Learning
- Neural Network Optimization
- On-Device Inference Profiling
- Wearable AI Applications
