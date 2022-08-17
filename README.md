# technical_challenge_03

## Setup

- Configure host: https://github.com/juniormesquitadandao/gerlessver

```sh
cd technical_challenge_03
  chmod +x devops/**/*.sh
  ./devops/compose/config.sh
  ./devops/compose/build.sh
  ./devops/compose/up.sh
  ./devops/compose/exec.sh app bash
    php -v
    exit
  ./devops/compose/down.sh
  ./devops/compose/delete.sh
```
