---
layout: post
title:  "Local Energy: an open-source energy dashboard"
date:   2022-10-12
author: "Niels Delestinne"
categories: front-end angular
comments: false
---

The HomeWizard's P1 meter shows you the electricity and gas usage of your home. 
It offers a local API for which I've created a little open-source dashboard for both web and Android.

<!--more-->

## P1 meter

The [HomeWizard's P1 meter](https://www.homewizard.com/p1-meter/) clicks into the P1 port on your Belgian (or Dutch) smart meter. 
For electricity, it shows you your real-time usage (1 second interval & up). For gas, it shows you the usage each 5 minutes & up.

The P1 meter comes with its own, fine Android app. However - from time to time - the central server seems to lag behind, hindering us to have a real-time view of our energy usage. Given that we invested in solar panels and want to have a good view on when we are importing or exporting electricity, I wanted a better solution.

## Dashboard app 

Luckily, the P1 meter comes with it owns [local, HTTP-based API](https://homewizard-energy-api.readthedocs.io/). 
This allowed me to create a [small open-source dashboard called Local Energy](https://github.com/nielsdelestinne/homewizard-local-energy) to track our real-time energy usage without any delay of server latency or instability.
- The app relies on the [local API](https://homewizard-energy-api.readthedocs.io/) of the P1 meter being enabled.
- By default, the app can only be used locally, on the same network as to which the P1 meter is connected 
     - Using port forwarding on port `80` of the P1 meter would allow for external network access (do take into account the risks of port forwarding).

![Local Energy - Web App Dashboard](/assets/img/2022-10-08/web-app-dashboard.png)

The Dashboard can be built and used as:
- A Web-app
- An Android app

A [first version](https://github.com/nielsdelestinne/homewizard-local-energy/releases/tag/v1.0.0) (`1.0.0 - Power`) has been released containing the following features.

## Features

### Dashboard

_The live widgets dynamically change their colour & icon._

#### Live power data
The P1 meter is pollable each 1s, _this rate is used & hard-coded_.
- View the current (live) amount of power you are injecting (or importing).
- View a graph of the current (live) amount of power you are injecting (or importing).
- View the current (live) wi-fi strength of the P1 Meter.

#### Historical power data
- View the historical amount of power you have injected (day v.s. night / weekend).
- View the historical amount of power you have imported (day v.s. night / weekend).

### Settings

The following settings can be changed using the gear icon on the top-right.
- The local IP of the P1 meter's local API.
- The buffer size (in minutes) of the data that the graph widget will display.
    - E.g. with a buffer size of 15 minutes & a hard-coded polling interval of 1 second, the graph will display 900 data points.
- Show or hide the x-axis labels of the graph.