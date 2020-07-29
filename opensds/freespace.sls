###  sodafoundation/freespace.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

sodafoundation freespace auto-remove debian packages:
  cmd.run:
    - name: apt autoremove -y
    - onlyif: {{ grains.os_family == 'Debian' }}

sodafoundation freespace auto-prune docker:
  service.running:
    - name: docker
    - enable: True
    - onlyif: docker --version >/dev/null 2>&1
  #####################################################################
  ##### Commented out due to https://github.com/docker/compose/issues/5745#issuecomment-370048997
  ##cmd.run:
  ##  - names:
  ##    echo $DOCKER_PASS | docker login -u$DOCKER_USER --password-stdin $DOCKER_HOST
  ##    docker system prune -a -f # no, https://github.com/docker/compose/issues/5745#issuecomment-370048997
  ##    docker rm -v $(docker ps -a -q -f status=exited)
  ##    docker rmi -f  $(docker images -f "dangling=true" -q)
  ##    docker volume ls -qf dangling=true | xargs -r docker volume rm
  ##  onlyif: docker --version >/dev/null 2>&1
  ###################################################################

sodafoundation freespace cleanup tmp dir:
  file.absent:
    - names:
      - /tmp/go?.??.linux-amd64.tar.gz
      - /tmp/saltstack-packages-formula-archives
