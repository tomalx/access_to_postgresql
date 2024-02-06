Connect and Access postgresql database
================

`{r setup, include=FALSE} knitr::opts_chunk$set(echo = FALSE)`

## Overview

This repository covers the steps to connect and access Theo’s postgresql
database using R.

## Prerequisites

Assumes that you have authorised access to the database and have the
necessary credentials to connect to the database. the file path for
these credentials is only available to authorised users.

## Basic steps

two R scipt: 1 - connect to the database 2 - reading the schema and
tables and accessing the spatial data required.

## Troubleshooting

Spatial data is in WKT text format. Check file path - especially user
name element - this is usually first half of email address. Assumes that
the credentials txt file hasn’t been altered. Check with Theo.
