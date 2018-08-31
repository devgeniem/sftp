if [[ -z "${UPLOADER_SSH_KEY}" ]]; then
  echo $UPLOADER_SSH_KEY > /home/$user/.ssh/keys/uploader_id.rsa
fi
