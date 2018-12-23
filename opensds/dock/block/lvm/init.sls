###  opensds/dock/block/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{% from "opensds/map.jinja" import opensds, docker with context %}

   {%- if opensds.dock.block.lvm.container.enabled %}

opensds dock block lvm container running:
  docker_container.running:
    - name: {{ opensds.dock.block.lvm.service }}
    - image: {{opensds.dock.block.lvm.container.image}}:{{opensds.dock.block.lvm.container.version}}
    - restart_policy: always
    - network_mode: host
         {%- if "volumes" in opensds.dock.block.lvm.container %}
    - binds: {{ opensds.dock.block.lvm.container.volumes }}
         {%- endif %}
         {%- if "ports" in opensds.dock.block.lvm.container %}
    - port_bindings: {{ opensds.dock.block.lvm.container.ports }}
         {%- endif %}
           {%- if docker.containers.skip_translate %}
    - skip_translate: {{ docker.containers.skip_translate or '' }}
           {%- endif %}
           {%- if docker.containers.force_present %}
    - force_present: {{ docker.containers.force_present }}
           {%- endif %}
           {%- if docker.containers.force_running %}
    - force_running: {{ docker.containers.force_running }}
           {%- endif %}

    {%- else %}

include:
  - lvm.install
  - lvm.files.create
  - lvm.pv.create
  - lvm.vg.create
  - lvm.lv.create
  - iscsi.target

    {%- endif %}

