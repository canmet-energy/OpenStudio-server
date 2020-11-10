
# AUTHOR:           Phylroy Lopez
# DESCRIPTION:      NRCan OpenStudio Server Docker Container
# TO_BUILD_AND_RUN: docker-compose up
# NOTES:            Currently this is one big dockerfile and non-optimal.

#may include suffix
ARG OPENSTUDIO_VERSION=3.0.1
FROM nrel/openstudio-server:$OPENSTUDIO_VERSION as base
MAINTAINER Phylroy Lopez
#Update CLI to use NRCan branch, the oscli gems are kept in /var/oscli
RUN sed -i '/^.*standards.*$/d' /var/oscli/Gemfile \
&& echo "gem 'openstudio-standards', :github => 'NREL/openstudio-standards', :branch => 'nrcan'" | sudo tee -a /var/oscli/Gemfile \
&& export start=`pwd` && cd /var/oscli/ && bundle update openstudio-standards && cd $start

ENTRYPOINT ["rails-entrypoint"]

CMD ["/usr/local/bin/start-server"]

# Expose ports.
EXPOSE 8080 9090
