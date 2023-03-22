# DReaM-ALD — Diffusion–Reaction Model for Atomic Layer Deposition

<a href="https://github.com/Aalto-Puurunen/dream-ald#copyright-and-license" alt="MIT License">
        <img src="https://img.shields.io/badge/license-MIT-green" /></a>

<a href="https://twitter.com/intent/tweet?text=https%3A%2F%2Fgithub.com%2FAalto-Puurunen%2Fdream-ald" alt="Tweet about DReaM-ALD">
        <img src="https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FAalto-Puurunen%2Fdream-ald" /></a>

## Project description

DReaM-ALD is a MATLAB implementation of a diffusion–reaction model for simulating the conformality of atomic layer deposition in high-aspect-ratio microchannels.

This project implements a diffusion–reaction model developed by Ylilammi et al. (J. Appl. Phys. **123**, 205301 (2018), DOI: [10.1063/1.5028178](https://doi.org/10.1063/1.5028178)) in MATLAB. The model was developed to simulate the conformality of atomic layer deposited films in high-aspect-ratio microchannels. The output of the model, thickness profiles, show how the film thickness evolves with penetration into the microchannel. This diffusion–reaction model uses an analytical approximation of the reactant partial pressure in combination with the Langmuir model of adsorption. The scripts were written by Emma Verkama during her summer student employment in 2019 by request of Prof. Riikka Puurunen. Jihong Yim unified the variable names used in the scripts with the symbols adopted in Yim et al. (Phys. Chem. Chem. Phys. **24**, 8645-8660 (2022), DOI: [10.1039/D1CP04758B](https://doi.org/10.1039/D1CP04758B)). The publication of the scripts was handled by Jänis Järvilehto. 

## File overview

The implementation consists of the following MATLAB scripts:

* ALDoriginal.m  
Main script. This contains the simulation parameters. The script uses the ODE23 solver to determine the evolution of the surface coverage from the Langmuir model of adsorption, defined in dthetadt.m.  
* dthetadt.m  
Implementation of the Langmuir model of adsorption for the calculation of the surface coverage (reversible single-site adsorption). The reactant partial pressure is obtained from dpAdt.m.
* dpAdt.m  
Implementation of the analytical approximation of the reactant partial pressure. 

## Usage

Run ALDoriginal.m to generate thickness profiles. The script is dependent on the functions defined in dthetadt.m and dpAdt.m. 

Currently, the simulation parameters are hardcoded in ALDoriginal.m. The parameter descriptions and units are noted as comments in the script. The reactant exposure duration is defined in `t_end`, while `t_span` can be used to adjust the integration interval. `x_steps` can be increased to obtain a higher resolution for the thickness profile. If needed, variable `x` can be adjusted for a nonlinear distribution of discretization points. 

The script contains control structures for simulating channels of varying heights in a single run. Currently, these can be enabled or disabled by commenting. 

The script generates a MATLAB figure of the resulting thickness profile. The film thickness data is stored in variable `s` as a function of distance within the channel (defined in variable `x`). 

## Publications

### v1.0.0

Jihong Yim, Emma Verkama, Jorge A. Velasco, Karsten Arts, and Riikka L. Puurunen. **Conformality of Atomic Layer Deposition in Microchannels: Impact of Process Parameters on the Simulated Thickness Profile**. *Physical Chemistry Chemical Physics* 24 (2022) 8645–60. [https://doi.org/10.1039/D1CP04758B](https://doi.org/10.1039/D1CP04758B). 

Jihong Yim, Oili M E Ylivaara, Markku Ylilammi, Virpi Korpelainen, Eero Haimi, Emma Verkama, Mikko Utriainen, and Riikka L Puurunen. **Saturation Profile Based Conformality Analysis for Atomic Layer Deposition: Aluminum Oxide in Lateral High-Aspect-Ratio Channels**. *Physical Chemistry Chemical Physics* 22 (2020) 23107–20. [https://doi.org/10.1039/d0cp03358h](https://doi.org/10.1039/d0cp03358h). 

## Citing

Please cite as:

E. Verkama and R. L. Puurunen, **DReaM-ALD – Diffusion-Reaction Model for Atomic Layer Deposition**, (2023), *Github repository*, https://github.com/Aalto-Puurunen/dream-ald. 

And the original description of the model:

M. Ylilammi, O. M. E. Ylivaara, and R. L. Puurunen. **Modeling Growth Kinetics of Thin Films Made by Atomic Layer Deposition in Lateral High-Aspect-Ratio Structures**, (2018), *Journal of Applied Physics*, 123: preprint 205301. [https://doi.org/10.1063/1.5028178](https://doi.org/10.1063/1.5028178).

## Copyright and license

MIT License

Copyright 2023 (c) Emma Verkama and Riikka Puurunen, Aalto University

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
