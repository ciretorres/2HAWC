# 2HAWC GAMMA-RAY CATALOGUE

Este trabajo hace referencia a los siguientes repositorios:

  * [ofhawc](https://github.com/EmilioOcelotl/ofhawc) by Emilio Ocelotl.
  * [sc_hawc](https://github.com/marianneteixido/sc_hawc) by Marianne Teixido.

[Datasets](https://data.hawc-observatory.org/datasets.php): HAWC Observatory

  * Mención a Emmanuel Anguiano-Hernández [mecanosaurio](https://github.com/mecanosaurio).

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
