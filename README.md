<img src="https://github.com/yhirano55/ama/blob/master/app/assets/images/logo.png?raw=true" width="255" height="80" alt="">

Rails Application for Ask Me Anything. This app is aim to take questions and feedbacks from audience.

## Dependencies

- Ruby 2.5.0
- Ruby on Rails 5.2.0.rc1
- Yarn 1.3.2
- Stimulus 1.0.1
- Postgresql 9.6.3
- cmake

## Getting started

### on local

```
$ bin/setup
$ bin/rails s
```

### on docker

```
$ docker-compose build
$ docker-compose run app rails db:create db:migrate db:seed
$ docker-compose up
```

## License

The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
