# README

### Rails Initialized
* `rails new -T -C -P --skip-turbolinks DBTaskManager`

### Configure
* `bundle install`
* `yarn install`
* `rails db:create`
* `rails db:migrate`
* `rails db:seed`

### Start Server
* `rails s`

### Heroku Dev Server
* https://donorbox-task-manager.herokuapp.com/

### Tasks
* [x] Users should be able to create an account and receive a confirmation e-mail.
* [x] After the e-mail is confirmed, send this account data to ActiveCampaign CRM as a contact using their API, also recording the active campaign contact id in our database, so we can track it in the future. The created contact needs to be subscribed to the list with ID 1
* [x] Users needs to be able to sign out and sign-in again to the application
* [x] The first logged page of this application will be a task manager dashboard, from where the user should be able to reach the forms to create, update or delete tasks. For now, the tasks need only to have a title and a status (Open, Work in Progress, Closed)
* [x] On this dashboard, the user needs to be able to filter the list of tasks searching by status, creation date, and task title (case insensitive)
* [x] Add ActiveCampaign tag "First task created" after the user creates the first task (Tag ID: 1), making sure duplicated integrations will not occur in the case the user deletes all the tasks and create the "first" task record again
* [x] The application needs to be done using Ruby and be deployed at Heroku.
