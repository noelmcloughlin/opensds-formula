### soda/telemetry/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

include:
  - prometheus.clean
  - grafana.clean
  - sysstat.clean
