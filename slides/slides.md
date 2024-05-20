---
# run with https://github.com/mfontanini/presenterm
theme:
  name: catppuccin-latte
  override:
    default:
      margin:
        percent: 8
    footer:
      style: empty
title: Project Carvel
sub_title: Small tools for joyful k8s deployments
author: Daniel Garnier-Moiroux
---

Daniel Garnier-Moiroux
===

Software Engineer @ Broadcom

- 🍃 Spring
- 🚢 Tanzu Application Platform

<!-- new_lines: 1 -->
🧑‍💻Carvel user

<!-- new_lines: 1 -->
On the web:

- 🐦️ @kehrlann
- 🐘️ @kehrlann@hachyderm.io
- 🐙️ github.com/Kehrlann
- 🌍️ https://garnier.wf
- 📩️ contact@garnier.wf

<!-- end_slide -->

Disclaimer 📄
===

🔭   This is an overview, very partial

🏎️💨 A lot of content, this may go a bit fast (sorry)

🧑‍💻 I'm more of a "Developer", not much of an "Operator"

<!-- end_slide -->


The plan
===

1. **What's Carvel?**
1. Create some YAML with `ytt`
1. Deploy it with `kapp`
1. Make it prod-ready and publish it with `kbld` and `imgpkg`
1. GitOps and Package Management with `kapp-controller` and `kctrl`

<!-- end_slide -->


What's carvel?
===

🏖️ CNCF **Sandbox** project

> ‌
> Carvel provides a set of reliable, single-purpose,
> composable tools that aid in your application building,
> configuration, and deployment to Kubernetes.
> ‌

<!-- new_lines: 1 -->
⏩ https://carvel.dev/

<!-- end_slide -->


The plan
===

1. What's Carvel?
1. **Create some YAML with `ytt`**
1. Deploy it with `kapp`
1. Make it prod-ready and publish it with `kbld` and `imgpkg`
1. GitOps and Package Management with `kapp-controller` and `kctrl`

<!-- end_slide -->


YTT: "Yaml Templating Tool"
===

## YAML-based programming

YAML-aware, program written in comments

Any YAML, not just Kubernetes resources!

<!-- new_lines: 1 -->

## Substitute for `helm template`

- Control flow (for, if)
- Functions
- Data values

<!-- end_slide -->


Let's make some YAML!
===

```
  ┌──────────────────────┐          ┌────────────────────────────┐
  │ Deployment           │          │ Service                    │
  │                      │          │                            │
  │   image: nginx       ◄──────────┤                            │
  │                      │          │                            │
  └──────────┬───────────┘          └────────────▲───────────────┘
             │                                   │
  ┌──────────▼───────────┐          ┌────────────┴───────────────┐
  │ ConfigMap            │          │ Ingress                    │
  │                      │          │                            │
  │   data:              │          │   fqdn:                    │
  │     index.html: ""   │          │    <name>.127.0.0.1.nip.io │
  └──────────────────────┘          └────────────────────────────┘
```

One of  these for each of:

```yaml
["apples", "bananas", "strawberries"]
```

<!-- end_slide -->


YTT: "Yaml Templating Tool"
===

## YAML-patching

Applying "overlays"

<!-- new_lines: 1 -->

## Substitute for `kustomize`

<!-- end_slide -->


YTT: "Yaml Templating Tool"
===

Can work with `helm` and `kustomize`

<!-- new_lines: 1 -->

⏩️ https://carvel.dev/ytt

<!-- new_lines: 1 -->

`$ ytt website`

<!-- end_slide -->


The plan
===

1. What's Carvel?
1. Create some YAML with `ytt`
1. **Deploy it with `kapp`**
1. Make it prod-ready and publish it with `kbld` and `imgpkg`
1. GitOps and Package Management with `kapp-controller` and `kctrl`

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


The plan
===

1. What's Carvel?
1. Create some YAML with `ytt`
1. Deploy it with `kapp`
1. **Make it prod-ready and publish it with `kbld` and `imgpkg`**
1. GitOps and Package Management with `kapp-controller` and `kctrl`

<!-- end_slide -->


kbld: reproducibility
===

Resolve image references to their SHA sums

Produce a lock file

```yaml
foo: bar
image: bitnami/nginx:1.25.2


# ⏬ kbld ⏬


foo: bar
image: bitnami/nginx@sha256:...
```

<!-- end_slide -->


imgpkg
===

"tar" & "ftp", but with OCI registries

"bundle" files in a non-runnable OCI image, and push/pull it

-> 📦 Enables "RegistryOps"

<!-- end_slide -->


The plan
===

1. What's Carvel?
1. Create some YAML with `ytt`
1. Deploy it with `kapp`
1. Make it prod-ready and publish it with `kbld` and `imgpkg`
1. **GitOps and Package Management with `kapp-controller` and `kctrl`**

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
# TODO: qr code

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

📩️ contact@garnier.wf

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
