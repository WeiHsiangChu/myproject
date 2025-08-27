# 🌸 Few-Shot Representation Learning on Oxford 102 Flowers

Self-supervised pretraining on the **102-Category Flower** dataset, followed by few-shot evaluation with a **linear probe** and an **MLP classifier**. Two representation learning paradigms are compared: **SimCLR** (contrastive) and **MAE** (masked autoencoding).

📓 [View Code](few-shot.ipynb)

---

## 🧠 Problem Overview

- **Dataset:** Oxford 102 Flowers — 102 categories, each with only **10 labeled training images** (few-shot setting).  
- **Challenge:** very limited labeled data, risk of overfitting, and modest compute budget.  
- **Goal:** learn label-free visual representations in a **self-supervised fashion** and test them with lightweight classifiers.

---

## 🔧 Methods

### SimCLR (contrastive learning)
- **Augmentations:** random crop→resize (224x224), ColorJitter p=0.8 (b,c,s,h=0.4), grayscale p=0.2, horizontal flip p=0.5. **No rotation** (orientation matters for flowers).
- **Encoder:** ResNet-18 backbone (ImageNet-pretrained), global avg pooling → 512-D embedding.
- **Projection head:** 512→512 (BN+ReLU) → 128-D, followed by L2 norm.
- **Loss:** NT-Xent, τ = 0.5, negatives = other samples in the batch.
- **Training:** batch 128, lr 3e-4, 200 epochs.

### MAE (masked autoencoder)
- **Tokenization:** 224x224 image split into 16×16 patches → 196 tokens (linear embedding + sinusoidal position encoding).
- **Masking:** randomly hide **75%** of patches.
- **Encoder/Decoder:** 8-layer transformer encoder, append mask tokens, then 4-layer transformer decoder.
- **Objective:** normalized MSE reconstruction **on masked patches only**.
- **Training:** batch 64, lr 5e-5, 200 epochs.

---

## ⚙️ Implementation Details

- **Framework:** PyTorch (training, augmentation, and evaluation).  
- **Evaluation Protocol:**  
  - Freeze the encoder after pretraining.  
  - Cache 512-D embeddings for all images.  
  - Train **linear probe** (logistic regression head) and **MLP probe** (512→256→102).  
- **Optimization:** SGD with lr 0.01, 200 epochs, early stopping.  
- **Metrics:** Top-1 accuracy on validation and test sets.  

---

## 📊 Results

### Representation quality during pretraining
- **SimCLR loss** decreased from **4.94 → 3.87** (clear convergence).  
- **MAE loss** decreased but stayed large in absolute scale (≈7973 → 4700 → 5179) due to summing masked-patch MSE across images.

### Few-shot classification (Top-1 %)

| Pretraining | Head        | Val | Test |
|-------------|-------------|----:|----:|
| **SimCLR**  | Linear      | **78.43** | **77.54** |
| SimCLR      | MLP         | 76.86 | 75.49 |
| **MAE**     | Linear      | 18.14 | 15.21 |
| MAE         | MLP         | 15.88 | 15.68 |

**Interpretation**
- **SimCLR features** are highly discriminative and linearly separable → linear probe outperforms MLP in this few-shot regime.  
- **MAE features** are tuned for reconstruction, not classification → poor downstream accuracy.  
- Linear probes can outperform small MLPs when embeddings are already well-structured.  
