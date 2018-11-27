# 2HAWC GAMMA-RAY CATALOGUE

Este trabajo hace referencia a los siguientes repositorios:

  * [ofhawc](https://github.com/EmilioOcelotl/ofhawc) by Emilio Ocelotl.
  * [sc_hawc](https://github.com/marianneteixido/sc_hawc) by Marianne Teixido.

[Datasets](https://data.hawc-observatory.org/datasets.php): HAWC Observatory

  * Mención a Emmanuel Anguiano-Hernández [mecanosaurio](https://github.com/mecanosaurio).

---
## Introduction

At the beginning, there are some particles that travels from the interstellar medium to the atmosphere of the earth and cross our bodies each time of second. These particles comes comes mostly from cosmic or gamma-ray sources, like, supernovaes, pulsars, star collisions or galaxies' centers. When its hits with atomic nucleus in the atmosphere, elementary particles are produce which its turns to more particles generating a cascade effect. This showers of particles grows until all the energy of the original gamma-ray is totally used. All of this happening over approximately 10 km of altitude above sea level, and could cover an area of even a thousand of square meters.

The High-Altitude Water Cherenkov (HAWC) Gamma-Ray Observatory attends this reaserach on the flanks of the Sierra Negra volcano or Pico de Orizaba near Puebla, México. It implements an 1.40 x 1.80 m. area with 300 cilindrical modules of 7.3 x 4.5 m filled of 200,000 L with purified water and three floating photomultipliers tubes (PMT) each. When an elementary particle of the atmosphere cascade travels through the water, it produces light pulse call Cherenkov radiation. This happens when charged electric particles travels faster that light in a medium like water. So the light pulses are detected by the fotocato material of the PMT that convert and multiply the signal of the photon particle into many electrons which sends a electric pulse to a 1,200 channels from 120 front-end boards that process the pulses into data and store them in tabular representations whith the information about the arrive time and the size of the cascade.

With this information and the 2HWC Catalogue, we intented to figure its dimension domain to synthesize a form or qualitive state that reveals and amplify congnitive structures of the cosmic ray spectrum into an inferencial patterns, that allows us to reconstruct the direction of the original gamma-ray and estimated its energy through a simulation that visualize its behavoir.

---
## The Visualization

The visualization represent only the 39 Gamma-Ray sources from the second HAWC Observatory Catalogue mapped into a 3D computer-based spherical coordinates system. Hoping that in the future integrate, as many as possible, all the aspects of the phenomenon (in a quantum resolution perhaps) with the work developed in the Astronomic Hackatón 2018 in the beautiful México City with the support of UNAM's Astronomy Institute, Dr. Magda González, Dr. Sergio Hernández, and the founders of the convocatory Carles Tapia, Rodrigo Frenk, Leslie and everyone who were involved in project.

### The Processes

The process that describes the development starts as follows:
Photo 1, photo 2, ...
For firstness, we were attending a series of talks in one of the mains stages in the Astronomy Institute. We were introduce to the observatory and cosmic ray with Dr. Magda González to adapt our thoughts to the language of the domain.

### Tools

There were certain suggested technology tools to handle the challenge for this project. Meanwhile, some were interested in visualize the phenomena, some were interested in sonorize it too. So at the moment, I decided to use a graphic library based on Java in a programming environment call Processing, and a matrix processor environment based on Python language call Jupyter Lab.

---

## Python

  * [datasets/Hackaton2018.ipynb](datasets/Hackaton2018.ipynb): Análisis de datos en python.

Algunos docs del módulo de astropy que se utilizaron:

  * [astropy.coordinates](http://docs.astropy.org/en/stable/coordinates/index.html)
  * [astropy.time](http://docs.astropy.org/en/stable/time/index.html)
  * [astropy.io.fits](http://docs.astropy.org/en/stable/io/fits/)

---

## Processing

  * [visualization/HAWC_GammaRayCatalog/HAWC_GammaRayCatalog.pde](visualization/HAWC_GammaRayCatalog/HAWC_GammaRayCatalog.pde): Visualización de los datos en processing.

Para adaptar el tamaño de las fuentes `Crab Nebulae`, `Markarian 421` y `Markarian 501` a los mensajes OSC desde SuperCollider, configura el puerto de salida de la siguiente manera:

```
48    Orb.start("192.168.1.111", 12000); // la dirección de la otra compu. Se necesita la   librería PiranhaLab
```

Después comenta y descomenta las siguientes líneas de código en Processing:

```
211    strokeWeight(int(f_crab*1000));
212    //strokeWeight(flux_crab[int(random(flux_crab.length))]);

219    strokeWeight(int(f_mrk421*1000));
220    //strokeWeight(flux_mrk421[int(random(flux_mrk421.length))]);

227    strokeWeight(int(f_mrk501*1000));
228    //strokeWeight(flux_mrk501[int(random(flux_mrk501.length))]);
```

Finalmente, corre la aplicación.

---
