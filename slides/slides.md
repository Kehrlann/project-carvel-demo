---
theme:
  name: catppuccin-latte
  override:
    default:
      margin:
        percent: 8
    footer:
      style: empty
title: Project Carvel
sub_title: Composable Tools for Application Management
author: Daniel Garnier-Moiroux
---

Daniel Garnier-Moiroux
===

## Daniel Garnier-Moiroux

Software engineer @ Broadcom, Tanzu-Spring

🧑‍💻Carvel user

<!-- new_lines: 1 -->
On the web:

🐦️ @kehrlann

🐘️ @kehrlann@hachyderm.io

🐙️ github.com/Kehrlann

🌍️ https://garnier.wf

<!-- end_slide -->

On the menu
===

- What's **carvel**?
    - https://carvel.dev

<!-- new_lines: 1 -->

- The tools:
    - .           **ytt**   YAML templating and manipulation
    - .          **kapp**   Friendlier `kubectl`
    - .          **kbld**   Resolve image names to their SHA sums
    - .        **imgpkg**   Package config files as an OCI image
    - **kapp-controller**   Compose these tools together for "GitOps"

<!-- end_slide -->


YTT: "Yaml Templating Tool"
===

## YAML-based programming

YAML-aware, program written in comments

Any YAML, not just Kubernetes resources!

<!-- new_lines: 1 -->

## Substitute for Helm and Kustomize

Can be combined with both tools

<!-- end_slide -->


kapp: Friendlier alternative to `kubectl`
===

## "App" concept

Groups resources together

<!-- new_lines: 1 -->

## Waiting built-in

Waits for the resources to become Ready

<!-- new_lines: 1 -->

## Powerful ordering

Order resources, manage dependencies



<!-- end_slide -->

kbld + imgpkg for reproducibility
===

## kbld

Resolve image references to their SHA sums

Produce a lock file

<!-- new_lines: 1 -->

## imgpkg

Bundle configuration together into an OCI image

Relocate bundles and dependencies across repositories

<!-- end_slide -->

kapp-controller: App CRD
===


```yaml
apiVersion: kappctrl.k14s.io/v1alpha1
kind: App
metadata:
  name: simple-app
  namespace: default
spec:
  cluster: # deploy to another cluster

  fetch: # where to pull files from
    - inline: # directly in the resource
    - image: # pulls content from Docker/OCI registry
    - imgpkgBundle: # pulls imgpkg bundle from Docker/OCI registry (v0.17.0+)
    - http: # uses http library to fetch file
    - git: # uses git to clone repository
    - helmChart: # uses helm fetch to fetch specified chart

  template: # how to template the files
    - ytt: # use ytt to template configuration
    - kbld: # use kbld to resolve image references to use digests
    - helmTemplate: # use helm template command to render helm chart
    - cue: # use cue to template configuration
    - sops: # use sops to decrypt *.sops.yml files (optional; v0.11.0+)

  deploy: # how to deploy
    - kapp: # use kapp to deploy resources
```
<!-- end_slide -->


kapp-controller: `kctrl` for consumers
===

## Packaging and distribution

Through custom resources: `PackageRepository`, `Package`, `PackageInstall`...

<!-- new_lines: 1 -->

## `kctrl` cli

Discover and consume packages without Kubernetes resources


<!-- end_slide -->

Thank you!
===


<!-- column_layout: [1, 1] -->

<!-- column: 0 -->

**github.com/Kehrlann/project-carvel-demo**

