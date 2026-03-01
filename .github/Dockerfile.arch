FROM archlinux:base

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm fish yadm sudo

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN useradd --create-home --groups wheel --shell /bin/bash toni \
    && echo toni:password | chpasswd \
    && echo 'toni ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

WORKDIR /home/toni
COPY yadm-test.sh yadm-test.sh
RUN chmod +x yadm-test.sh && chown toni:toni yadm-test.sh

USER toni
ENV USER=toni
CMD ["./yadm-test.sh"]
