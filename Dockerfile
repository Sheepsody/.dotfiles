FROM silex/emacs:27.1-ci

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

RUN apt-get update && apt-get install sqlite3

