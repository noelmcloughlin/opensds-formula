###  soda/nbp/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - iscsi.initiator
  - kubernetes.kubectl
  - soda.nbp.release
  - soda.nbp.repo
  - soda.nbp.config
  - soda.nbp.plugin

   {%- endif %}
