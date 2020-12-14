Documentation
=============
**General Description:**

This project is a mathematical modeling task, which focuses on optimizing the allocation and deployment of shared bikes, programmed with MATLAB

Project mainly includes three parts:
1. allocation part
2. transportation part

Dependencies
-------------
**Language:** MATLAB

```buildoutcfg
│  Document.pdf // technical documentation of this project
│  README.md    // help
│
├─Allocation    // allocation part
│      best_k.m // find best number of clusters for K-Means
│      kmeans-10.fig
│      kmeans-100.fig
│      kmeans-50.fig
│      kmeans-505-best.fig
│      return_point.m   // K-Means clustering
│
└─Deployment
        cost.m  // cost function for deployment
        genetic.m   // genetic algorithm
        main_cost.m // main function
        main_distance.m // distance calculation
        The Optimal Cycle Under the Advanced Cost Function.fig
        The Optimal Cycle Under the Cost Function of Distance.fig
```