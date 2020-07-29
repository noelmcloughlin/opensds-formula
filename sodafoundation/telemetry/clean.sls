### sodafoundation/telemetry/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

include:
  - prometheus.clean
  - grafana.clean
  - sysstat.clean
