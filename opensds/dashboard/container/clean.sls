#r##  opensds/dashboard/container/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{% from "opensds/map.jinja" import opensds with context %}


  {%- for instance in opensds.dashboard.instances %}
    {%- if instance in opensds.dashboard.container %}
       {%- set container = opensds.dashboard.container[ instance|string ] %}
       {%- if container.enabled %}

opensds dashboard container {{ instance }} service removed:
  docker_container.stopped:
    - name: {{ instance }}
    - error_on_absent: False
    - unless: {{ container.build }}
    - require:
      - service: opensds config ensure docker running
  file.absent:
    - name: {{ opensds.dir.hotpot }}/container/{{ instance }}

       {%- endif %}
    {%- endif %}
  {%- endfor %}
