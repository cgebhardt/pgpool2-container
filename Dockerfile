# Pgpool2.

FROM ubuntu:16.04

# Install Dependencies.
RUN apt-get update; apt-get install -y wget; wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - ;\
  echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/postgresql.list ;\
  apt-get update && apt-get install -y libffi-dev libssl-dev pgpool2 python python-dev python-pip
RUN pip install Jinja2

# Post Install Configuration.
ADD bin/start-pgpool2 /usr/bin/start-pgpool2
RUN chmod +x /usr/bin/start-pgpool2
ADD conf/pcp.conf.template /usr/share/pgpool2/pcp.conf.template
ADD conf/pgpool.conf.template /usr/share/pgpool2/pgpool.conf.template
ADD conf/pool_hba.conf.template /usr/share/pgpool2/pool_hba.conf.template

# Start the container.
CMD start-pgpool2
