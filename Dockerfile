FROM bash
COPY home_mode_manager.sh /usr/src
RUN mkdir /usr/logs
VOLUME /usr/logs
CMD ["bash", "/usr/src/home_mode_manager.sh"]