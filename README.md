# RMT

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Endpoints

### POST `/api/login`
post data: 
```
{ "student_id": <student_id:string> }
```
returns:
```
{ "access_token": <access_token:string> }
```
Access tokens do not expire and remain consistent across student ids. They are not logged when comments are made.   

### RESOURCE `/api/teachers`:
data format:
```
{
    "id": <id:integer>,
    "name": <name:string>,
    "subject": <subject:string>
}
```

* When creating a teacher, you can POST to `/api/teachers` with the above data format but no "id" field   
```
POST to /api/teachers
Body: 
{
    "teacher": {
        "name": "Mr. Albinson",
        "subject": "Computer Science"
    }
}
Response:
{
    "data": {
        "id": 1,
        "subject": "Computer Science",
        "name": "Mr. Albinson"
    }
}
```
* When editing a teacher, you can POST to `/api/teachers/:id` with the above data format   
```
POST to /api/teachers/1
Body: 
{
    "teacher": {
        "name": "Mr. Albinson",
        "subject": "Computer Science & IT"
    }
}
Response:
{
    "data": {
        "id": 2,
        "subject": "Computer Science & IT",
        "name": "Mr. Albinson"
    }
}
```
* When listing all teachers, you can GET to `/api/teachers` and receive the above data format   
```
GET to /api/teachers
Response: 
{
    "data": [
        {
            "id": 1,
            "name": "Mr. Albinson",
            "subject": "Computer Science"
        }
}
```
* When deleting a teacher, you can DELETE to `/api/teachers/:id`   
```
DELETE to /api/teachers/1
```


### RESOURCE `/api/teachers/:teacher_id/roasts`
data format:
```
{
    "id": <id:integer>,
    "comment": <comment:string, minimum 1 charactor, maximum 1600 characters>,
    "rating": <rating:integer, -5 <= rating <= 5>
}
```
All examples use a teacher with id `1`

* When creating a roast, you can POST to `/api/teachers/:teacher_id/roasts` with the above data format but no "id" field   
```
POST to /api/teachers/1/roasts
Body: 
{
    "roast": {
        "comment": "Albinson is so good dude wow",
        "rating": "5"
    }
}
Response:
{
    "data": {
        "id": 1,
        "comment": "Albinson is so good dude wow",
        "rating": "5"
    }
}
```
* When editing a roast, you can POST to `/api/teachers/:teacher_id/roasts/:id` with the above data format   
```
POST to /api/teachers/1/roasts
Body: 
{
    "roast": {
        "comment": "An absolute prodigy",
        "rating": "5"
    }
}
Response:
{
    "data": {
        "id": 1,
        "comment": "An absolute prodigy",
        "rating": "5"
    }
}
```
* When listing all roasts, you can GET to `/api/teachers/:teacher_id/roasts` and receive the above data format   
```
GET to /api/teachers/1/roasts
Response: 
{
    "data": [
        {
            "id": 1,
            "comment": "Albinson is so good dude wow",
            "rating": "5"
        }
}
```
* When deleting a roast, you can DELETE to `/api/teachers/:teacher_id/roasts/:id`   
```
DELETE to /api/teachers/1/roasts/1
```
