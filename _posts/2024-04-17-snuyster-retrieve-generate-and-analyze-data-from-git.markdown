---
layout: post
title:  "Snuyster: retrieve, generate and analyze data from Git"
date:   2024-04-17
author: "Niels Delestinne"
categories: snuyster analysis git insights
comments: false
---

Snuyster helps to understand large-scale software systems by looking at their evolution. Design issues, bottlenecks, developer turnover and other general insights can all be exposed via version controlled data.

<!--more-->

## Your code as a Crime Scene

It's been a while since I have read Adam Thornhill's book "Your Code as a Crime Scene" and used its accompanying tool "code-maat". However, when I recently joined a new project, I revisited the book and its practices and applied them to the customer's application landscape.

Although code-maat is a good tool for performing the actual analyses, you're required to perform quite some manual steps and work to gather and combine all results from different repositories.

Therefore, during my many train rides, I created Snuyster.

## Snuyster

> Snuyster is a command-line tool to retrieve, generate and analyze data from Git repositories.

With Snuyster, you can easily configure a set of Git repositories to analyse, perform the actual analyses and aggregate the cross-repo results into `.csv` files. It will even plot you a nice summary graph.

It's written in Bash and Python and fully open-sourced: https://github.com/nielsdelestinne/snuyster

## Features

Let's dive a bit deeper into Snuyster's features

### Dockerized runtime

Snuyster comes with batteries included: Snuyster's Docker image contains all required tools, scripts and a convenient cli to perform analyses and extract the resulting data.

### Git support

Snuyster can access your public and private repositories with ease:

- Provide Snuyster with a set of repository URLs and it will clone the repositories for you.
- Or, mount a directory which already contains your cloned repository.

Snuyster will use these repositories to extract their entire Git history, in a processable format for further analysis.

### Perform analyses

Snuyster allows you to perform many different analyses on the extracted data.

For performing the actual analyses, the following tools are used:

- [Code Maat](https://github.com/adamtornhill/code-maat): analyze data from version-control systems (VCS).
- [Cloc](https://github.com/AlDanial/cloc): counts blank lines, comment lines, and physical lines of source code in many programming languages.

### Aggregation

Snuysters aggregates the results of the performed analyses of individual Git repositories into combined reports that span all repositories.

This allows to easily compare the analysis results between repositories.

### CSV Reports

All reports (individual and aggregated) are exported as CSV files and can be imported into other tools - like spreadsheets - for further analysis.

The graph below shows the amount of added lines, per year, for each repository.

![graph](/assets/img/2024-04-17/added_lines_per_repository_temporal.png)

## Using Snuyster

To use Snuyster, simply start its `Docker` container:

{% highlight bash %}
docker run \
-v <path>/repositories:/repositories \
-v <path>/results:/results \
-v ~/.ssh:/root/.ssh:ro \
--name snuyster -it niedel/snuyster:latest
{% endhighlight %}

## Final notes

Feel free to use Snuyster how you see fit, hopefully you'll find it useful.

You can find Snuyster at https://github.com/nielsdelestinne/snuyster.

If you have any questions, remarks or requests regarding Snuyster, please interact via the GitHub repository.