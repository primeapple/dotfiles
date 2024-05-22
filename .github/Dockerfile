FROM archlinux:base

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm fish yadm sudo

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN useradd --create-home --groups wheel --shell /bin/bash primeapple \
    && echo primeapple:password | chpasswd \
    && echo 'primeapple ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

WORKDIR /home/primeapple
COPY yadm-test.sh yadm-test.sh
RUN chmod +x yadm-test.sh && chown primeapple:primeapple yadm-test.sh

USER primeapple
CMD ["./yadm-test.sh"]
