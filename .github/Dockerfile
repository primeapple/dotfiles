FROM archlinux:base

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm fish sudo which yadm

RUN useradd --create-home --groups wheel --password password --shell /bin/bash primeapple

WORKDIR /home/primeapple
COPY yadm-test.sh yadm-test.sh
RUN chmod +x yadm-test.sh && chown primeapple:primeapple yadm-test.sh

USER primeapple
CMD ["echo", "password", "|", "sudo", "-S", "./yadm-test.sh"]
