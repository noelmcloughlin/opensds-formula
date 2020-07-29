###  sodafoundation/backend/block/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

   {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
  - sodafoundation.backend.block.daemon.clean
  - sodafoundation.backend.block.box.clean
  - sodafoundation.backend.block.release.clean
  - sodafoundation.backend.block.repo.clean
  # iscsi.target.remove        #https://github.com/saltstack-formulas/iscsi-formula/issues/12
  - lvm.lv.remove
  - lvm.vg.remove
  - lvm.pv.remove
  - lvm.files.remove

   {%- endif %}
