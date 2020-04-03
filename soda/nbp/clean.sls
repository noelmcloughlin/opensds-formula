###  soda/nbp/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.nbp.plugin.clean
  - soda.nbp.config.clean
  - soda.nbp.release.clean
  - soda.nbp.repo.clean
  # iscsi.initiator.remove     ### https://github.com/saltstack-formulas/iscsi-formula/issues/12
  - kubernetes.kubectl.clean

   {%- endif %}
