# technical_challenge_03

## Setup

- Configure host: https://github.com/juniormesquitadandao/gerlessver

```sh
cd technical_challenge_03
  chmod +x devops/**/*.sh
  ./devops/compose/config.sh
  ./devops/compose/build.sh
  ./devops/compose/up.sh
  ./devops/compose/install.sh -t 'My Blog' -u user -p password -e user@email.com
  # browser: http://localhost:8000
  ./devops/compose/exec.sh app bash
    wpscan --url localhost
    exit
  ./devops/compose/down.sh
  ./devops/compose/delete.sh
```
