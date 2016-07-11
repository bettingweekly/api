# API
REST API to allow users to retrieve FizzBuzz items and mark them as Favourites that will be persisted to a database. It has been written using Rails 5 and follows the jsonapi conventions.

This API allows you to do the following.
- Find FizzBuzz items from 1 to 100,000,000,000.00
- Paginate through FizzBuzz items
- Find your marked Favourites
- Create new favourites
### Ruby Version
2.3.0

### Rails Version
5.0.0

```

### Run test suite
```sh
$ rails db:migrate RAILS_ENV=test
$ rspec
```

## API Calls

## GET '/v1/fizz_buzz'
Lists FizzBuzz items including marked favourites
#### Optional parameters
| key      | type    | example | validations                | default |
|----------|---------|--------:|----------------------------|---------|
| page     | integer | 10      | Must be greater than ZERO  | 1       |
| per_page | integer | 100     | Must be less than 1000     | 100     |
#### Curl commands
```sh
$ curl -X GET http://localhost:3000/v1/fizz_buzz
$ curl -X GET http://localhost:3000/v1/fizz_buzz?page=2&per_page=2
```
#### Example response
~~~
{
data: [
    {
        id: "3",
        type: "fizz-buzzs",
        attributes: {
            number: 3,
            marked: true,
            result: "fizz"
        }
    },
    {
        id: "4",
        type: "fizz-buzzs",
        attributes: {
            number: 4,
            marked: true,
            result: 4
        }
    }],
links: {
    first: "http://localhost:3000/v1/fizz_buzz?page=1&per_page=2",
    last: "http://localhost:3000/v1/fizz_buzz?page=50000000000&per_page=2",
    next: "http://localhost:3000/v1/fizz_buzz?page=3&per_page=2",
    prev: "http://localhost:3000/v1/fizz_buzz?page=1&per_page=2"}
}
~~~
#### Error Responses
~~~
{
    errors: [
    {
        id: "page",
        title: "Page must be greater than 0"
    },
    {
        id: "per_page",
        title: "Per page must be less than or equal to 1000"
    },
    {
        id: "limit_breached",
        title: "Limit breached response items must be less than or equal to 100000000000"
    }
}
~~~


## GET '/v1/fizz_buzz/favourites'
Lists favourite FizzBuzz items marked by the user

#### Curl commands
```sh
$ curl -X GET http://localhost:3000/v1/fizz_buzz/favourites
```
#### Example response
~~~
{
data: [
    {
        id: "1",
        type: "fizz-buzzs",
        attributes: {
            number: 1,
            marked: true,
            result: 1
        }
    },
    {
        id: "2",
        type: "fizz-buzzs",
        attributes: {
            number: 2,
            marked: true,
            result: 2
        }
    }]
}
~~~

## POST '/v1/fizz_buzz/favourites'
Creates and persists a new favourite number record
#### Required parameters
| key      | type    | example | validations                | default |
|----------|---------|--------:|----------------------------|---------|
| number   | integer | 10      | Must be greater than ZERO  | null    |
#### Curl commands
```sh
$ curl --data "number=2" http://localhost:3000/v1/fizz_buzz/favourites
```
#### Example response
~~~
{ data: {
    id: "201",
    type: "fizz-buzzs",
    attributes: {
        number: 201,
        marked: true,
        result: "fizz"
    }
  }
}
~~~
#### Error Responses
~~~
{
    errors: [
    {
        id: "page",
        title: "Page must be greater than 0"
    },
    {
        id: "per_page",
        title: "Per page must be less than or equal to 1000"
    },
    {   id: "number",
        title: "Number has already been taken"
    }
    {
        id: "number",
        title: "Number can't be blank"
    },
    {
        id: "number",
        title: "Number is not a number"
    },
    {
        id: "number",
        title: "Number must be less than or equal to 100000000000"
    }]
}
~~~