###  soda/backend/block/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

  {%- if soda.deploy_project not in ('multicloud',)  %}

{%- from "soda/map.jinja" import docker, packages, golang with context %}
{%- from 'soda/files/macros.j2' import build_source, cp_binaries with context %}
{%- from 'soda/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - soda.backend.block.box

      {%- if soda.backend.block.ids is iterable and soda.backend.block.ids is string %}
          {%- set backends = soda.backend.block.ids.split(', ') %}
      {%- else %}
          {%- set backends = soda.backend.block.ids %}
      {%- endif %}
      {%- for id in backends %}
          {%- if 'daemon' in soda.backend.block and id in soda.backend.block.daemon  %}
              {%- if soda.backend.block.daemon[ id ] is mapping %}

    {%- if id == 'cinder' and  grains.os in ('CentOS', ) %}
soda infra use git2 on EL:
  pkg.installed:
    - sources:
      - ius-release: https://centos7.iuscommunity.org/ius-release.rpm
  cmd.run:
    - names:
      - /bin/yum swap git git2u -y
      - /sbin/setsebool -P nis_enabled 1        ###for RabbitMQ
  {%- endif %}

{{ workflow('soda', 'backend block daemon', id, soda.backend.block, soda.dir.nbp, soda, golang) }}

              {%- endif %}
          {%- endif %}
      {%- endfor %}
  {%- endif %}
