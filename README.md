# 🐭 Rodentia Tract-Level Volume Comparison

This repository contains MATLAB scripts and data for analyzing and visualizing generalized node-to-tract comparisons across 28 rodent species. The core analysis evaluates how tract-level volume parameters in various rodents relate to those of **Rat1**, our reference species.

---

## 🎯 Project Motivation & Hypothesis

### ❗ Limitation
Current analyses of mammalian brain connectivity often focus on **node-level similarities** (e.g., pairwise connections or local tract features), which may not capture the **global anatomical trajectory** or **functional implications** of fiber tracts across species.

### 🧭 Goal
To **generalize from node-level information to tract-level comparisons** across different rodent species. This involves identifying whether similarities in local node-edge configurations translate to similarities in full tract paths between homologous brains.

### 💡 Hypothesis
> *Mammalian tracts across species that share similar node-edge configurations will follow similar global paths.*

### 🧬 Implications if True:
- Supports the idea that certain long-range tracts have **evolutionarily conserved** or **functionally significant** trajectories.
- Suggests that **non-localized (distributed)** features of white matter tracts can be **predicted** or **inferred** from local connectivity.
- Opens the door for **cross-species generalization** in connectomics and comparative neuroanatomy.

---

## 🧪 Data & Method Summary

### 🧠 Dataset
- **Modality**: *Diffusion Tensor Imaging (DTI)*  
- **Species**: 28 rodent brains  
- **Tractography**: White matter fiber tracts derived from DTI  
- **Resolution**: 200 interpolated node locations per tract  
- **Labeling**: Tract edges are labeled by their **start and end node identity**  

## 📂 Project Structure

- `main.m` — Script for loading data, performing analysis, and generating all plots.
- `mammal_data.m` — Function for loading and structuring mammal data.
- `Volume_parameter_maker.m` — Function for generating volume parameters between input and target rodents.
- `raxml_concatenated_treepl_calibrated.tree` — Phylogenetic tree used for evolutionary distance comparison.

---
