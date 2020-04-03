###  soda/telemetry/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

include:
  - sysstat
  - prometheus
  - grafana
