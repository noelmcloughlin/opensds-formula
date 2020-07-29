### sodafoundation/backend/block/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

   {%- if sodafoundation.deploy_project not in ('gelato',)  %}

include:
      {%- if grains.os_family not in ('Suse',) %}
  - ceph.repo
      {%- endif %}
  - lvm.install
  - lvm.files.create
  - lvm.pv.create
  - lvm.vg.create
  - lvm.lv.create
  - iscsi.target
  - sodafoundation.backend.block.release
  - sodafoundation.backend.block.repo
  - sodafoundation.backend.block.box
  - sodafoundation.backend.block.daemon

   {%- endif %}
