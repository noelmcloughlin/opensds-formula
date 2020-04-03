###  soda/dock/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.dock.release
  - soda.dock.repo
  - soda.dock.config
  - soda.dock.drivers
  - soda.dock.daemon

    {%- endif %}
