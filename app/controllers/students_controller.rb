class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index 
        student = Student.all 
        render json: student
    end

    def show 
        student = Student.find(params[:id])
        render json: student
    end

    def create 
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update 
        student = Student.find_by(id: params[:id])
        if student 
            student.update(student_params)
            render json: student
        else
            render_not_found_response
        end
    end

    def destroy 
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private 

    def student_params 
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
