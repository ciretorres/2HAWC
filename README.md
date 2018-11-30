# The 2HWC HAWC OBSERVATORY GAMMA-RAY CATALOGUE

![alt text](https://redlbc.files.wordpress.com/2016/02/hawc-nieve.jpg "hawc 1")
![alt text](https://events.icecube.wisc.edu/conferenceDisplay.py/getPic?picId=4&confId=81 "hawc 2")

This project makes reference to the next github repositories:

  * [ofhawc](https://github.com/EmilioOcelotl/ofhawc) by Emilio Ocelotl.
  * [sc_hawc](https://github.com/marianneteixido/sc_hawc) by Marianne Teixido.

HAWC Observatory: [datasets](https://data.hawc-observatory.org/datasets.php)

  * Mention to Emmanuel Anguiano-Hernández [mecanosaurio](https://github.com/mecanosaurio).

---
## Introduction

Each time of second, a certain gamma-ray particles that travels from the interstellar medium to the atmosphere of the earth, has been cascading our bodies. Perhaps, while we are reading this.

At the beginning, these particles comes mostly from cosmic-ray sources, like, supernovaes, pulsars, star collisions or galaxies' centers. When its hits in the atmosphere and interact with the atomic nuclei, elementary particles are produced, which turns it into more particles and generate a cascade effect. This showers of particles grows until all the energy of the original gamma-ray is totally used. You might imagine all this happening approximately at 10 km above sea level, and that could cover an area of even a 1,000 of square meters.

So, The High-Altitude Water Cherenkov (HAWC) Gamma-Ray Observatory attends this wonderful research on the flanks of the Sierra Negra volcano on Pico de Orizaba's (Citlaltépetl) National Park near from the beautiful city of Puebla in México. It implements an 140x180m territorial area with 300 cylindrical modules of 7.3x4.5m filled with 200,000L of purified water and three floating photomultiplier tubes (PMT) each. 

Now, When an elementary particle of the atmosphere cascade travels through the water, it produces a light pulse call Cherenkov radiation. This happens when charged electric particle travels faster than light in a medium like water. It is similar when at the poles of the amazed planets experiences the aurora borealis, because of the protection roll of the atmosphere from the higher levels of gamma-ray or radiation.

Thereby, the light pulses are detected by the photocathode material of the PMT which converts and multiply the signal from the photon particle into many electrons that sends an electricmagnetic pulse to 1,200 channels from 120 front-end boards to process those into interpretable datasets and store onto tabular representations with the information about arrive time and cascade's size.

Finally, through this information and the data from the 2HWC HAWC Observatory Gamma-Ray Catalogue, we intented to figure out its dimension from its domain to synthesize a qualitive form, that could reveals and amplify cognitive structures of cosmic ray's spectrum into an inferencial patterns system, which allows to reconstruct the direction from the original gamma-ray source and estimates its energy, through a based-computer simulation that visualize and sonorize its nature.

---
## Reconstruction of the phenomena: a live code visualization & sonirization

For the reconstructions, we wanna answer some of these questions:
  * From where the Gamma-Ray came from?
  * How a Gamma-Ray emmited from Crab Nebulae travels to Earth.
  * What is a Gamma-Ray cascade?
  * How does the modules detect these particles?
  * How does this information is create in the machine-system?
  * What is the sound representation of all this?

Also we are interested in explore the quantities of time from the cascade particles events of Gamma-Ray that allow us to infer the reconstruction of the trajectory angle.

The pictorical representation of the 39 Gamma-Ray sources from the second HAWC Observatory Catalogue mapped into a 3D computer-based spherical coordinates system, might hope been integrate in the future, as many as possible, with mostly all of the aspects from the phenoma, like in a quantum resolution perhaps, with the work developed in the Astronomic Hackatón 2018 with UNAM's Astronomy Institute, Dr. Magda González, Sergio Hernández, and the founders of the summon Carles Tardío, Rodrigo Treviño, Leslie García and everyone who were involved in the support of the project.

### The Processes

The process that describes the implementation of the prototypings starts as follows:

For firstness, we were summoned by Art, Science, and Technology's (ACT) program in the wild México City to attend a series of talks and workshops in the Astronomy Institute headquarters in UNAM during the 6th, 7th and 8th of november from 10-14h and from 16-18h. 
<img src="./captures/IMG_4387.jpg">

We were introduced to the observatory and physics foundations with talk from Dr. Magda González about Cosmic ray as a messengers from the universe to adapt our thoughts to the language of the domain. 
<img src="./captures/IMG_4388.jpg">

Most of chemical elements that represent Mendeleev's periodic table comes from out of the earth, in fact; certain elements have been produce from the human being. So we ask ourselfs, from where the hell comes all the matter?!
<img src="./captures/IMG_4390.jpg">

It looks likes that the fundamental particles, in a modern vision, like quarks, electrons, neutrinos, muons or taus where ionized during the cooling and the acecelerate expanse of the universe since the Big bang. Once this particles became with a more complex structure, because of the gravity, the temperature and many other stuff, the firsts stars and galaxies started to bright.
<img src="./captures/IMG_4391.jpg">

After that, in a laboratory they explained us how does it work, in general, the electronic system in the HAWC's Observatory. The interested part, from my point of view, is when the Cherenvok effect lights the material photocathode in the tubes to photomultiply it into many electrons and send the signal to the engineering mechanisim, when front-end board recieve this pulse and translate it to a bit code and then process it, with another machines-levels, to get the data in natural language.
<img src="./captures/IMG_4402.jpg">

Then, we were on an underground laboratory where they shows us the quality main process of the purify water from the modules with a lasser passing through a tube filled with dirty water.
<img src="./captures/IMG_4408.jpg">

At the end of the first day, we had a nice exploration of the first Data Sets with Sergio Hernández, whom allow us to read each parameter from its. Like the 39 Gamma-Ray sources which allow them to plot the sky or the maps from the observation significance of each source or the lightcurves from Crab Nebulae, Markarian 421, and Markarian 501 from about 17 months of measuring.
<img src="./captures/IMG_4414.jpg">

The format of the data files is very important for the implementation of the project. In this case, the second catalogue were in .XML, but Sergio provided us a program to convert it to .CSV with python. The lightcurves were in .DAT so with a little help with my friend Emmanuel, we could solve the problem to reconstruct the data in readable format for the environments we are gonna use. But there was a interested fact in the variables of this set, that Sergio helped us with the dates in which the flow started to record and it finished by converting the Modified Julian's Calendar to  Gregorian's Calendar with some tricks with the Astropy.time module. Now, were ready to ping some ideas with the community!
<img src="./captures/IMG_4420.jpg">

Finally, the mentors assigned to the mission presented their portfolios with conceptual tools from programming languages like SuperCollider, Pure Data, VVVV, OpenFrameworks and Processing, which it is intended to specify theses aspects forward.

For secondness, 

### Tools

There were certain suggested technology tools to handle the challenge for this project. Meanwhile, some were interested in visualize the phenomena, some were interested in sonorize it too. So at the moment, I decided to use a graphic library based on Java in a programming environment call Processing, and a matrix processor environment based on Python language call Jupyter Lab.

---

## Python

  * [datasets/Hackaton2018.ipynb](datasets/Hackaton2018.ipynb): Data analysis with python.

Some docs from Astropy module that were used:

  * [astropy.coordinates](http://docs.astropy.org/en/stable/coordinates/index.html)
  * [astropy.time](http://docs.astropy.org/en/stable/time/index.html)
  * [astropy.io.fits](http://docs.astropy.org/en/stable/io/fits/)

---

## Processing

  * [visualization/HAWC_GammaRayCatalog/HAWC_GammaRayCatalog.pde](visualization/HAWC_GammaRayCatalog/HAWC_GammaRayCatalog.pde): Data visualization with Processing.

To adapat the strokeWeight of the sources `Crab Nebulae`, `Markarian 421` y `Markarian 501` to the OSC messages from SuperCollider, setup the port as follows:

```
48    Orb.start("192.168.1.111", 12000); // la dirección de la otra compu. Se necesita la   librería PiranhaLab
```

Then comment and uncomment the next lines in the Processing code:

```
211    strokeWeight(int(f_crab*1000));
212    //strokeWeight(flux_crab[int(random(flux_crab.length))]);

219    strokeWeight(int(f_mrk421*1000));
220    //strokeWeight(flux_mrk421[int(random(flux_mrk421.length))]);

227    strokeWeight(int(f_mrk501*1000));
228    //strokeWeight(flux_mrk501[int(random(flux_mrk501.length))]);
```

Now, you can run the app while SuperCollider is running too!

---
### References

https://es.wikipedia.org/wiki/Fotomultiplicador
http://artecienciaytecnologias.mx/
https://www.hawc-observatory.org/
https://historiaybiografias.com/calendario/