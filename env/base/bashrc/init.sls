/root/.bashrc:
  file.append:
    - text:
      - umask 022
      - PS1="[\[\e[1;31m\]\u\[\e[0;00m\]@\[\e[1;31m\]\H\[\e[0;00m\]]\n \w \[\e[1;31m\]# \[\e[0;00m\]"
