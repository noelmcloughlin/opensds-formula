###  soda/multicloud/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('controller',)  %}

{%- from "soda/map.jinja" import docker, packages, golang with context %}
{%- from 'soda/files/macros.j2' import build_source, cp_binaries with context %}
{%- from 'soda/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - soda.multicloud.config
        {%- if "keystone" in soda.controller.conf.let.auth_strategy|lower %}

  - devstack.cli
        {%- else %}

soda multicloud daemon init skipping keystone:
  test.show_notification:
    - text: |
        Skipping keystone because `auth_strategy: noauth` (or something else) was configured!
        {%- endif %}

        {%- for id in soda.multicloud.ids %}
           {%- if 'daemon' in soda.multicloud and id in soda.multicloud.daemon %}
               {%- if soda.multicloud.daemon[ id ] is mapping %}

               {%- if id == 'multicloud' and grains.os_family in ('RedHat',) %}
soda multicloud daemon {{ id }} workaround Failed-to-program-FILTER-chain:
  cmd.run:
    - name: systemctl restart docker
               {%- endif %}


{{ workflow('soda', 'multicloud daemon', id, soda.multicloud, soda.dir.multicloud, soda, golang) }}

               {%- endif %}
           {%- endif %}
        {%- endfor %}
    {%- endif %}
