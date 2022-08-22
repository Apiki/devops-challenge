# technical_challenge_03

- Description: [challenge.md](https://github.com/juniormesquitadandao/marcelo-junior/blob/master/challenge.md)

## Architecture

GitHub -> Docker -> Docker Compose -> Linux -> MySQL -> PHP -> Wordpress -> Apache -> Nginx -> WPScan -> Circle CI -> GitHub Webhooks -> AWS (IAM -> CloudWatch -> Codebuild -> CLI -> ECR -> ECS -> ASG -> EC2 -> VPC -> PS -> IG -> SG -> TG -> ALB -> Cloudfront -> R53 -> ACM -> RDS MySQL)

https://technical-challenge-03.jmdcursoaws.tk

## Setup

- Configure host: https://github.com/juniormesquitadandao/gerlessver

```sh
cd marcelo-junior/technical_challenge_03
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

## AWS

```sh
chmod 400 key-pair.pem
ssh -i key-pair.pem ec2-user@ec2-${ipv4}.compute-1.amazonaws.com
yes
  docker exec -it $(docker ps -lq) bash
    exit
  exit
```

