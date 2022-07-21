---
layout: post
title:  "A few words on multi-project workspaces in Angular"
date:   2021-03-02
author: "Niels Delestinne"
categories: front-end angular
comments: true
---

A typical Angular workspace contains a single project. Each new project requires a new workspace. Configuration gets duplicated and 
reuse of modules is possible but not straightforward. A multi-project workspace might be a better fit.

## What's wrong with a typical workspace?

Short answer: **absolutely nothing**. However, you might have requirements that are better supported with a multi-project workspace.

Creating an Angular front-end application is typically done by firing up Angular CLI and running command `ng new <my-project>`.
It will create a new workspace, containing a single Angular application which can be found under folder `/app`.

This setup works perfectly fine if you only have to support one Angular application.
When you're working in larger, or even enterprise environments where you and your team become responsible for more than one 
Angular application, the aforementioned setup no longer meets the requirements.

As each Angular application resides in its own workspace, the configuration and dependency management has to be maintained separately. 
You might want to reuse certain modules and components between multiple Angular applications, but it often requires a solution where
the module needs to be packaged and published to a (private) repository.
This will slow down development by introducing multiple levels of overhead. An alternative might be to simply duplicate the code, 
but over time this approach will heavily reduce the overall maintainability of your applications.

Using the multi-project workspace approach, we can create a workspace that contains not one, but all of our Angular applications.

## Multi-project workspace

Angular and Angular CLI fully support a multi-project workspace: 
- An Angular multi-project **workspace** consists of one or more **projects**.
- A **project** is either of type **'application'** or of type **'library'**.
- An **application** is a thin shell wiring in (feature, utility,...) libraries, resulting in a deployable artifact to be served to clients.
- A **library** represents a specific feature or utility (among others) and can be included by other libraries or by applications.
    - These libraries are not intended to be published, but instead only to be included in the workspace internally.     

A multi-project workspace follows the mono-repository or monorepo model: the entire workspace is under version control using a single repository.
Depending on how your teams are organised, this can be an organisation-wide monorepo or a team-based monorepo.

**Want to learn more?**
- [Angular Libraries](https://angular.io/guide/libraries)
- [Angular Workspace](https://angular.io/guide/file-structure)
- [Angular Multi-project workspace](https://angular.io/guide/file-structure#multiple-projects)
- [Angular Multi-project workspace tutorial](https://octoperf.com/blog/2019/08/22/kraken-angular-workspace-multi-application-project/#complete-application-sample)

## Angular CLI or Nx?

Although Angular CLI has support for setting up multi-project workspaces, Nx of Nrwl is the better tool for the job.
Using Nx, we can set up a multi-project Angular workspace containing opinionated but sensible defaults regarding structure and technologies.

> Nx can be used for an Angular specific workspace, but does support different frameworks such as React and Node.js. 

With Nx, we receive:
- JEST and Cypress configured as testing frameworks
- ESLint instead of the deprecated TSLint
- A folder structure and conventions optimized for a multi-project workspace
- Commands to format, lint and test only the **affected** code
- Libraries optimized for internal use (although they can be generated as publishable when required)
- Constraints on dependencies (who can depend on who)
- A visual dependency graph
- _And many more..._

> Nx decorates the Angular CLI and uses the Angular Devkit just as Angular CLI would.

**Want to learn more?**
- [Nx](https://nx.dev/)
- [Nx: Getting Started](https://nx.dev/latest/angular/getting-started/getting-started)
- [Enterprise Monorepo Angular Patterns (Free e-book)](https://go.nrwl.io/angular-enterprise-monorepo-patterns-new-book)
