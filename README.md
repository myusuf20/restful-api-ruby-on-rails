# Restful API Ruby on Rails

In this time I will create a simple Restful API with the Ruby on Rails framework.

## Preparation

* Use [Postman](https://www.postman.com/downloads/) for test your API
* Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible.

## Installation Ruby on Rails

Because we only create a simple Restful API, so what we run is the following command to create a project Ruby on Rails.

```bash
rails new project-name --api -T
```
This means that we will create a project only for the API without unit tests.

## Configure
Activate Rack CORS on Rails to get our API. The easiest way to configure CORS on your Rails app is to use rack-cors gem. You can install it like any other gem, by executing:

```bash
gem install rack-cors
```
or by adding the following line into your Gemfile:
```ruby
gem 'rack-cors'
```
Next, you need to provide the configuration for the gem. You need to inform Rails which origin it should allow. To do that, you need to create a new initializer for your application.

The content of the **config/initializers/cors.rb** should be the following:
```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "https://examples.com" ## or '*' if the API used is only for localhost.

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```


## Restful API as student example

create a model student with the attribute name, and address
```bash
rails generate model Student name: string address: text
```
create a students controller as follow
```bash
rails generate controller students
```
on the directory controller create a new directory as follows **"api/v1"** and move file **student_controllers.rb** to that directory. Next, change the command in the **students_controller** file to
```ruby
module Api
  module V1
    class StudentsController < ApplicationController
      def index
        @students = Student.all
        render json: @students
      end

      def show
        @student = Student.find(params[:id])
        render json: @student
      end

      def create
        @student = Student.new(student_params)

        if @student.save
          render json: @student
        else
          render json: @student.errors, status: :unprocessable_entity
        end
      end

      def update
        @student = Student.find(params[:id])

        if @student.update(student_params)
          render json: @student
        else
          render json: @student, status: :unprocessable_entity
        end
      end

      def destroy
        @student = Student.find(params[:id])

        if @student.present?
          @student.destroy
          render json: @student
        else
          render json: { error: 'Student not found' }
        end
      end

      private
      def student_params
        params.require(:student).permit(:name, :address)
      end
    end
  end
end
```
Next, do API testing (GET, POST, PUT, DELETE) with Postman and check whether **"localhost/api/v1/students"** run well or not.