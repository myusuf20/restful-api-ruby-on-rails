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

      private
      def student_params
        params.require(:student).permit(:name, :address)
      end
    end
  end
end
