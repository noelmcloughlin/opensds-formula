###  soda/dock/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.dock.daemon.clean
  - soda.dock.release.clean
  - soda.dock.repo.clean
  - soda.dock.config.clean
  - soda.dock.drivers.clean

    {%- endif %}
