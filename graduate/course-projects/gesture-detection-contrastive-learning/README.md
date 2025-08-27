# ✋ Gesture Detection with SimCLR (Contrastive Learning)

This project applies **SimCLR** (contrastive self-supervised learning) to a online gesture dataset
**Scope:** only two gesture classes are used in this project — **“circle”** and **“eight”** — loaded from a preprocessed pickle file.

📓 [View Code](gesture-detection-contrastive.ipynb)

---

## 🧠 Problem Overview

- **Task:** distinguish **circle** vs **eight** gestures from **preprocessed sequence features** loaded from a pickle file.  
- **Data used here:** the pickle provides arrays for each gesture and augmentation variant (see below).  
- **Challenge:** small dataset; sensitivity to augmentation choices.  
- **Goal:** learn robust representations without labels (SimCLR), then evaluate with a lightweight classifier.

---

## 🔧 Methods

### Data & augmentations (as used in this project)
From the pickle we load three variants for each class and concatenate class-wise:
- **`X_feat`** — feature-level transforms (e.g., noise, dropout, scaling, masking).  
- **`X_crop`** — temporal cropping of sequences.  
- **`X_resampling`** — temporal resampling / distortion.  

> Note: inputs are **preprocessed feature sequences** (whatever the pickle provides); the pipeline does **not** assume or require raw `(x, y, z)` coordinates.

### SimCLR pretraining
- **Positive pairs:** two augmented views of the **same sequence** (same sample, different augmentation draws).  
- **Negatives:** other sequences in the minibatch (from either class).  
- **Encoder:** small MLP → 128-D embedding.  
- **Projection head:** 2-layer MLP with output normalized to unit length.  
- **Loss:** NT-Xent (InfoNCE) with temperature scaling.

---

## ⚙️ Implementation Details

- **Framework:** PyTorch.  
- **Batching:** minibatches of sequence features with paired augmentations.  
- **Evaluation protocol:** freeze the pretrained encoder → train a linear/MLP probe on top of frozen embeddings to classify **circle vs eight**.  
- **Metric:** classification accuracy; results compared across `X_feat`, `X_crop`, `X_resampling`.

---

## 📊 Results

- **`X_feat`** → stable, **moderate** performance.  
- **`X_crop`** → **worst** performance (cropping often removes essential parts of the gesture).  
- **`X_resampling`** → **best** performance; embeddings are most robust to temporal variation.

**Conclusion:** resampling-based augmentation (**`X_resampling`**) produces the most discriminative embeddings for separating **circle** from **eight** in this setup.
