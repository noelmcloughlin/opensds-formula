### soda/backend/block/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}

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
  - soda.backend.block.release
  - soda.backend.block.repo
  - soda.backend.block.box
  - soda.backend.block.daemon

   {%- endif %}
