
# Multivariate FBSE-EWT based SSVEP Detection in Mobile Environment for Brain-Computer Interface Application

## Overview

This project explores the use of Multivariate Fourier-Bessel Series Expansion (FBSE) and Empirical Wavelet Transform (EWT) for SSVEP detection in a mobile environment. The goal is to improve the accuracy and robustness of SSVEP detection in Brain-Computer Interface (BCI) applications, even under noisy conditions and with reduced computational complexity.

## Key Features

* **Multivariate FBSE-EWT:** Employs a novel method for time-frequency analysis of EEG signals, offering improved frequency resolution and noise reduction.
* **Mobile BCI:** Designed for real-time applications in mobile settings, where traditional methods struggle with noise and artifacts.
* **Efficient Computation:** Aims to reduce computational complexity, making it suitable for mobile and embedded platforms.

## Methodology

1. **Data Acquisition:** EEG data is collected from participants in a mobile environment, performing tasks at different speeds (standing, slow walking, fast walking, and running).
2. **Preprocessing:** EEG signals are preprocessed using band-pass filtering, re-referencing, and epoch extraction to enhance signal quality.
3. **FBSE-EWT:** The Multivariate FBSE-EWT method is applied to decompose the EEG signals into time-frequency representations.
4. **Classification:** A CNN-based classifier is used to identify the flickering frequency from the time-frequency representations.

## Results

* The FBSE-EWT method demonstrates improved frequency resolution and noise robustness compared to traditional methods.
* The time-frequency representations effectively capture SSVEP signals even under mobile conditions.
* The CNN-based classifier achieves high accuracy in identifying the target flickering frequency.

## Future Work

* Optimize the FBSE-EWT algorithm for real-time performance in mobile BCIs.
* Investigate the feasibility of implementing the system on embedded platforms.
* Explore the application of the method in other BCI paradigms and real-world scenarios.

## Project Report

[Link to the project report (PDF)](report.pdf)
