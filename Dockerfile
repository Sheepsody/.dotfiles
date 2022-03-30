FROM silex/emacs:27-alpine-ci-cask

USER root

# Install Doom emacs
RUN rm -rf ~/.emacs.d/ && \
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d

# Copy doom files
COPY .doom.d/ /root/.doom.d/

# Manual install
RUN PATH="$HOME/.emacs.d/bin:$PATH" && \
    doom sync

RUN emacs --batch --eval '(let (all-the-icons-install-fonts))'

RUN apk update \
    && apk add sqlite
