###  sodafoundation/telemetry/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

include:
  - sysstat
  - prometheus
  - grafana
