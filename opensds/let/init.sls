### opensds/let/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "opensds/map.jinja" import opensds, docker with context %}

    {%- if opensds.let.container.enabled %}
       {% if opensds.let.container.composed %}

include:
  - opensds.envs.docker

       {#- elif opensds.let.container.build #}
       {%- else %}

opensds let {{ opensds.controller.release }} container service running:
  docker_container.running:
    - name: {{ opensds.let.service }}
    - image: {{ opensds.let.container.image }}
    - restart_policy: always
    - network_mode: host
         {%- if "volumes" in opensds.let.container %}
    - binds: {{ opensds.let.container.volumes }}
         {%- endif %}
         {%- if "ports" in opensds.let.container %}
    - port_bindings: {{ opensds.let.container.ports }}
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
  {% else %}

## workaround salt/issues/49712
opensds let ensure opensds dirs exist:
  file.directory:
    - names:
      {%- for k, v in opensds.dir.items() if v not in ('root', '700', '0700',) %}
      - {{ v }}
      {%- endfor %}
    - makedirs: True
    - force: True
    - dir_mode: '0755'

    #### Update opensds.conf ####
opensds let ensure opensds config file exists:
  file.managed:
   - name: {{ opensds.controller.conf }}
   - makedirs: True
   - mode: '0755'

    {% for section, data in opensds.let.opensdsconf.items() %}

opensds let ensure opensds config {{ section }} section exists:
  ini.sections_present:
    - name: {{ opensds.controller.conf }}
    - sections:
      - {{ section }}

         {%- for k, v in data.items() %}

opensds let ensure opensds config {{ section }} {{ k }} exists:
  ini.options_present:
    - name: {{ opensds.controller.conf }}
    - separator: '='
    - strict: True
    - sections:
        {{ section }}:
          {{ k }}: {{ v }}
    - require:
      - opensds let ensure opensds config {{ section }} section exists

        {%- endfor %}
     {%- endfor %}
     {%- for i in (1,2,3,4,5) %}

opensds let start daemon service attempt {{ loop.index }}:
  cmd.run:
    - name: nohup {{opensds.dir.work}}/bin/osdslet >{{opensds.dir.log}}/osdslet.out 2> {{opensds.dir.log}}/osdslet.err &
    - unless: ps aux | grep osdslet | grep -v grep
    - onlyif: sleep 5

     {% endfor %}
  {%- endif %}
