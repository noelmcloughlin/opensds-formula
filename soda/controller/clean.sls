###  soda/controller/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.controller.daemon.clean
  - soda.controller.release.clean
  - soda.controller.repo.clean
  - soda.controller.config.clean

    {%- endif %}
