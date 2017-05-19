# RMT

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Endpoints

POST `/api/login`
post data: 
```
{ "student_id": <student_id:string> }
```
returns:
```
{ "access_token": <access_token:string> }
```
Access tokens do not expire and remain consistent across student ids. They are not logged when comments are made.

RESOURCE `/api/teachers`:
data format:
```
{
    "id": <id:integer>,
    "name": <name:string>,
    "subject": <subject:string>
}
```

When creating a teacher, you can POST to `/api/teachers` with the above data format but no "id" field   
When editing a teacher, you can POST to `/api/teachers/:id` with the above data format   
When listing all teachers, you can GET to `/api/teachers` and receive the above data format   
When deleting a teacher, you can DELETE to `/api/teachers/:id`   