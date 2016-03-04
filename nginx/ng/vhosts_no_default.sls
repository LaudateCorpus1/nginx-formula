# nginx.ng.vhosts_no_default
#
# Removes the default vhost

{% from 'nginx/ng/map.jinja' import nginx with context %}
{% from 'nginx/ng/vhosts_config.sls' import vhost_states with context %}
{% from 'nginx/ng/service.sls' import service_function with context %}

vhost_default:
  file.absent:
    - name: /etc/nginx/sites-enabled/default

include:
  - nginx.ng.service
  
nginx_service_reload:
  service.{{ service_function }}:
    - name: {{ nginx.lookup.service }}
    - reload: True
    - use:
      - service: nginx_service
    - watch:
      - file: vhost_default
    - require:
      - service: nginx_service
