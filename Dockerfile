ARG PG_MAJOR=15
FROM postgres:$PG_MAJOR
ARG PG_MAJOR

COPY . /tmp/myext

RUN apt-get update && \
		apt-mark hold locales && \
		apt-get install -y --no-install-recommends build-essential postgresql-server-dev-$PG_MAJOR && \
		cd /tmp/myext && \
		make clean && \
		make OPTFLAGS="" && \
		make install && \
		mkdir /usr/share/doc/myext && \
		cp LICENSE README.md /usr/share/doc/myext && \
		rm -r /tmp/myext && \
		apt-get remove -y build-essential postgresql-server-dev-$PG_MAJOR && \
		apt-get autoremove -y && \
		apt-mark unhold locales && \
		rm -rf /var/lib/apt/lists/*
