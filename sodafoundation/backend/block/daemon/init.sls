###  sodafoundation/backend/block/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

  {%- if sodafoundation.deploy_project not in ('gelato',)  %}

{%- from "sodafoundation/map.jinja" import docker, packages, golang with context %}
{%- from 'sodafoundation/files/macros.j2' import build_source, cp_binaries with context %}
{%- from 'sodafoundation/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - sodafoundation.backend.block.box

      {%- if sodafoundation.backend.block.ids is iterable and sodafoundation.backend.block.ids is string %}
          {%- set backends = sodafoundation.backend.block.ids.split(', ') %}
      {%- else %}
          {%- set backends = sodafoundation.backend.block.ids %}
      {%- endif %}
      {%- for id in backends %}
          {%- if 'daemon' in sodafoundation.backend.block and id in sodafoundation.backend.block.daemon  %}
              {%- if sodafoundation.backend.block.daemon[ id ] is mapping %}

    {%- if id == 'cinder' and  grains.os in ('CentOS', ) %}
sodafoundation infra use git2 on EL:
  pkg.installed:
    - sources:
      - ius-release: https://centos7.iuscommunity.org/ius-release.rpm
  cmd.run:
    - names:
      - /bin/yum swap git git2u -y
      - /sbin/setsebool -P nis_enabled 1        ###for RabbitMQ
  {%- endif %}

{{ workflow('sodafoundation', 'backend block daemon', id, sodafoundation.backend.block, sodafoundation.dir.sushi, sodafoundation, golang) }}

              {%- endif %}
          {%- endif %}
      {%- endfor %}
  {%- endif %}
