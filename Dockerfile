FROM ubuntu:18.04
RUN set -xe \
    && apt -qq update \
    && apt -y -qq upgrade \
    && apt -y -qq install -y apt-utils tzdata locales
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
     && echo $TZ > /etc/timezone
RUN set -xe &&\
    dpkg-reconfigure --frontend=noninteractive tzdata && \
    sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="ru_RU.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=ru_RU.UTF-8

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8



# # Unminimize
RUN yes | unminimize


RUN set -xe \
    && apt -y install vim perl wget tar man sudo adduser netstat-nat net-tools curl w3m git ruby-full build-essential zlib1g-dev make gcc g++ \
    && useradd -m -p "\$6$AyOAQ1vh$CcIXBW4cJopgUVKsTcxlGplUZ382K4yIxIAHhqmEewzJdc6x0MmbSDDQJ1DR.4eueGlYTf2ZbUl9oAQaUQEoi1" -s /bin/bash kdjun97 \
    && usermod -aG sudo kdjun97 \
    && echo "kdjun97 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/kdjun97 \
    && chmod 0440 /etc/sudoers.d/kdjun97 

USER kdjun97:kdjun97

WORKDIR /home/kdjun97

CMD [ "/bin/bash" ]
