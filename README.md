# 🐭 Rodentia Tract-Level Volume Comparison to Rat1

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

### 🔄 Preprocessing & Standardization
- **Mean Tract Creation**:  
  For each unique start–end node label combination, a mean tract was calculated across all relevant fibers.
  
- **Cross-Species Registration**:  
  Each rodent’s tractography ("**Input**") was projected into a common anatomical space defined by a **Target species** (typically **Rat1**) using anatomical alignment and label matching.

---

## 📂 Project Structure

- `main.m` — Script for loading data, performing analysis, and generating all plots.
- `mammal_data.m` — Function for loading and structuring mammal data.
- `Volume_parameter_maker.m` — Function for generating volume parameters between input and target rodents.
- `raxml_concatenated_treepl_calibrated.tree` — Phylogenetic tree used for evolutionary distance comparison.

---

## 🧠 Rodent Species Analyzed

A total of 28 rodent specimens are included:


---

## 🧪 Analysis Overview

The analysis performs the following steps:

1. **Data Loading**  
   Loads precomputed volume parameter tables for all rodents and selects Rat1 as the comparison baseline.

2. **Boxplot Visualization**  
   Creates a boxplot of the volume parameter distributions across species, relative to Rat1.

3. **Histogram Analysis**  
   Compares volume parameter distributions:
   - All rodents vs. Rat1
   - Rat4 (most similar to Rat1) vs. Rat1
   - Porcupine1 (least similar to Rat1) vs. Rat1

4. **Mean & STD Calculation**  
   Computes mean and standard deviation of tract volume parameters per species.

5. **Missing Data (NaN) Handling**  
   Identifies missing values and adjusts visualizations accordingly.

6. **Phylogenetic Distance Integration**  
   Parses a phylogenetic tree to extract evolutionary distances and compare them with volume-based similarity to Rat1.

---

## 📊 Key Visual Outputs

- **Boxplot**: Tract volume distributions across all species.
- **Histograms**:
  - Rat1 vs. all other species
  - Detailed comparisons: Rat1–Rat4 vs. Rat1–Porcupine1
- **Overlaid Histograms**: To explore differences in compatibility.

---