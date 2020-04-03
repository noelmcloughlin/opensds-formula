###  soda/backend/block/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}

include:
  - soda.backend.block.daemon.clean
  - soda.backend.block.box.clean
  - soda.backend.block.release.clean
  - soda.backend.block.repo.clean
  # iscsi.target.remove        #https://github.com/saltstack-formulas/iscsi-formula/issues/12
  - lvm.lv.remove
  - lvm.vg.remove
  - lvm.pv.remove
  - lvm.files.remove

   {%- endif %}
