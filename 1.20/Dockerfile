FROM bitnami/nginx:1.20

#https://forums.docker.com/t/unable-to-find-user-root-no-matching-entries-in-passwd-file/26545/2
# Required to perform privileged actions
USER 0


RUN install_packages \
        git \
        vim \
    ;


####

COPY entrypoint.sh /

#https://github.com/docker-library/postgres/issues/296#issuecomment-308735942
RUN chmod +x /entrypoint.sh

# Revert to the original non-root user
USER 1001

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/nginx/run.sh" ]
