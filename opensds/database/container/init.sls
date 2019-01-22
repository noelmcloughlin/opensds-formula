###  opensds/database/container/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{% from "opensds/map.jinja" import opensds, docker with context %}

include:
  - opensds.database.container.build

  {%- for instance in opensds.database.instances %}
     {%- if instance in opensds.database.container %}
        {%- set container = opensds.database.container[ instance|string ] %}

           ##########################
           #### START CONTAINERS ####
           ##########################
        {%- if container.enabled and not container.build %}

opensds database container {{ instance }} running:
  docker_container.running:
    - name: {{ instance }}
    - image: {{ container.image }}:{{ container.version }}
    - restart_policy: always
    - network_mode: host
         {%- if "volumes" in container %}
    - binds: {{ container.volumes }}
         {%- endif %}
         {%- if "ports" in container %}
    - port_bindings: {{ container.ports }}
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

        {%- endif %}
    {%- endif %}
  {%- endfor %}
