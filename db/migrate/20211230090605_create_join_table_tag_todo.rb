class CreateJoinTableTagTodo < ActiveRecord::Migration[7.0]
  def change
    create_join_table :tags, :todos, id: false do |t|
      t.belongs_to :tags
      t.belongs_to :todos
    end
  end
end
