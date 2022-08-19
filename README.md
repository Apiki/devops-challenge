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
    ./devops/wordpress/setup.sh -t 'My Blog' -u user -p password -e user@email.com
    # browser: http://localhost
    wpscan --url http://localhost
    exit
  ./devops/compose/down.sh
  ./devops/compose/delete.sh
```
