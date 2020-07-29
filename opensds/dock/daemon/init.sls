{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if s.deploy_project not in ('gelato',)  %}

{%- from "sodafoundation/map.jinja" import packages, docker, golang with context %}
{%- from 'sodafoundation/files/macros.j2' import create_dir, build_source, cp_binaries with context %}
{%- from 'sodafoundation/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - s.dock.config

      {%- for id in s.dock.ids %}
        {% if 'daemon' in s.dock and id in s.dock.daemon and s.dock.daemon[id] is mapping %}

{{ workflow('sodafoundation', 'dock daemon', id, s.dock, s.dir.hotpot, sodafoundation, golang) }}

        {%- endif %}
      {%- endfor %}
    {%- endif %}