```
█▀▀▀▀▀█  ▀  █ ▀▄▀ █▀██▄▀  █▀▀▀▀▀█
█ ███ █ █▄▀█▄ ▀█  ▄ ▀▀█ ▄ █ ███ █
█ ▀▀▀ █ █▄   ▄▀▀▀▀▄▄▀▀ ▀▄ █ ▀▀▀ █
▀▀▀▀▀▀▀ █ █▄█ ▀ █ █▄█▄▀ ▀ ▀▀▀▀▀▀▀
▀ █▀▀█▀▄▄█▀▄ █▀ ██ █▄  ▄  ██▀██ ▄
████▄▀▀ █▀▀█ █▀▀██▄▄▀██ █ ▄ █▄██ 
 ▀▄█ ▄▀▀████ ▄▀▄▀ ▄▀▀ ▀█▀█▄ ▀▀▄█▄
▄█   ▀▀▀  ▀▀▄█▄█▀▀█ ▀▄▀  ██▄ █▄▀ 
▀ █  █▀██  ▀▀█ ▀ ▀▄ ▄ ▀█▀▀▄█▀█▄ █
▀▄▀▄▀▀▀█▄▄█▀▀ ▀▀▄ ▀▄█▄█ ▀▀▄██▄█▀▄
▄▀█  ▄▀ ▄▀▀▄  ▄▄▄▄▀▀▄█ ▄█▀▄▀▀█▄ █
█ ▀█ ▀▀▄▄▄ ▄█▄  ▄ ▄█▄▄▄ ▀█▄▄▀ ██▄
▀ ▀  ▀▀ ▄▄▄▀██▄ ▄█▄█  ▀██▀▀▀█ ▄▀█
█▀▀▀▀▀█ ▄▄▄▄█  ▀▄█▄ █ ▀██ ▀ █▄██▄
█ ███ █ █▀ █▄█▄▄▀ ▄▀▀▀▀▄██▀▀██ ▀█
█ ▀▀▀ █ ▀▄█▀██ █▀ ▀ ▀▄█  ▄▀▀▄██  
▀▀▀▀▀▀▀ ▀▀▀▀▀ ▀▀ ▀    ▀▀▀▀ ▀   ▀ 
```

🐦️ @kehrlann

🐘️ @kehrlann@hachyderm.io

🐙️ github.com/Kehrlann

🌍️ https://garnier.wf

<!-- column: 1 -->

## Feedback please 🥺️

```
█▀▀▀▀▀█ ███▄ ▄▀▀▄█ █▀▄█▀ █  ▀ █▀▀▀▀▀█
█ ███ █ ▀▄▀▄█▀█▀   ▀ ███▄█  █ █ ███ █
█ ▀▀▀ █ ▀▀█▄▀ ▄▄▄ ▀▀████ ▄█ ▀ █ ▀▀▀ █
▀▀▀▀▀▀▀ ▀▄▀▄█ █ █▄█▄▀ █▄▀▄▀ █ ▀▀▀▀▀▀▀
█ ▄██▀▀█▀ ▄█▄ ▀▀▄ ▄▀   ▀▀ ▀█▀█▄▄█▄▀█▀
▀▀ ▀█▀▀ █▄▄█▀▀▄▀█▄███▀▄█▀▀▀█▀  ▄ ▄█▄█
▀█ ███▀▄█   █ ▄█   ▄▀▀ ██▄▄▄█▄▀▀▄█  ▀
▀█▄ █▀▀█ ██▄▀ ▄██ ▀▀█ █▄  ▀▀ ▀▀▄▀██ ▀
 █▀▀▄█▀▀█▀█▀▄▄ ▀ █▀  ██▄▀▀ ▀ ▄▀▄ ▄▀  
 ▀ ▀ ▄▀▀▄██ ▄█ ▄█▀▀█▄ ▄▀██▀▀ ▀█  █  █
 ▄ ▄▀ ▀▀██▄█▄ █▄▄▄▄█▀▄▄▄▀ █▄▀▀▀▀█ ▄ ▄
█ ▄█▀ ▀▄▀▄ ▄▄▄ █▀ ▄  ▀██▄ ██  ▀█▄█▄▄█
▄ █▄▀█▀█▄ ▀▀█▄█▀ █▄█▀▀▀▄▄▄▀▀█▄██▄▄   
█▀▄▄ ▀▀▀ ▀█▄██ ▀▄▀█▄   ▄▀  █▄███ ▄█▀▀
▀  ▀  ▀▀▄▄▀█▄█▀▀ ▄▄█▄▄█▀▀█ ▀█▀▀▀█▀█▄█
█▀▀▀▀▀█ ██ ▄▄█▄█▀▀▀▀█▄ █▀█▀▄█ ▀ █  ▄█
█ ███ █ ████  ▀▀▀▄▀ ██▄█▀▄█▀▀██▀▀▄  █
█ ▀▀▀ █  ▀█  █▀▄ ██  ▀ ▀▀▀█▄▀█  ██▄▄█
▀▀▀▀▀▀▀ ▀ ▀▀ ▀▀    ▀▀▀  ▀ ▀ ▀▀ ▀ ▀  ▀
```

🤝️ Join `#carvel` on Kubernetes slack

🐦️ `@carvel_dev`
