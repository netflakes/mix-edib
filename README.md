# EDIB mix task

[![Hex.pm package version](https://img.shields.io/hexpm/v/edib.svg?style=flat-square)](https://hex.pm/packages/edib)
[![Hex.pm package docs](https://img.shields.io/badge/hex-docs-orange.svg?style=flat-square)](http://hexdocs.pm/edib/)
[![Hex.pm package license](https://img.shields.io/hexpm/l/edib.svg?style=flat-square)](https://github.com/edib-tool/mix-edib/blob/master/LICENSE)
[![Build Status (master)](https://img.shields.io/travis/edib-tool/mix-edib/master.svg?style=flat-square)](https://travis-ci.org/edib-tool/mix-edib)
[![Coverage Status (master)](https://img.shields.io/coveralls/edib-tool/mix-edib/master.svg?style=flat-square)](https://coveralls.io/r/edib-tool/mix-edib)
[![Inline docs](http://inch-ci.org/github/edib-tool/mix-edib.svg?branch=master&style=flat-square)](http://inch-ci.org/github/edib-tool/mix-edib)

A mix task for [EDIB (elixir docker image builder)](https://github.com/edib-tool/elixir-docker-image-builder).

<!--
  TOC generaged with doctoc: `npm install -g doctoc`

    $ doctoc README.md --github --maxlevel 4 --title '## TOC'

-->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## TOC

- [Installation](#installation)
- [Usage](#usage)
- [Help](#help)
- [Options](#options)
  - [Name, prefix, tag](#name-prefix-tag)
  - [Silent mode (quiet mode)](#silent-mode-quiet-mode)
  - [Volume mappings](#volume-mappings)
  - [Docker related](#docker-related)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->
<!-- moduledoc: Mix.Tasks.Edib -->
EDIB creates a docker image of your application release.

## Installation

Just run this and confirm:

    mix archive.install http://git.io/edib-0.5.1.ez

Don't forget to add `exrm` to your project:

    defp deps do
      [
        {:exrm, "~> 0.19"},
      ]
    end

## Usage

    mix edib

## Help

    mix help edib

## Options

### Name, prefix, tag

Override the (repository) name of the docker image

    mix edib --name <NAME>
    mix edib -n <NAME>

Set only a specific prefix for the docker image name (default: local)

    mix edib --prefix <PREFIX>
    mix edib -p <PREFIX>

Set a specific tag for the docker image

    mix edib --tag <TAG>
    mix edib -t <TAG>

If `--name` and `--prefix` are given, the name option takes precedence
(prefix will be ignored).

### Silent mode (quiet mode)

    # Silence build output of EDIB (will be logged to `.edib.log` instead)
    mix edib --silent
    mix edib -s

### Volume mappings

Map additional volumes for use while building the release

    mix edib --mapping <FROM>:<TO>[:<OPTION>]
    mix edib -m <FROM>:<TO>[:<OPTION>]

For common cases there are some mapping shorthands:

Include the host user's SSH keys for private GitHub repositories

    mix edib --ssh-keys

Include host user's .hex/packages cache

Can improve build times when the host's .hex cache is available for
every build run (tip for Travis CI: use their directory caching)

    mix edib --hex

Include host user's .npm package cache

Can improve build times when the host's .npm cache is available for
every build run (tip for Travis CI: use their directory caching)

    mix edib --npm

### Docker related

Docker flags (mostly for debug purposes):

Run the build step privileged

    mix edib --privileged

Do not remove intermediate containers on build runs

    mix edib --no-rm

<!-- endmoduledoc: Mix.Tasks.Edib -->
