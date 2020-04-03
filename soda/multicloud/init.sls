###  soda/multicloud/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('controller',)  %}

include:
  - soda.multicloud.release
  - soda.multicloud.repo
  - soda.multicloud.config
  - soda.multicloud.daemon

   {%- endif %}
