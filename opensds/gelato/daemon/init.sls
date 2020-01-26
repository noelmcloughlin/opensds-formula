###  opensds/gelato/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "opensds/map.jinja" import opensds with context %}

    {%- if opensds.deploy_project not in ('hotpot',)  %}

{%- from "opensds/map.jinja" import docker, packages, golang with context %}
{%- from 'opensds/files/macros.j2' import build_source, cp_binaries with context %}
{%- from 'opensds/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - opensds.gelato.config
        {%- if "keystone" in opensds.hotpot.opensdsconf.osdslet.auth_strategy|lower %}

  - devstack.cli
        {%- else %}

opensds gelato daemon init skipping keystone:
  test.show_notification:
    - text: |
        Skipping keystone because `auth_strategy: noauth` (or something else) was configured!
        {%- endif %}

        {%- for id in opensds.gelato.ids %}
           {%- if 'daemon' in opensds.gelato and id in opensds.gelato.daemon %}
               {%- if opensds.gelato.daemon[ id ] is mapping %}

               {%- if id == 'multi-cloud' and grains.os_family in ('RedHat',) %}
opensds gelato daemon {{ id }} workaround Failed-to-program-FILTER-chain:
  cmd.run:
    - name: systemctl restart docker
               {%- endif %}


{{ workflow('opensds', 'gelato daemon', id, opensds.gelato, opensds.dir.gelato, opensds, golang) }}

               {%- endif %}
           {%- endif %}
        {%- endfor %}
    {%- endif %}
