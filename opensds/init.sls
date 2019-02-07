### opensds/init.sls
include:
  {{ '- epel' if grains.os_family in ('RedHat',) else '' }}  
  - opensds.infra
  - opensds.config
  - opensds.database
  - opensds.auth
  - opensds.hotpot
  - opensds.sushi
  - opensds.backend
  - opensds.dock
  - opensds.dashboard
  - opensds.gelato

opensds init auto-remove debian packages:
  cmd.run:
    - name: apt autoremove -y
    - onlyif: {{ grains.os_family == 'Debian' }}
