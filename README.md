![](https://img.shields.io/badge/Microverse-blueviolet)

# TrackLife Api

This is the backend of my TrackLife app which consists of 3 tables, users, units, and measurements.
The API is hosted in Heroku. The base url is https://test-final-api.herokuapp.com and has the following endpoints

- POST /users 
Arguments:
```
{
  name: <username>
  password: <your_password>
}
```
creates a user and responds with:
```
{
  user: {}
  token: user_token
}
```

- POST/login 
Arguments:
```
{
  name: <username>
  password: <your_password>
}
```
Logs in the user and responds with:
```
{
  user: {}
  token: user_token
}
```

- GET /units 
Arguments:
```
headers: {
  Authorization: 'Bearer <token>'
}
```
Returns a list of all the availiable units to measure

-GET /units/:id 
Arguments:
```
headers: {
  Authorization: 'Bearer <token>'
}
```
Returns the unit with :id and a list of its measurements

- GET /measurements
Arguments:
```
headers: {
  Authorization: 'Bearer <token>'
}
```
returns an object with the name of the unit as keys and the list of measurements as values

- POST /units/:unit_id/measurements 
Arguments:
```
headers: {
  Authorization: 'Bearer <token>'
}
body: {
  value: <float>
}
```
Creates a measurement for the corresponding unit

- PUT /units/:unit_id/measurements/:id
Arguments:
```
headers: {
  Authorization: 'Bearer <token>'
}
body: {
  value: <float>
}
```
Updates the value of the given measurement

-DELETE /units/:unit_id/measurements/:id
Arguments:
```
headers: {
  Authorization: 'Bearer <token>'
}
```
Deletes the given measurement


## Built With

- Ruby on Rails

## Getting Started

The project works with the postgresql database
To test the endpoints locally you can use postman, insomia or a similar tool

- `git clone https://github.com/Davidosky007/tracking-api-rails.git`
- `cd tracking-api-rails`
- `bundle install`
- `rails db:create`
- `rails db:migrate`
- `rails db:seed` to populate the database

The authentication uses a environment variable to wotk. To set it up:

- `bundle exec figaro install`
In the `config/application.yml` file that will be created add:
- `SECRET: <your_secret>`

To run the tests:

- `bundle exec rspec`

👤 **David Bassey**

* GitHub: [@davidosky007](https://github.com/davidosky007)
* Twitter: [@davidosky2](https://twitter.com/Davidosky2)
* LinkedIn: [David Bassey](https://www.linkedin.com/in/david-bassey-akan/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- To Microverse for their `README` template.

## 📝 [License]

MIT License
