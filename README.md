# Multi Feature-Rich Synthetic Colour (MFRSC) for point clouds

Created by Jesús Balado Frías, Elena González, Juan L. Rodríguez-Somoza and Pedro Arias

Tutorials in Spanish and English, and code in python is available [here](https://github.com/jbalado/Tutorials).

## Introduction

Although point features have shown their usefulness in classification with Machine Learning, point cloud visualization enhancement methods focus mainly on lighting. The visualization of point features helps to improve the perception of the 3D environment. This work proposes Multi Feature-Rich Synthetic Colour (MFRSC) as an alternative non-photorealistic colour approach of natural-coloured point clouds. The method is based on the selection of nine features (reflectance, return number, inclination, depth, height, point density, linearity, planarity, and scattering) associated with five human perception descriptors (edges, texture, shape, size, depth, orientation). The features are reduced to fit the RGB display channels. 

![](https://i.imgur.com/T3o1mXo.jpeg)

## Work

The designed method is described in the article ****Multi Feature-Rich Synthetic Colour to improve human visual perception of point clouds****.

Before applying the code, reading the paper is highly recommended.

It is available in Open Access at this [link](https://doi.org/10.1016/j.isprsjprs.2023.01.019).


## Application
After the selection of the corresponding atributes of geometry (XYZ) and reutrn number, the code generate a synthetic coloured point cloud, loadable in any software for visualization.

## Citation
Balado, J., González, E., Rodríguez-Somoza, J.L. & Arias, P. (2023) Multi feature-rich synthetic colour to improve human visual perception of
point clouds. ISPRS Journal of Photogrammetry and Remote Sensing, 196, 514-527.
