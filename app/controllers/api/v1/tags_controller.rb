class Api::V1::TagsController < ApplicationController
  before_action :set_todo
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /tags
  def index
    if @todo
      @tags = @todo.tags 
    else 
      @tags = Tag.all.order(:id)
    end

    render json: @tags, only: [:id, :name]
  end

  # GET /tags/1
  def show
    render json: @tag, only: [:id, :name]
  end

  # POST /tags
  def create
    if @todo
      if no_todo_tags
        @todo.tags.delete_all
      else
        @todo_tags = []
        todo_tags.each do |t|
          @todo_tags << Tag.find(t)
        end

        @todo.tags = @todo_tags
      end
      render json: @todo,  
          except: [:created_at, :updated_at],
          include: [:tags => {:only => [:id, :name]}]
    else
      @tag = Tag.new(tag_params)

      if @tag.save
        render json: @tag, only: [:id, :name], status: :created
      else
        render json: @tag.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag, only: [:id, :name]
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Set @todo if routed from /api/v1/todos/:todo_id/...
    def set_todo
        @todo = Todo.find(params[:todo_id]) if params.include?(:todo_id)
    end

    def set_tag
      if @todo
        @tag = @todo.tags.find(params[:id])
      else 
        @tag = Tag.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:id, :name)
    end

    def tag_id
      params.require(:tag).permit(:id)
    end

    def todo_tags
      params.require(:tags)
    end

    # Checks if there are todo_tags passed in the params
    # There were some problems with using params.permit(:tags) in todo_tags instead
    def no_todo_tags
      params.require(:empty)
    end
end
